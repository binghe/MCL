/*
  Lisp data loading & saving.
*/

/*
  01/29/97  gb    initialize load_error_message (not sure if necessary - GCC/PPCLink screw.)
  ------------    4.0
  10/01/96 bill   At the end of relocate_compressed_heap:
                  "!relocate_subprim_call(start)" => "!relocate_subprim_call(start++)"
  ------------    4.0b2
  07/31/96  gb    missing 'break' in output_compressed_node caused grief and woe.
  05/30/96  gb    handle excised_code areas.  Handle compressed data.
  05/17/96  gb    typo & fencepost in relocate_uncompressed_segment.  Initialize subprims_bias
                  after call to apply_relocs.
  05/12/96  gb    new file.
  --- 3.9 ---
*/

#include "lisp.h"
#include "lisp_globals.h"
#include "gc.h"
#include "area.h"
#include "lisp-exceptions.h"
#include "loader.h"
#include <stdlib.h>
#include <stdio.h>
#include <setjmp.h>
#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <Files.h>
#include <Errors.h>
#endif

jmp_buf escape = {0};

StringPtr
load_error_message = NULL;

void
io_error()
{
  load_error_message = "\pI/O error reading lisp data.";
  longjmp(escape, lisp_load_error);
}



OSErr
check_header(lisp_data_header *header)
{
  area *a = active_dynamic_area;
  unsigned data_length = header->logsize;

  if ((header->sig0 != header_sig0) ||
      (header->sig1 != header_sig1)) {
    load_error_message = "\pinvalid lisp data header.";
    return lisp_load_error;
  }

  if (header->header_version != current_header_version) {
    load_error_message = "\plisp data header: wrong version.";
    return lisp_load_error;
  }
  
  if (data_length >= (a->high - a->low)) {
    load_error_message = "\plisp data won't fit in lisp heap.";
    return lisp_load_error;
  }
  return noErr;
}

area *
find_current_area(area_code code, unsigned libnum)
{
  area *a;

  for (a = active_dynamic_area; (a->code != AREA_VOID); a = a->succ) {
    if ((a->code == code) && (a->owner == libnum)) {
      return a;
    }
  }
  return NULL;
}

void
apply_relocs(phys_data_area *relocbase, int n)
{
  int i, next, libnum, type;
  phys_data_area *r;
  area *a;
  BytePtr base;
  area_code code;

  for (i = 0; i < n; i++) {
    r = relocbase+i;
    type = r->logical_section;
    libnum = type >> 3;
    type &= 7;
    next = r->u.next;
    if (type != logical_section_none) {
      r->logical_section = logical_section_none; /* mark section as "processed" */
      if (type == logical_section_subprims) {
        base = (BytePtr) lisp_global(SUBPRIMS_BASE);
      } else {
        if (type == logical_section_nilreg_area) {
          a = nilreg_area;
        } else {
          if (type == logical_section_application_data) {
            a = active_dynamic_area;
          } else {
            switch (type) {
            case logical_section_application_code:
            case logical_section_lib_code:
              code = AREA_READONLY;
              break;
            case logical_section_lib_static:
              code = AREA_STATIC;
              break;
            case logical_section_lib_staticlib:
              code = AREA_STATICLIB;
              break;
            }
            a = find_current_area(code, libnum);
          }
        }
        base = a->low;
      }    
      r->u.bias = ((int) base - (int)(r->start));
      base += (r->end - r->start);
      while (next) {
        r = relocbase + next;
        r->logical_section = logical_section_none;
        next = r->u.next;
        r->u.bias = ((int) base - (int)(r->start));
        base += (r->end - r->start);
      }
    } else {
      /* Type was 0 (logical_section_none) ; if libnum is non-zero, we're
         really talking about a reference to an excised code section.
         Set the bias to the runtime value of the excised code vector object.
         Leave the phys_area's type field alone. 
         */
      if (libnum) {
        r->u.bias = (int) nrs_EXCISED_CODE.vcell;
      }
    }
  }
}
      
LispObj
nextword(FILE *f)
{
  union {
    unsigned char _c[4];
    LispObj l;
  } u;
  u._c[0] = getc(f);
  u._c[1] = getc(f);
  u._c[2] = getc(f);
  u._c[3] = getc(f);
  return u.l;
}

phys_data_area *loader_relocs = NULL;
int num_loader_relocs = 0;
int subprims_bias = 0;

LispObj
relocate_lisp_word(LispObj w)
{
  phys_data_area *r = loader_relocs;

  switch (fulltag_of(w)) {
  case fulltag_nil:
    return lisp_nil;
    break;
    
  case fulltag_even_fixnum:
  case fulltag_odd_fixnum:
  case fulltag_imm:
    return w;
    
  case fulltag_immheader:
  case fulltag_nodeheader:
    Bug("Header not expected while loading lisp data!");
    return w;
    
  default:                      /* fulltag_cons, fulltag_misc */
    {
      int i;
      for (i = 0; i < num_loader_relocs; i++, r++) {
        if ((w > r->start) && (w < r->end)) {
          if (r->logical_section != logical_section_none) {
            return nrs_EXCISED_CODE.vcell;
          }
          return (w + r->u.bias);
        }
      }
      if (fulltag_of(w) == fulltag_cons) {
        return lisp_nil;
      }
      return nrs_EXCISED_CODE.vcell;
    }
  }
}
 

/* returns false if traceback table encountered, true otherwise */
Boolean
relocate_subprim_call(LispObj *ref)
{
  LispObj w = *ref;
  
  if (w == 0) {
    return false;
  }
  
  if ((w & BA_MASK) == BA_VAL) {
    *ref = (w + subprims_bias);
  }
  return true;
}

unsigned char *
relocate_compressed_node(unsigned char *bufP, LispObj *dest)
{
  LispObj val;
  unsigned char b, b0;
  signed char c;
  signed short w;
  int i;
  compressed_node n;

  b0 = *bufP++;
  if (comp_p(b0)) {
    if (comp_header_p(b0)) {
      Bug("Header not expected in this context!");
    }
    switch (b0) {
    case compressed_nil:
      val = lisp_nil;
      break;
      
    case compressed_undefined:
      val = undefined;
      break;

    case compressed_undefined_function:
      val = nrs_UDF.vcell;
      break;

    case compressed_zero:
      val = 0;
      break;

    case compressed_byte_fixnum:
      b = *bufP++;
      c = b;
      val = (LispObj) (((int)c) << fixnumshift);
      break;

    case compressed_byte_relative_cons:
    case compressed_byte_relative_misc:
      b = *bufP++;
      c = b;
      i = (int) c;
      val = (untag((LispObj)dest) - (i << 3)) | 
        ((b0 == compressed_byte_relative_cons) ? fulltag_cons : fulltag_misc);
      break;

    case compressed_halfword_relative_cons:
    case compressed_halfword_relative_misc:
      b = *bufP++;              /* low byte */
      c = b;
      b = *bufP++;              /* high byte */
      w = (b << 8) | (c & 0xff);
      i = (int) w;
      val = (untag((LispObj)dest) - (i << 3)) |
        ((b0 == compressed_halfword_relative_cons) ? fulltag_cons : fulltag_misc);
      break;

    case compressed_next_cons:
      val = (untag((LispObj)dest))+8+fulltag_cons;
      break;

    case compressed_prev_cons:
      val = (untag((LispObj)dest))-(8-fulltag_cons);
      break;
    }
  } else {                      /* not compressed */
    n.u.bytes[3] = b0;
    n.u.bytes[2] = *bufP++;
    n.u.bytes[1] = *bufP++;
    n.u.bytes[0] = *bufP++;
    val = relocate_lisp_word(n.u.node);
  }
  *dest = val;
  return bufP;
}
      
unsigned char *
byte_blt(unsigned char *src, unsigned char *dest, unsigned n)
{
  while (n--) {
    *dest++ = *src++;
  }
  return src;
}

OSErr
relocate_compressed_heap(unsigned char *bufP, LispObj *start, LispObj *end)
{
  unsigned char b0, *work;
  lispsymbol *symp;
  double_float *dfloat;
  int tag, subtag, elements, nbytes;
  LispObj header, *next;
  compressed_node n;

  while (start < end) {
    /* Read a byte from the compression buffer.  It may or may not be a compression
       opcode.  If it isn't, it may or may not be a header.
       If the first byte's a compressed node opcode, uncompress it and the next word.
       If the first byte's a compressed header opcode, there are a few special cases.
         Treat the special cases specially, otherwise behave as if a (node,imm)header
         was read.
       If the first byte's not a compression opcode, read the compressed node. If it's
       a node or immheader, handle those cases, otherwise relocate the node and read
       another.

       If it sounds like this is fencepost-ridden and hard to structure, it is.
       */

    b0 = *bufP++;
    tag = fulltag_of(b0);

    if (comp_node_p(b0) || 
        ((! comp_header_p(b0)) && 
         (tag != fulltag_nodeheader) && 
         (tag != fulltag_immheader))) {
      bufP = relocate_compressed_node(bufP-1, start++);
      bufP = relocate_compressed_node(bufP, start++);
    } else {
      /* A few -very- special cases come first. */
      if (b0 == compressed_double_float) {
        dfloat = (double_float *) start;
        dfloat->header = make_header(subtag_double_float, 3);
        dfloat->pad = 0;
        bufP = byte_blt(bufP, (unsigned char *)(&(dfloat->value_high)), 8);
        start = (LispObj *) (dfloat+1);
      } else {
        /* Some other symbol cases are worth treating specially.
           Keywords that have no plists or function bindings need only
           encode the keyword's pname.  We could also note those symbols
           that have no function and/or value bindings and save a byte
           or two that way. */
        if (b0 == compressed_keyword) {
          symp = (lispsymbol *)start;
          symp->header = make_header(subtag_symbol, 5);
          bufP = relocate_compressed_node(bufP, &(symp->pname));
          symp->vcell = ((LispObj)symp) + fulltag_misc;
          symp->fcell = nrs_UDF.vcell;
          symp->package_plist = nrs_KEYWORD_PACKAGE.vcell;
          symp->flags = (18 << fixnumshift);
          start = (LispObj *) (symp+1);
        } else {
          if (! comp_header_p(b0)) {
            n.u.bytes[3] = b0;
            n.u.bytes[2] = *bufP++;
            n.u.bytes[1] = *bufP++;
            n.u.bytes[0] = *bufP++;
          } else {
            n.u.node = 0;
            switch (b0) {
            case compressed_8bit_function:
            case compressed_16bit_function:
              n.u.bytes[3] = subtag_function;
              n.u.bytes[2] = *bufP++;
              if (b0 == compressed_16bit_function) {
                n.u.bytes[1] = *bufP++;
              }
              break;

            case compressed_8bit_simple_vector:
            case compressed_16bit_simple_vector:
              n.u.bytes[3] = subtag_simple_vector;
              n.u.bytes[2] = *bufP++;
              if (b0 == compressed_16bit_simple_vector) {
                n.u.bytes[1] = *bufP++;
              }
              break;

            case compressed_8bit_simple_base_string:
            case compressed_16bit_simple_base_string:
              n.u.bytes[3] = subtag_simple_base_string;
              n.u.bytes[2] = *bufP++;
              if (b0 == compressed_16bit_simple_base_string) {
                n.u.bytes[1] = *bufP++;
              }
              break;
              
            case compressed_8bit_vector:
            case compressed_16bit_vector:
              n.u.bytes[3] = *bufP++;
              n.u.bytes[2] = *bufP++;
              if (b0 == compressed_16bit_vector) {
                n.u.bytes[1] = *bufP++;
              }
              break;

            case compressed_symbol:
              n.u.bytes[3] = subtag_symbol;
              n.u.bytes[2] = 5;
              break;
            }
            tag = fulltag_of(n.u.bytes[3]);
          }
          header = n.u.node;
          *start++ = header;
          subtag = header_subtag(header);
          elements = header_element_count(header);

          if (tag == fulltag_nodeheader) {
            next = (start + (elements|1));
            while (elements--) {
              bufP = relocate_compressed_node(bufP, start++);
            }
            if (((int)start & 7)) {
              *start++ = 0;
            }
          } else {
            if (subtag <= max_32_bit_ivector_subtag) {
              nbytes = elements << 2;
            } else if (subtag <= max_8_bit_ivector_subtag) {
              nbytes = elements;
            } else if (subtag <= max_16_bit_ivector_subtag) {
              nbytes = elements << 1;
            } else if (subtag == subtag_double_float_vector) {
              nbytes = 4 + (elements << 3);
            } else {
              nbytes = (elements+7) >> 3;
            }
            
            work = (unsigned char *) start;
            bufP = byte_blt(bufP, work, nbytes);
            work += nbytes;
            while ((int)work & 7) {
              *work++ = 0;
            }
            next = (LispObj *) work;

            if (subtag == subtag_code_vector) {
              while (start < next) {
                if (!relocate_subprim_call(start++)) {
                  break;
                }
              }
            }
          }
          start = next;
        }
      }
    }
  }
  return noErr;
}

unsigned
relocate_uncompressed_segment(short refnum, 
                              unsigned dwords, 
                              LispObj *start, 
                              LispObj *end, 
                              unsigned *stateP)
{
  int  tag, subtag, nwords, elements;
  unsigned state = *stateP;
  LispObj header, *nextp = start+1;
  long iobytes;

  iobytes = (BytePtr)end - (BytePtr)start;
  if (FSRead(refnum, &iobytes, start) != noErr) {
    io_error();
  }

  while (start < end) {
    switch(state) {
    case relocation_state_header:
      header = *start;
      tag = fulltag_of(header);
      switch(tag) {
      case fulltag_nodeheader:
        elements = header_element_count(header);
        dwords = (elements+2)>>1;
        if (header_subtag(header) == subtag_hash_vector) {
          state = relocation_state_hash_vector;
        } else {
          state = relocation_state_gvector;
        }
        *nextp = relocate_lisp_word(*nextp);
        break;
        
      case fulltag_immheader:
        elements = header_element_count(header);
        subtag = header_subtag(header);
        if (subtag <= max_32_bit_ivector_subtag) {
          nwords = elements;
        } else if (subtag <= max_8_bit_ivector_subtag) {
          nwords = (elements + 3) >> 2;
        } else if (subtag <= max_16_bit_ivector_subtag) {
          nwords = (elements+1) >> 1;
        } else if (subtag == subtag_double_float_vector) {
          nwords = 1 + (elements << 1);
        } else {
          nwords = (elements+31) >> 5;
        }
        dwords = (nwords+2)>>1;
        state = relocation_state_ivector;
        if (subtag == subtag_macptr) {
          *start = make_header(subtag_dead_macptr, elements);
        } else if (subtag == subtag_code_vector) {
          if (relocate_subprim_call(nextp)) {
            state = relocation_state_code_vector;
          }
        }
        break;

      default:                  /* Not a header, just a cons */
        *start = relocate_lisp_word(header);
        *nextp = relocate_lisp_word(*nextp);
        dwords = 1;
        break;
        
      }
      break;

    case relocation_state_hash_vector:
      /* 'flags' word is at the start of the first doubleword after the one
         which contained the header.  Note key movement if tracking key movement. */
      if ((*start) & nhash_track_keys_mask) {
        *start |= nhash_key_moved_mask;
      }
      *nextp = relocate_lisp_word(*nextp);
      state = relocation_state_gvector;
      break;

    case relocation_state_gvector:
      *start = relocate_lisp_word(*start);
      *nextp = relocate_lisp_word(*nextp);
      break;

    case relocation_state_code_vector:
      if ((!relocate_subprim_call(start)) ||
          (!relocate_subprim_call(nextp))) {
        state = relocation_state_ivector;
      }
      break;

    case relocation_state_ivector:
      /* Do nothing. */
      break;
    }
        
    start += 2;
    nextp += 2;
    if (--dwords == 0) {
      state = relocation_state_header;
    }
  }
  *stateP = state;
  return dwords;
}

OSErr
relocate_uncompressed_heap(short refnum, LispObj *start, LispObj *end)
{
  unsigned dwords = 0, state = relocation_state_header;
  OSErr err;
  LispObj *pivot;

  err = setjmp(escape);
  if (err == noErr) {
    /* When running under VM, might actually want to do this 
       in smallish chunks.  VM, of course, blows big chunks. */
    while (start < end) {
      pivot = start+(1<<17);
      if (pivot > end) {
        pivot = end;
      }
      dwords = relocate_uncompressed_segment(refnum, dwords, start, pivot, &state);
      start = pivot;
    }
  }
  return err;
}

void
set_heap_limit(ExceptionInformation *, BytePtr);

OSErr 
load_application_data(area *a, short refnum, long pos)
{
  OSErr err;
  char buf[1024];
  lisp_data_header *data_header;
  phys_data_area *relocs;
  long count;
  lispsymbol *sym;

  unprotect_area(a->softprot);

  err = SetFPos(refnum, fsFromStart, pos);
  if (err != noErr) return err;

  count = 1024;
  err = FSRead(refnum, &count, buf);
  if (err != noErr) return err;

  data_header = (lisp_data_header *) buf;
  if ((err = check_header(data_header)) != noErr) return err;
  relocs = &(data_header->phys_areas[0]);

  apply_relocs(relocs, data_header->nphys);
  subprims_bias = relocs[0].u.bias;
  /* Skip over the subprims physical area */
  num_loader_relocs = (data_header->nphys)-1;
  loader_relocs = relocs+1;
  a->active += data_header->logsize;

  /* The only region of memory that PEF has loaded that contains relocatable references
     is the part of nilreg space > lisp_nil.
     
     That might someday change (if libraries ever contain nontrivial data.)
     */
  
  for (sym = &(nrs_T); sym < (lispsymbol *)nilreg_symbols_end; sym++) {
    sym->pname = relocate_lisp_word(sym->pname);
    sym->vcell = relocate_lisp_word(sym->vcell);
    sym->fcell = relocate_lisp_word(sym->fcell);
    sym->package_plist = relocate_lisp_word(sym->package_plist);
  }

  if (data_header->logsize != data_header->physsize) {
    int total = data_header->physsize;
    long iobytes;
    unsigned char *bufstart = (unsigned char *) (a->active-total), *bufp = bufstart;

    while (total) {
      iobytes = 1<<17;
      if (iobytes > total) {
        iobytes = total;
      }
      err = FSRead(refnum, &iobytes, bufp);
      if (err != noErr) {
        io_error();
      }
      total -= iobytes;
      bufp += iobytes;
    }
    err = relocate_compressed_heap(bufstart, (LispObj *) a->low, (LispObj *) a->active);
    if (err != noErr) return err;
  } else {
    err = relocate_uncompressed_heap(refnum, (LispObj *) a->low, (LispObj *) a->active);
    if (err != noErr) return err;
  }

  MakeDataExecutable(a->low, a->active - a->low);
    
  set_heap_limit(NULL, a->active);
  return noErr;
}



phys_data_area *
note_phys_area(lisp_data_header *header, LispObj start, LispObj end, unsigned section_code)
{
  phys_data_area *r = (header->phys_areas)+(header->nphys);
  header->nphys++;

  r->start = start;
  r->end = end;
  r->u.next = 0;
  r->logical_section = section_code;
  return r;
}

phys_data_area *
augment_phys_area(phys_data_area *r, 
                  lisp_data_header *header, 
                  LispObj start, 
                  LispObj end, 
                  unsigned section_code)
{
  r->u.next = header->nphys;
  return note_phys_area(header, start, end, section_code);
}

void
note_area_list(lisp_data_header *h, area_list *l, unsigned section_code)
{
  area *a;
  phys_data_area *r;

  if (l) {
    a = l->area;
    l = l->next;
    r = note_phys_area(h, (LispObj)a->low, (LispObj)a->active, section_code);
    
    while (l) {
      a = l->area;
      l = l->next;
      r = augment_phys_area(r, h, (LispObj)a->low, (LispObj)a->active, section_code);
    }
  }
}

area_list *
collect_area_list(area_list *old, area_code code, unsigned owner, Boolean handle_p)
{
  area_list *new = old;
  area *a = active_dynamic_area;
  Boolean area_has_handle;

  do {
    area_has_handle = (a->h != NULL);
    if ((a != nilreg_area) &&
        (a->ndwords != 0) &&
        (a->code == code) && 
        (a->owner == owner) && 
        (area_has_handle == handle_p)) {
      new = (area_list *) alloc_ptr_critical(sizeof(area_list), false);
      new->area = a;
      new->next = old;
      old = new;
    }
    a = a->succ;
  } while (a->code != AREA_VOID);
  return new;
}

void
free_area_list(area_list *l)
{
  if (l) {
    free_area_list(l->next);
    DisposePtr((Ptr)l);
  }
}

OSErr
write_uncompressed_data(short refnum, lisp_data_header *header, area_list *l)
{
  OSErr err;
  long count;
  int size = 0;
  area_list *q;
  area *a;
  BytePtr buf;
  
  for (q = l; q; q = q->next) {
    a = q->area;
    size += (a->active) - (a->low);
  }

  header->logsize = header->physsize = size;

  count = 1024;
  err = FSWrite(refnum, &count, header);

  for (q = l; q; q = q->next) {
    a = q->area;
    size = (a->active) - (a->low);
    buf = a->low;
    while (size) {
      count = 0x8000;
      if (count > size) {
        count = size;
      }
      err = FSWrite(refnum, &count, buf);
      if (err != noErr) {
        return err;
      }
      buf += count;
      size -= count;
    }
  }
  return noErr;
}

unsigned char *output_buffer_start = NULL, 
  *output_buffer_ptr = NULL, *output_buffer_limit = NULL;

unsigned
compressed_byte_count = 0;

short
data_refnum = 0;

void
flush_output_buffer()
{
  long count = output_buffer_ptr - output_buffer_start;
  PEF_write(data_refnum, &count, output_buffer_start);
  output_buffer_ptr = output_buffer_start;  
}

void
setup_compressed_output(short refnum, unsigned char *buf, unsigned bufsize)
{
  data_refnum = refnum;
  output_buffer_start = output_buffer_ptr = buf;
  output_buffer_limit = output_buffer_start+bufsize;
  compressed_byte_count = 0;
}

void
out_byte(unsigned char c)
{
  if (output_buffer_ptr == output_buffer_limit) {
    flush_output_buffer();
  }
  *output_buffer_ptr++ = c;
  compressed_byte_count++;
}

void
out_n_bytes(unsigned char *from, unsigned n)
{
  while (n--) {
    out_byte(*from++);
  }
}

/* nodes & headers are written tag-byte first. */
void
output_reversed_object(LispObj node)
{
  compressed_node n;

  n.u.node = node;
  out_byte(n.u.bytes[3]);
  out_byte(n.u.bytes[2]);
  out_byte(n.u.bytes[1]);
  out_byte(n.u.bytes[0]);
}


void
output_compressed_node(LispObj *where, LispObj low, LispObj high)
{
  LispObj node = *where;
  int diff, tag = fulltag_of(node);

  if (node == lisp_nil) {
    out_byte(compressed_nil);
  } else if (node == undefined) {
    out_byte(compressed_undefined);
  } else if (node == 0) {
    out_byte(compressed_zero);
  } else if (node == nrs_UDF.vcell) {
    out_byte(compressed_undefined_function);
  } else {    
    switch (tag) {
    case fulltag_even_fixnum:
    case fulltag_odd_fixnum:
      diff = ((int)node) >> fixnumshift;
      if (diff == (signed char)diff) {
        out_byte(compressed_byte_fixnum);
        out_byte(diff & 0xff);
        return;
      }
      break;

    case fulltag_cons:
      /* The cons cell in the previous/next doubleword can be encoded in 1 byte */
      if ((untag((LispObj)where)+8+fulltag_cons) == node) {
        out_byte(compressed_next_cons);
        return;
      }
      if ((untag((LispObj)where)-8+fulltag_cons) == node) {
        out_byte(compressed_prev_cons);
        return;
      }
      /* Else fall thru: */

    case fulltag_misc:
      if ((node > low) && (node < high)) {
        diff = (((int)(untag((LispObj)where))) - (int)(untag(node)))>>3;
        if (diff == (signed short) diff) {
          if (diff == (signed char) diff) {
            out_byte((tag == fulltag_cons) ? 
                     compressed_byte_relative_cons : compressed_byte_relative_misc);
            out_byte(diff & 0xff);
          } else {
            out_byte((tag == fulltag_cons) ? 
                     compressed_halfword_relative_cons : compressed_halfword_relative_misc);
            out_byte(diff & 0xff);
            out_byte((diff >> 8) & 0xff);
          }
          return;
        }
      }
      break;
    }
    output_reversed_object(node);
  }
}

void
output_compressed_range(LispObj *start, LispObj *end)
{
  LispObj header, low = (LispObj)start, high = (LispObj)end;
  int tag, subtag, elements, nbytes;
  lispsymbol *symp;
  unsigned char *work;

  while (start < end) {
    header = *start;
    tag = fulltag_of(header);
    if ((tag != fulltag_nodeheader) &&
        (tag != fulltag_immheader)) {
      output_compressed_node(start++, low, high);
      output_compressed_node(start++, low, high);
    } else {
      subtag = header_subtag(header);
      if (subtag == subtag_macptr) {
        subtag = subtag_dead_macptr;
      }
      elements = header_element_count(header);
      if (subtag == subtag_double_float) {
        out_byte(compressed_double_float);
        work = (unsigned char *) (start+2);
        out_n_bytes(work, 8);
        start += 4;
      } else if (subtag == subtag_symbol) {
        symp = (lispsymbol *) start;
        if ((symp->flags == (18 << fixnumshift)) &&
            (symp->package_plist == nrs_KEYWORD_PACKAGE.vcell) &&
            (symp->fcell == nrs_UDF.vcell) &&
            (symp->vcell == (((LispObj)symp) + fulltag_misc))) {
          out_byte(compressed_keyword);
          output_compressed_node(&(symp->pname), low, high);
        } else {
          out_byte(compressed_symbol);
          output_compressed_node(&(symp->pname), low, high);
          output_compressed_node(&(symp->vcell), low, high);
          output_compressed_node(&(symp->fcell), low, high);
          output_compressed_node(&(symp->package_plist), low, high);
          output_compressed_node(&(symp->flags), low, high);
        }
        start = (LispObj *) (symp+1);
      } else {
        /* Neither a double float or a symbol.  The header might something
           that could be compactly represented.  Write it, then write
           the node/imm object that follows.
           */
        if (elements <= 0xff) {
          switch (subtag) {
          case subtag_simple_vector:
            out_byte(compressed_8bit_simple_vector);
            break;
            
          case subtag_simple_base_string:
            out_byte(compressed_8bit_simple_base_string);
            break;
            
          case subtag_function:
            out_byte(compressed_8bit_function);
            break;

          default:
            out_byte(compressed_8bit_vector);
            out_byte(subtag);
            break;
          }
          out_byte(elements);
        } else if (elements <= 0xffff) {
          switch (subtag) {
          case subtag_simple_vector:
            out_byte(compressed_16bit_simple_vector);
            break;

          case subtag_simple_base_string:
            out_byte(compressed_16bit_simple_base_string);
            break;
            
          case subtag_function:
            out_byte(compressed_16bit_function);
            break;
            

          default:
            out_byte(compressed_16bit_vector);
            out_byte(subtag);
            break;
          }
          out_byte(elements & 0xff);
          out_byte((elements >> 8) & 0xff);
        } else {
          output_reversed_object(header);
        }
        if (subtag == subtag_hash_vector) {
          hash_table_vector_header *hashp = (hash_table_vector_header *) start;
          if (hashp->flags & nhash_track_keys_mask) {
            hashp->flags |= nhash_key_moved_mask;
          }
        }
        start++;
        if (tag == fulltag_nodeheader) {
          while (elements--) {
            output_compressed_node(start++, low, high);
          }
          if (((int)start) & 7) {
            start++;
          }
        } else {
          if (subtag <= max_32_bit_ivector_subtag) {
            nbytes = elements << 2;
          } else if (subtag <= max_8_bit_ivector_subtag) {
            nbytes = elements;
          } else if (subtag <= max_16_bit_ivector_subtag) {
            nbytes = elements << 1;
          } else if (subtag == subtag_double_float_vector) {
            nbytes = 4 + (elements << 3);
          } else {
            nbytes = (elements+7) >> 3;
          }

          work = (unsigned char *) start;
          out_n_bytes(work, nbytes);
          work += nbytes;
          start = (LispObj *) ((((int) work) + 7) & ~7);
        }
      }
    }
  }
}

OSErr
write_compressed_data(short refnum, lisp_data_header *header, area_list *l)
{
  long count, headerpos, eofpos;
  int size = 0;
  area_list *q;
  area *a;
  protected_area_ptr p;

  for (q = l; q; q = q->next) {
    a = q->area;
    size += (a->active) - (a->low);
  }

  header->logsize = size;
  count = 1024;
  PEF_getpos(refnum, &headerpos);
  PEF_write(refnum, &count, header);

  a = active_dynamic_area;
  p = a->hardprot;
  unprotect_area(p);  /* shouldn't have been write-protected, but */
  setup_compressed_output(refnum, (unsigned char *)p->start, p->end-p->start);

  while (l) {
    a = l->area;
    output_compressed_range((LispObj *)a->low, (LispObj *)a->active);
    l = l->next;
  }
  flush_output_buffer();

  PEF_getpos(refnum, &eofpos);
  PEF_setpos(refnum, fsFromStart, headerpos);
  header->physsize = compressed_byte_count;
  count = 1024;

  PEF_write(refnum, &count, header);
  PEF_seteof(refnum, eofpos);
  
  a = active_dynamic_area;
  set_heap_limit(NULL, a->active);
  return noErr;
}

OSErr
save_application_data(short refnum, Boolean compressed)
{
  extern unsigned next_libnum;
  char buf[1024];
  lisp_data_header *data_header = (lisp_data_header *) buf;
  area_list *l;
  int libnum;
  OSErr err = paramErr;

#if 1
  compressed = true;
#endif

  memset(buf, 0, sizeof(buf));
  data_header->sig0 = header_sig0;
  data_header->sig1 = header_sig1;
  data_header->header_version = current_header_version;
  data_header->numlibs = (next_libnum-2);

  /* The subprims area has to go first.  We only have to describe the
     jump table (unless/until we start jumping directly.) */

  note_phys_area(data_header, 
                 lisp_global(SUBPRIMS_BASE), 
                 lisp_global(SUBPRIMS_BASE)+1024, 
                 logical_section_subprims);

  note_phys_area(data_header,
                 (LispObj)(nilreg_area->low),
                 (LispObj)(nilreg_area->active),
                 logical_section_nilreg_area);

  /* Application's code areas: */
  /* First those whose ownership was transferred from an orphaned library */
  l = collect_area_list(collect_area_list(NULL, AREA_READONLY, 1, true), AREA_READONLY, 1, false);
  l = collect_area_list(collect_area_list(l, AREA_READONLY, 0, true), AREA_READONLY, 0, false);
  note_area_list(data_header, l, logical_section_application_code);
  free_area_list(l);
  
  /*
    Each library's code, mutable data, and immutable data areas:
    */

  for (libnum = 2; libnum < next_libnum; libnum++) {
    l = collect_area_list(collect_area_list(NULL, 
                                            AREA_READONLY, 
                                            libnum, 
                                            true), 
                          AREA_READONLY, 
                          libnum, 
                          false);
    note_area_list(data_header, l, (libnum<<3) | logical_section_lib_code);
    free_area_list(l);
    
    l = collect_area_list(collect_area_list(NULL, 
                                            AREA_STATIC, 
                                            libnum, 
                                            true), 
                          AREA_STATIC, 
                          libnum, 
                          false);
    note_area_list(data_header, l, (libnum<<3) | logical_section_lib_static);
    free_area_list(l);


    l = collect_area_list(collect_area_list(NULL, 
                                            AREA_STATICLIB, 
                                            libnum, 
                                            true), 
                          AREA_STATICLIB, 
                          libnum, 
                          false);
    note_area_list(data_header, l, (libnum<<3) | logical_section_lib_staticlib);
    free_area_list(l);
  }
  
  /* Need to note any excised library's code areas */
  l = collect_area_list(collect_area_list(NULL, AREA_READONLY, 0xffffffff, true), AREA_READONLY, 0xffffffff, false);
  note_area_list(data_header, l, logical_section_excised_code);

  /* Application's data area(s).  These need both to be noted and written
   to disk, which is kind of the whole point here ...*/
  l = collect_area_list(collect_area_list(NULL, AREA_DYNAMIC, 0, true), AREA_STATIC, 0, false);
  note_area_list(data_header, l, logical_section_application_data);

  if (compressed) {
    err = write_compressed_data(refnum, data_header, l);
  } else {
    err = write_uncompressed_data(refnum, data_header, l);
  }

  free_area_list(l);
  return err;
}
  
  

  

