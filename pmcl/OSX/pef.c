/*
  $Log: pef.c,v $
  Revision 1.3  2003/11/17 02:16:19  gtbyers
  Be more careful about inter/intra library locations, since areas may be adjacent in memory.

  Revision 1.2  2002/11/25 06:10:23  gtbyers
  Ensure that the saved application imports the CFM versions of set_nil_and_start and application_loader.

  02/18/00 akh change some old names to new names e.g. kDataForkCFragLocator
  03/01/97 gb   use KERNEL_CFRG_NAME (passed on command line.)
  01/29/97 gb   use PEF_export_symbol_size - gcc botches sizeof(mac_aligned_struct)
  --- 4.0 ---
   9/30/96 slh  Gary's fix to write_data_section, write_purified_area
  07/26/96 gb   Say "kWeakLib" vice 0x40.  write_pef_file: allow version 0 libs.
  07/26/96 bill "|" reverts to "&" with kWeakImport in save_old_application & save_application.
                Gary's addition of imp++ just before the last for loop in save_application
  07/25/96 bill save_old_application & save_application or (|) in
                kWeakImport instead of and'ing (&).
  07/22/96 bill write_pef_file calls update_pef_cfrg after save_application_data.
                update_pef_cfrg updates all the cfrg_member's in the cfrg resource
                and copies the data for the on-disk non-application ones.
                It does this using new functions: open_application_data_fork
                and copy_cfm_container.
  07/14/96  gb  weak import from lisp libraries; reorder so pmcl-kernel4
                library comes first.
  06/13/96  gb  pmcl-kernel->pmcl-kernel4.  Don't note empty areas.
  05/12/96  gb  lotsa changes for new (non-PEF) data.
  --- 3.9 ---
  04/09/96  gb  pmcl_kernel version info; support excised libraries.
  04/07/96 slh  include ToolUtils.h for watchCursor
  03/29/96  gb  set import version of "pmcl-kernel" to 0 in save_application.
  03/26/96  gb  code cleanup; don't export from application.
  03/17/96  gb  maintain library version info (timestamp) 
  02/20/96  gb  save_library; lotsa changes.
  02/01/96  gb  throw errors rather than trying to propagate them.
                start thinking about PIData.
  01/26/96  gb  write_data_section sets hash table flags if needed
*/

#include <setjmp.h>
#include "pef.h"
#include "lisp.h"
#include "lisp_globals.h"
#include "area.h"
#include "bits.h"
#include <stdlib.h>
#include <stdio.h>
#include "lisp-exceptions.h"
#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <Files.h>
#include <Memory.h>
#include <CodeFragments.h>
#include <QuickDraw.h>
#include <ToolUtils.h>
#include <Resources.h>
#include <Processes.h>
#endif

#ifndef KERNEL_CFRG_NAME
#error You lose.  Define KERNEL_CFRG_NAME via -D
#endif

jmp_buf PEFjmp = {0};

extern unsigned next_libnum;
extern int application_loader();

typedef union {
  unsigned long w;
  unsigned short h;
  unsigned char b;
} Word;

int
num_load_sections = 2;          /* May have more (mutable library data) later */

int
num_sections = 3;               /* One non-loadable section */

int
num_import_containers = 1;

int
num_import_sections = 1;

PEF_section *sections = NULL;
logical_section **logical_sections = NULL;
logical_import_container *import_containers = NULL;

area_list *excised_pure_sections = NULL;

Boolean 
compress_pef_data = false;

unsigned
  fullword_buffer[1024] = {0},
  *fullword_bufstart = NULL,
  *fullword_bufp = NULL,
  *fullword_buflim = NULL;

unsigned short
  *halfword_bufstart = NULL,
  *halfword_bufp = NULL,
  *halfword_buflim = NULL;

unsigned char
  pi_buffer[1280] = {0},
  *pi_bufstart = NULL,
  *pi_bufp = NULL,
  *pi_buflim = NULL;

short pef_refnum = 0;

long
  PEF_container_pos = 0;


typedef int (*sortfn)(const void *, const void *);

#ifdef PMCL_OSX_NATIVE_KERNEL
extern void *CFM_set_nil_and_start, *CFM_application_loader;
#define MAIN_CFM_IMPORT CFM_set_nil_and_start
#define APPLICATION_LOADER_CFM_IMPORT CFM_application_loader
#else
extern int set_nil_and_start();
#define MAIN_CFM_IMPORT set_nil_and_start
#define APPLICATION_LOADER_CFM_IMPORT application_loader
#endif


void *
PEF_alloc(unsigned n)
{
  OSErr err;
  Handle h;

  h = TempNewHandle(n, &err);
  if (err != noErr) {
    longjmp(PEFjmp,err);
  }
  HLock(h);
  return (void *)(*h);
}

extern LispObj
init_code_vector;

void
find_or_create_nilreg_area()
{
  if (nilreg_area == NULL) {
    area *a, *b = area_containing((BytePtr)lisp_nil);
    BytePtr start = b->low, end = nilreg_symbols_end;
    unsigned dwords = area_dword(end, start);
    
    b->low = end;
    b->ndwords -= dwords;
    a = new_area(start, end, AREA_STATIC);
    add_area(a);
    nilreg_area = a;
  }
  if (init_code_vector == 0) {
    Handle h;
    BytePtr p;
    area *a;
    LispObj *wp;

    p = (BytePtr)alloc_handle_critical(8*4, &h);
    wp = (LispObj *) p;
    wp[0] = make_header(subtag_code_vector, 6);
    wp[1] = 0x80C20007;         /* lwz imm3,4+(8-fulltag_nil)(rtoc) */
    wp[2] = 0x80A60000;         /* lwz imm2,0(imm3) */
    wp[3] = 0x7CA903A6;         /* mtctr imm2 */
    wp[4] = 0x7C441378;         /* mr imm1,rtoc */
    wp[5] = 0x80460004;         /* lwz rtoc,4(imm3) */
    wp[6] = 0x4E800420;         /* bctr */
    wp[7] = 0;
    init_code_vector = ((LispObj)wp)+fulltag_misc;
    a = new_area(p, p+(8*4), AREA_READONLY);
    a->h = h;
    add_area(a);
  }
  deref(lisp_nil,0) = init_code_vector;
}
    
    
int
compare_logical_exports(const logical_export  *e0, const logical_export *e1)
{
  int v0 = e0->hash_slot_index - e1->hash_slot_index;

  if (v0 == 0) {
    v0 = e1->value - e0->value;
  }
  return v0;
}

logical_export **
construct_logical_exports(int n)
{
  logical_export
    *logexports = (logical_export *) alloc_ptr_critical(n * sizeof(logical_export), true),
    **ptrs = (logical_export **) alloc_ptr_critical(n * sizeof(logical_export *), true);
  int i;

  if (logexports && ptrs) {
    for (i = 0; i < n; i++) {
      ptrs[i] = logexports+i;
    }
  }
  return ptrs;
}

#define kAvgChainSize 5

int
hash_chain_shift(int n)
{
  int i;

  for (i = 0; i < 13; i++) {
    if ((n / (1<<i)) < kAvgChainSize) {
      break;
    }
  }
  return i;
}

int
hash_code_slot(int hashcode, int shift)
{
  return ((1 << shift) - 1) & (hashcode ^ (hashcode >> shift));
}

void
check_pef_error(OSErr err)
{
  if (err != noErr) {
    longjmp(PEFjmp, err);
  }
}

void
PEF_write(short refnum, long *count, const void *buf)
{
  check_pef_error(FSWrite(refnum, count, buf));
}

void
PEF_getpos(short refnum, long *pos)
{
  check_pef_error(GetFPos(refnum, pos));
}

void
PEF_setpos(short refnum, short mode, long pos)
{
  check_pef_error(SetFPos(refnum, mode, pos));
}

void
PEF_geteof(short refnum, long *eofp)
{
  check_pef_error(GetEOF(refnum, eofp));
}

void
PEF_seteof(short refnum, long neweof)
{
  check_pef_error(SetEOF(refnum, neweof));
}

global_string_table *
make_gst()
{
  global_string_table *gst = (global_string_table *) alloc_ptr_critical(sizeof(global_string_table), false);
  if (gst != NULL) {
    gst->data = alloc_ptr_critical(256, false);
    if (gst->data == NULL) {
      DisposePtr((Ptr)gst);
      return NULL;
    }
    gst->logsize = 0;
    gst->physsize = 256;
  }
  return gst;
}

void
resize_gst(global_string_table *gst, int newsize)
{
  int oldsize = gst->physsize;
  char *newdata = alloc_ptr_critical(newsize, false);
  BlockMoveData(gst->data, newdata, oldsize);
  gst->data = newdata;
  gst->physsize = newsize;
}

int
add_global_string(global_string_table *gst, char *string, Boolean add_null)
{
  int
    idx = gst->logsize,
    len = strlen(string) + (add_null ? 1 : 0);

  if ((idx + len) > gst->physsize) {
    resize_gst(gst, idx+len+256);
  }
  BlockMoveData(string, gst->data+idx, len);
  gst->logsize += len;
  return idx;
}


void
init_pef_io(short refnum)
{
  pef_refnum = refnum;

  fullword_bufstart = fullword_buffer;
  fullword_bufp = fullword_buffer;
  fullword_buflim = fullword_bufstart+1024;

  halfword_bufp = (unsigned short *) fullword_bufp;
  halfword_bufstart = halfword_bufp;
  halfword_buflim = (unsigned short *) fullword_buflim;

  pi_bufstart = pi_bufp = pi_buffer;
  pi_buflim = pi_buffer + sizeof(pi_buffer);

  PEF_getpos(refnum, &PEF_container_pos);
}


/*
  Put any excised pure sections on the excised_pure_sections list, of all places. */
void
collect_excised_sections()
{
  area *a = active_dynamic_area;
  area_list *q;

  excised_pure_sections = NULL;
  do {
    if ((a->code == AREA_READONLY) && (a->owner == 0xffffffff)) {
      q = (area_list *) alloc_ptr_critical(sizeof(area_list), false);
      q->area = a;
      q->next = excised_pure_sections;
      excised_pure_sections = q;
    }
    a = a->succ;
  } while (a->code != AREA_VOID);
}

/*
  The "handle" flag is supposed to help us push
  areas that lisp's created on the list before those
  that the OS created.
  */
void
collect_lsect_areas(logical_section *lsect, 
                    area_code code,
                    unsigned owner, 
                    Boolean handle_p, 
                    Boolean nilreg_p)
{
  area *a = active_dynamic_area;
  area_list *listp;
  Boolean area_has_handle, area_is_nilreg_area;
  PEF_section *ps;
  unsigned nbytes;

  do {
    area_has_handle = (a->h != NULL);
    area_is_nilreg_area = (a == nilreg_area);
    if ((a->ndwords != 0) &&
        (a->code == code) && 
        (a->owner == owner) && 
        (area_has_handle == handle_p) &&
        (area_is_nilreg_area == nilreg_p)) {
      nbytes = (a->active - a->low);
      if (lsect->external == false) {
        ps = lsect->section.physical_section;
        ps->execsize += nbytes;
        ps->rawsize += nbytes;
        ps->initsize += nbytes;
      }
      listp = (area_list *) alloc_ptr_critical(sizeof(area_list), false);
      listp->area = a;
      listp->next = lsect->contents;
      lsect->contents = listp;
    }
    a = a->succ;
  } while (a->code != AREA_VOID);
}

/* Doing things this way ensures that the last word (halfword)
   written is still in the buffer.  The relocation stuff may
   want to get its hands on the last instruction easily (to
   increment repeat counts, etc.
   */

void
flush_fullword_buffer()
{
  long bytecount = (long)fullword_bufp - (long)fullword_bufstart;

  PEF_write(pef_refnum, &bytecount, fullword_bufstart);
  fullword_bufp = fullword_bufstart;
}

void
flush_pi_buffer()
{
  long bytecount = pi_bufp - pi_bufstart;

  PEF_write(pef_refnum, &bytecount, pi_bufstart);
  pi_bufp = pi_bufstart;
}
void
write_pi_byte(unsigned char b)
{
  if (pi_bufp == pi_buflim) {
    flush_pi_buffer();
  }
  *pi_bufp++ = b;
}

void
write_pi_count(unsigned c)
{
  pi_count count;

  count.fullword = c;

  if (count.bits.a4) {
    write_pi_byte((count.bits.a4)|0x80);
    write_pi_byte((count.bits.b7)|0x80);
    write_pi_byte((count.bits.c7)|0x80);
    write_pi_byte((count.bits.d7)|0x80);
    write_pi_byte((count.bits.e7));
  } else if (count.bits.b7) {
    write_pi_byte((count.bits.b7)|0x80);
    write_pi_byte((count.bits.c7)|0x80);
    write_pi_byte((count.bits.d7)|0x80);
    write_pi_byte((count.bits.e7));
  } else if (count.bits.c7) {
    write_pi_byte((count.bits.c7)|0x80);
    write_pi_byte((count.bits.d7)|0x80);
    write_pi_byte((count.bits.e7));
  } else if (count.bits.d7) {
    write_pi_byte((count.bits.d7)|0x80);
    write_pi_byte((count.bits.e7));
  } else {
    write_pi_byte(count.bits.e7);
  }
}

void
write_pi_opcode(unsigned opcode, unsigned count1)
{
  pattern p;
  p.op.op = opcode;

  if (count1 < 32) {
    p.op.count = count1;
    write_pi_byte(p.b);
  } else {
    p.op.count = 0;
    write_pi_byte(p.b);
    write_pi_count(count1);
  }
}

unsigned Qbyte_count = 0;
unsigned char *Qbytes = NULL;

void
pi_Qbytes(unsigned n, unsigned char *bytes)
{
  if (n) {
    if (Qbyte_count == 0) {
      Qbytes = bytes;
    }
  }
  Qbyte_count += n;
}

/* If pi_output_raw_bytes can't do better than a pi_Block
   opcode, use pi_output_raw_block to do the dirty work. */
void
pi_output_raw_block(unsigned n, unsigned char *bytes)
{
  if (n) {
    write_pi_opcode(pi_op_Block, n);
    while (n--) {
      write_pi_byte(*bytes++);
    }
  }
}

void
pi_output_raw_bytes(unsigned n, unsigned char *bytes)
{
  unsigned nz;
  unsigned char *p, *q;

  if (n) {
    if (n == 1) {
      if (*bytes) {
        pi_output_raw_block(1, bytes);
      } else {
        write_pi_opcode(pi_op_Zero, 1);
      }
    } else {
      /* Look 2 or more for prefix zero bytes */
      for (nz = 0, p = bytes; nz < n; nz++, p++) {
        if (*p != 0) break;
      }
      if (nz > 1) {
        write_pi_opcode(pi_op_Zero, nz);
        pi_output_raw_bytes(n - nz, p);
      } else {
        if (n == 2) {
          pi_output_raw_block(2, bytes);
        } else {
          /* Look for 2 or more suffix zero bytes */
          for (nz = 0, p = bytes + n; nz < n; nz++) {
            if (*--p != 0) break;
          }
          if (nz > 1) {
            pi_output_raw_bytes(n - nz, bytes);
            write_pi_opcode(pi_op_Zero, nz);
          } else {
            if (n <= 5) {
              pi_output_raw_block(n, bytes);
            } else {
              nz = 0;
              /* Look for embedded runs of three or more zeros. */
              for (p = bytes + 1, q = bytes + (n - 4); p < q; p ++) {
                if ((p[0] | p[1] | p[2]) == 0) {
                  nz = p - bytes;
                  break;
                }
              }
              if (nz) {
                /* Found 'em */
                pi_output_raw_bytes(nz, bytes);
                pi_output_raw_bytes(n - nz, p);
              } else {
                /* Should still look for 1-byte patterns of length 4 or more,
                   multibyte patterns */
                pi_output_raw_block(n, bytes);
              }
            }
          }
        }
      }
    }
  }
}

void
pi_flush_Qbytes()
{
  /* This may be able to do better than to simply
     write out a pi_Block opcode (if there are
     a large number of zero bytes/repeating bytes
     and if "splitting" the block doesn't create
     a large number of subblocks)
     */
  if (Qbyte_count) {
    pi_output_raw_bytes(Qbyte_count, Qbytes);
    Qbyte_count = 0;
  }
}

void
write_pi_Zero(unsigned count1)
{
  pi_flush_Qbytes();
  write_pi_opcode(pi_op_Zero, count1);
}

void
write_pi_Block(unsigned count1, unsigned char *data)
{
  /* This doesn't actually write the pi_Block,
     it merely enqueues it. */
  pi_Qbytes(count1, data);
}

void
write_pi_Repeat(unsigned count1, unsigned count2, unsigned char *data)
{
  count2 -= 1;
  pi_flush_Qbytes();
  write_pi_opcode(pi_op_Repeat, count1);
  write_pi_count(count2);
  while(count1--) {
    write_pi_byte(*data++);
  }
}

void
write_pi_RepeatBlock(unsigned count1, unsigned count2, unsigned count3, unsigned char *data)
{
  unsigned i;

  pi_flush_Qbytes();
  write_pi_opcode(pi_op_RepeatBlock, count1);
  write_pi_count(count2);
  write_pi_count(count3);
  /* The repeating pattern is of length "count1".
     Write it out once.  The non-repeating pattern
     is of length "count2".  Write it out "count3"
     times, skipping trailing instances of the
     repeating pattern. */
  for (i = 0; i < count1; i++) {
    write_pi_byte(*data++);
  }
  while (count3--) {
    for (i = 0; i < count2; i++) {
      write_pi_byte(*data++);
    }
    data += count1;
  }
}

void
write_pi_RepeatZero(unsigned count1, unsigned count2, unsigned count3, unsigned char *data)
{
  unsigned i;

  pi_flush_Qbytes();
  write_pi_opcode(pi_op_RepeatZero, count1);
  write_pi_count(count2);
  write_pi_count(count3);
  /* The repeating pattern is of length "count1";
     it contains nothing but zeros so it doesn't
     need to be represented explicitly.  The
     non-repeating pattern is of length "count2".
     Write it out "count3" times, skipping trailing
     instances of the repeating pattern. */
  data += count1;
  while (count3--) {
    for (i = 0; i < count2; i++) {
      write_pi_byte(*data++);
    }
    data += count1;
  }
}

/*
  This probably misses a lot; I just want to get -some- version
  of pi compression working ...
  */

void
pi_compress_fullword_buffer(Word *startp, Word *endp)
{
  Word *p0, *p1, *p2;
  unsigned w0;
  unsigned char *byteptr, *byteend;

  while (startp < endp) {
    p0 = startp;
    p1 = startp+1;
    byteptr = (unsigned char *) p0;
    w0 = p0->w;

    if ((w0 == 0) || (p1 == endp)){
      write_pi_Block(4, byteptr);
      startp++;
    } else if (p1->w == w0) {
      /* Repeating word patterns compress about as  well as anything.
         First, look for repeating word patterns at the beginning of
         the buffer. */

      while (++p1 < endp) {
        if (p1->w != w0) break;
      }
      write_pi_Repeat(4, p1-startp, byteptr);
      startp = p1;
    } else {
      p2 = NULL;
      for (p1 = startp+1, p0 = p1+1; p0 < endp; p1++, p0++) {
        if (p1->w == p0->w) {
          p2 = p1;
          break;
        }
      }
      if (p2) {
        pi_compress_fullword_buffer(startp, p2);
        pi_compress_fullword_buffer(p2, endp);
        startp = endp;
      } else {
        /* There are no more zero words or repeating words in the buffer.
           The only way we can win (at all) is if there are at least
           three consecutive words in the buffer whose high byte is 0.
           (We win even more if we can find runs whose high halfword is 0,
           and there's reason to believe that this is fairly common in MCL.)
           We've already checked for the case where there's only one word
           in the buffer; if there are only two at this point, there are
           no zero-prefixed runs. */
        if ((endp - startp) == 2) {
          write_pi_Block(8, byteptr);
          startp += 2;
        } else {
#if 0
          /* Find the first run of three or more words whose high halfword
             is 0.  If such a run is found, recurse on the words preceding
             it, then write out a pi_RepeatZero() block.  Otherwise,
             look for runs of three or more words whose high byte is
             0.  Insist that at least the first two words of such a run
             are non-zero.
             */
          for (p0 = startp, p1 = startp+1, p2 = startp+2;
               p2 < endp;
               p0++, p1++, p2++) {
            if ((p0->w & p1->w)) { /* first two words non-zero */
              if ((p0->h | p1->h | p2->h) == 0) {
                break;
              }
            } else {
              p2 = endp;
            }
          }

          if ( 0 && (p2 < endp)) {
            /* Found such a run.  Recurse on the prefix (will basically
               thrash around & maybe find a run of 0 high bytes.) */
            pi_compress_fullword_buffer(startp, p0);

            byteptr = (unsigned char *) p0;
            while (p2 < endp) {
              if (p2->h != 0) {
                break;
              }
              p2++;
            }
            startp = p2;
            p2 -= 1;
            write_pi_RepeatZero(2, /* two repeating zero bytes */
                                2, /* two repeating non-zero bytes */
                                p2-p0,
                                byteptr);
            write_pi_Block(2, ((unsigned char *)p2)+2);
          } else {
#endif
            /* Find the first run of three or more words whose high byte is
               0 (if such an animal exists).  Write a pi_Block if there
               are any words before that run.  Then, find the length of
               the run. */

            for (p0 = startp, p1 = startp+1, p2 = startp+2;
                 p2 < endp ;
                 p0++, p1++, p2++) {
              if (p0->w & p1->w) {
                if ((p0->b | p1->b | p2->b) == 0) {
                  break;
                }
              } else {
                p2 = endp;
              }
            }

            if (p2 >= endp) {
              /* Never found a run: write a pi_Block() opcode */
              write_pi_Block(4*(endp-startp), byteptr);
              startp = endp;
            } else {
              if (p0 != startp) {
                byteend = (unsigned char *) p0;
                write_pi_Block(byteend-byteptr, byteptr);
                startp = p0;
                byteptr = byteend;
              }
              /*
                Now, p0 points at the first word of a run of words
                whose high byte is 0.  Bump p2, until p2 points AT
                the last such word.
                */
              while (p2 < endp) {
                if (p2->b != 0) {
                  break;
                }
                p2++;
              }
              startp = p2;
              p2 -= 1;
              write_pi_RepeatZero(1, /* one repeating zero byte */
                                  3, /* three repeating non-zero bytes */
                                  p2-p0,
                                  byteptr);
              write_pi_Block(3, ((unsigned char *)p2)+1);
            }
          }
#if 0
        }
#endif
      }

    }
  }
}


void
pi_flush_fullword_buffer()
{
  if (compress_pef_data) {
    pi_compress_fullword_buffer((Word *)fullword_bufstart, (Word *) fullword_bufp);
    pi_flush_Qbytes();
    fullword_bufp = fullword_bufstart;
    flush_pi_buffer();
  } else {
    flush_fullword_buffer();
  }
}

void
flush_halfword_buffer()
{
  long bytecount = (long)halfword_bufp - (long)halfword_bufstart;

  PEF_write(pef_refnum, &bytecount, halfword_bufstart);
  halfword_bufp = halfword_bufstart;
}

void
write_fullword(unsigned w)
{

  if (fullword_bufp == fullword_buflim) {
    flush_fullword_buffer();
  }
  *fullword_bufp++ = w;
}

/*
  This is just about the same as "write_fullword", only when the
  buffer fills we call "pi_flush_fullword_buffer" to write pattern-
  initialized data.
*/

void
pi_write_fullword(unsigned w)
{
  if (fullword_bufp == fullword_buflim) {
    pi_flush_fullword_buffer();
  }
  *fullword_bufp++ = w;
}

void
write_halfword(unsigned short w)
{
  if (halfword_bufp == halfword_buflim) {
    flush_halfword_buffer();
  }
  *halfword_bufp++ = w;
}



void
output_DELTA(unsigned nbytes)
{
  relocation_instruction i;
  i.delta.delta_m1 = (nbytes-1);
  i.delta.op = DELTA;
  write_halfword(i.instr);
}

/* Whenever we (first) make a DDAT, we're only talking
   about 1 word, so this doesn't take an "nwords" parameter.
   */

void
output_DDAT(unsigned nskip)
{
  relocation_instruction i;
  i.deltadata.op = DDAT;
  i.deltadata.delta_d4 = nskip;
  i.deltadata.cnt = 1;
  write_halfword(i.instr);
}

/* Likewise with CODE and DATA: the word count is implicitly 1 when
   we first push the opcode.
*/
void
output_CODE()
{
  relocation_instruction i;
  i.opcode.op = CODE;
  i.opcode.rest = 0;            /* (1- 1) */
  write_halfword(i.instr);
}

void
output_DATA()
{
  relocation_instruction i;
  i.opcode.op = DATA;
  i.opcode.rest = 0;            /* (1- 1) */
  write_halfword(i.instr);
}

void
output_SYMB(unsigned idx)
{
  relocation_instruction i;
  i.opcode.op = SYMB;
  i.opcode.rest = idx;
  write_halfword(i.instr);
}

void
output_SECN(unsigned secnum)
{
  relocation_instruction i;
  i.opcode.op = SECN;
  i.opcode.rest = secnum;
  write_halfword(i.instr);
}

void
delta_last_reloc(int delta)
{
  halfword_bufp[-1] += delta;
}

void
align_section_data(int power, long *aligned_pos)
{
  long curpos, mask = ((1 << power) - 1), eofpos;

  PEF_getpos(pef_refnum, &curpos);
  if (curpos & mask) {
    /* Not aligned, need to be. */
    curpos += mask;
    curpos &= ~mask;
    PEF_geteof(pef_refnum, &eofpos);
    if (curpos > eofpos) {
      PEF_seteof(pef_refnum, curpos);
    }
    PEF_setpos(pef_refnum, fsFromStart, curpos);
  }
  *aligned_pos = curpos;
}

/*
  Treat "a" as a pointer.  Determine what section it points
  at (if any); return the offset from the start of the section
  and the section number in "sectionp" if it's found; "a" and -1
  otherwise.
  */
int
section_reference_offset(LogicalAddress a, int *sectionp)
{
  logical_section *lsect;
  area_list *areas;
  area *area;
  int i;
  unsigned prefix;

  /* If referring to a code vector in an excised section, refer to
     %excised-code% instead. */
  for (areas = excised_pure_sections; areas; areas = areas->next) {
    area = areas->area;
    if (((BytePtr) a >= area->low) &&
        ((BytePtr) a <= area->active)) {
      a = (LogicalAddress) nrs_EXCISED_CODE.vcell;
      break;
    }
  }

  for (i = 0; (lsect = logical_sections[i]) != NULL ; i++) {
    prefix = 0;
    areas = lsect->contents;
    while (areas) {
      area = areas->area;
      areas = areas->next;

      if (((BytePtr) a >= area->low) &&
          ((BytePtr) a <= area->active)) {
        if (sectionp) {
          *sectionp = i;
        }
        return (prefix + (((BytePtr)a) - (area->low)));
      }
      prefix += (area->active - area->low);
    }
  }
  if (sectionp) {
    *sectionp = -1;
  }
  return (int) a;
}

/*
  This word is a pointer of some sort.  The relocation's
  already been written; compute the offset of the word
  from the start of the containing section and write
  -that- instead.
*/

void
write_relative(LispObj w)
{
  pi_write_fullword(section_reference_offset((LogicalAddress)w, NULL));
}

void
write_node(LispObj node)
{
  int tag = fulltag_of(node);

  switch (tag) {
  case fulltag_misc:
  case fulltag_cons:
  case fulltag_nil:
    write_relative(node);
    break;

  default:
    pi_write_fullword(node);
  }
}

#define FUNKY_APPLICATION_PRIMARY 1
#define FUNKY_LIBRARY_DATA 2
#define FUNKY_PRIVATE_MUTABLE_DATA 3
#define FUNKY_NILREG_DATA 4

/*
  When "funky" is true, we have to treat the kernel
  startup stuff at the start of the section magically.

  There are a few different kinds of funkiness:
  1) The application's primary data section contains
     the startup transition vector and various "nilreg-
     relative globals", some of which need to be written
     and relocated specially.
  2) Library data sections start with a header that
     describes the size of that library data section,
     the start & size of the library's code section,
     and the name of the library's code fragment.
  3) A mutable data section has a header which describes
     that section's start address & size and a pointer
     to the "client" library data section.
  4) In the new (non-PEF-data) scheme, the nilreg_area
     gets written out with various funky relocations
     (embedded in the vector which hides the nilreg
     globals), but the remaining nilreg_area contents
     DON'T get (PEF-) relocated.
     There are a couple of PEF relocations that
     only apply in the nilreg_area case.

  Other than that:
  * write all tagged pointers as relocatable references;
  * clobber macptrs, turning them into dead_macptrs;
  * if we encounter any code_vectors (shouldn't if purify's
    found them, but just in case), subtract subprims_base
    from any absolute branch target addresses.
  This isn't as bad as it sounds: write_fullword does -some-
  buffering.
  */

void
write_data_section(logical_section *sect, int funky)
{
  PEF_section *psect = sect->section.physical_section;
  hash_table_vector_header *hashp;
  long curpos;
  area_list *areas;
  area *a;
  LispObj
    subpbase = lisp_global(SUBPRIMS_BASE),
    *current,
    *limit,
    section_origin,
    header,
    word;
  unsigned
    section_size = 0,
    elements,
    tag,
    subtag,
    nwords,
    i;
  Boolean section_origin_set = false;

  if (compress_pef_data) {
    PEF_getpos(pef_refnum, &curpos);
    psect->region_kind = section_kind_pidata;
  } else {
    align_section_data(3, &curpos);
    psect->region_kind = section_kind_data;
  }

  psect->offset = (curpos - PEF_container_pos);
  
  areas = sect->contents;

  {
    area_list *q;
    
    for (q = areas; q; q = q->next) {
      a = q->area;
      section_size += (a->active - a->low);
    }
  }

  while (areas) {
    a = areas->area;
    areas = areas->next;
    current = (LispObj *) a->low;
    limit = (LispObj *) a->active;
    if (!section_origin_set) {
      section_origin = (LispObj)current;
      section_origin_set = true;
    }

    while (current < limit) {
      header = *current++;
      switch (funky) {
      case FUNKY_APPLICATION_PRIMARY: /* application primary data section */
      case FUNKY_NILREG_DATA:   /* or nilreg_area in the new scheme */
        /*
          Start of static area looks like:
          dc.l header
          dc.l <import-ref> to import #0
          dc.l CODE ref to entrypoint
          dc.l DATA ref to nil (TOC)
          dcb.l 1024,various
          where there are 2 data refs, a 0, 2 code refs, and 1019 0s.
          We then resume normal programming at nil: 0 nil nil 0.
          Ok, it gets normal -after- nil.
          */
        pi_write_fullword(header);
        pi_write_fullword(0);      /* 0 bytes from import */
        write_relative(current[1]); /* entrypoint */
        write_relative(current[2]); /* TOC/nil */
        pi_write_fullword(0);   /* static-section start - start of static section */
        pi_write_fullword(psect->rawsize); /* (relative) static-section end */
        write_relative(current[5]); /* mutable_data_section_header pointer or NULL */
        write_relative(current[6]); /* readonly start */
        pi_write_fullword(sections->rawsize); /* (relative) readonly-section end */
        for (i = 0; i< 1019; i++) {
          if (i == (1019 + FWDNUM)) {
            pi_write_fullword(lisp_global(FWDNUM)+(1<<fixnumshift));
          } else if (i == (1019 + GC_NUM)) {
            pi_write_fullword(lisp_global(GC_NUM)+(1<<fixnumshift));
          } else {
            pi_write_fullword(0);
          }
        }
        current += 1027;
        if (funky == FUNKY_NILREG_DATA) {
          /* 'current' is now pointing to the beginning of the two doublewords
             that contain NIL.  These two doublewords will look like:
             dc.l fragment_init_code_vector
             dc.l lisp_nil
             dc.l lisp_nil
             dc.l import_ref_to 'application_loader'
             If we're cross-dumping from an 'old' (PEF-format heap)
             image to a new (private-format heap) image, -somebody- has to have shoved
             the entrypoint and import reference into these locations (and ensured that
             the code vector is in a pure area, etc.)
             The import ref will be tagged as a fixnum.  When dumping in the new format,
             we'll want it to be relocated by the PEF loader; when dumping in the old
             format, it doesn't really matter.
             */
          write_relative(*current++); /* let PEF relocate the init code vector */
          write_relative(*current++); /* PEF relocate (cdr nil) */
          write_relative(*current++); /* PEF relocate (car nil) */
          write_relative(*current++); /* PEF relocate import */
          while (current < limit) {
            /* nilreg-relative symbols get relocated by the lisp loader.
               Write them out absolute. */
            pi_write_fullword(*current++);
            pi_write_fullword(*current++);
          }
        }
        funky = 0;
        break;

      case FUNKY_LIBRARY_DATA:                   /* Library data section */
        write_relative(header); /* start of library code section */
        write_relative(*current++); /* end of library code section */
        funky = 0;
        break;

      case FUNKY_PRIVATE_MUTABLE_DATA:                   /* Mutable/private data section */
        pi_write_fullword(header); /* really was a header */
        write_relative(*current++); /* mutable_data_section_header.next */
        pi_write_fullword((*current++)-section_origin); /* .mutable_low */
        pi_write_fullword((*current++)-section_origin); /* .mutable_high */
        write_relative((*current++)); /* .immutable_low */
        write_relative((*current++)); /* .immutable_high */
        for (i = 0; i < 18; i++) { /* .flags, .timestamp, 16 words of .libname */
          pi_write_fullword(*current++);
        }
        funky = 0;
        break;

      case 0:
      default:
        tag = fulltag_of(header);
        if (tag == fulltag_immheader) {
          subtag = header_subtag(header);
          elements = header_element_count(header);
          /* Special-case macptr: */
          if (subtag == subtag_macptr) {
            pi_write_fullword(make_header(subtag_dead_macptr,elements));
            elements += (1 - (elements & 1));
            for (i = 0; i < elements; i++) {
              pi_write_fullword(*current++);
            }
          } else {
            pi_write_fullword(header);
            if (subtag == subtag_code_vector) {
              Boolean pre_tb = true; /* before the traceback table, if any */
              elements += (1 - (elements & 1));
              for (i = 0; i < elements; i++) {
                word = *current++;
                if (word == 0) {
                  pre_tb = false;
                }
                if (pre_tb &&
                    ((word & ((-1 << 26) | (1 << 1))) == ((18 << 26) | (1<<1)))) {
                  word -= subpbase;
                }
                pi_write_fullword(word);
              }
            } else {
              /* some random ivector */
              if (subtag <= max_32_bit_ivector_subtag) {
                nwords = elements;
              } else if (subtag <= max_8_bit_ivector_subtag) {
                nwords = (elements+3)>>2;
              } else if (subtag <= max_16_bit_ivector_subtag) {
                nwords = (elements+1)>>1;
              } else if (subtag == subtag_double_float_vector) {
                nwords = 1 + (elements<<1);
              } else {
                nwords = (elements+31)>>5;
              }
              nwords += (1 - (nwords & 1));
              for (i = 0; i < nwords; i++) {
                pi_write_fullword(*current++);
              }
            }
          }
        } else {
          if ((tag == fulltag_nodeheader)) {
            subtag = header_subtag(header);
            if (subtag == subtag_hash_vector) {
              hashp = (hash_table_vector_header *) (current-1);
              if ((hashp->flags) & nhash_track_keys_mask) {
                hashp->flags |= nhash_key_moved_mask;
              }
            }
            pi_write_fullword(header);
            write_node(*current++);
            elements = header_element_count(header) & ~1;
            while (elements) {
              write_node(*current++);
              write_node(*current++);
              elements -= 2;
            }
          } else {
            write_node(header);
            write_node(*current++);
          }
        }
      }
    }
  }
  pi_flush_fullword_buffer();
  PEF_getpos(pef_refnum, &curpos);
  psect->rawsize = ((curpos - PEF_container_pos) - psect->offset);
}


/*
  If a "readonly area" still has absolute subprim calls, it's not really
  As Pure As Driven Snow, so we'll have to write it out a word at a time.
  The "real" readonly area comes first; the subprims (jump table) starts
  two words into that area.  If we find an absolute branch in any area
  that "purify" has allocated, subtract the current value of subprims_base,
  turn off the absolute bit, and make the branch be pc-relative.

  One saving grace is that the pure area contains nothing but ivectors.
*/

void
write_purified_area(LispObj *start, LispObj *limit, unsigned prefix_bytes)
{
  LispObj
    *current = start,
    subpbase = lisp_global(SUBPRIMS_BASE),
    header,
    instr;
  unsigned
    subtag,
    elements,
    words,
    spno;
  int i;
  Boolean seen_tb;
  branch_instruction b;

  while (current < limit) {
    header = *current++;
    write_fullword(header);
    subtag = header_subtag(header);
    elements = header_element_count(header);

    if (subtag <= max_32_bit_ivector_subtag) {
      words = elements;
    } else if (subtag <= max_8_bit_ivector_subtag) {
      words = (elements+3) >> 2;
    } else if (subtag <= max_16_bit_ivector_subtag) {
      words = (elements+1) >> 1;
    } else if (subtag == subtag_double_float_vector) {
      words = 1 + (elements << 1);
    } else {
      words = (elements+31) >> 5;
    }
    words += (1 - (words & 1));
    if (subtag != subtag_code_vector) {
      for (i = 0; i < words; i++) {
        write_fullword(*current++);
      }
      prefix_bytes += (4 + (words<<2));
    } else {
      prefix_bytes += 4;
      seen_tb = false;
      for (i = 0; i < words; i++) {
        instr = *current++;
        if (instr == 0) {
          seen_tb = true;
        }
        if (! seen_tb) {
          b.opcode = instr;
          if ((b.b.op == 0x12) && (b.b.aa == 1)) {
            spno = (b.b.li << 2) - subpbase;
            b.b.aa = 0;
            b.b.li = -((prefix_bytes - spno) >> 2);
            instr = b.opcode;
          }
        }
        write_fullword(instr);
        prefix_bytes += 4;
      }
    }
  }
  flush_fullword_buffer();
}


void
write_pure_section(logical_section *sect)
{
  PEF_section *psect = sect->section.physical_section;
  long curpos, nbytes;
  area_list *areas;
  area *a;
  unsigned prefix_bytes = -8;

  align_section_data(3, &curpos);
  psect->offset = (curpos - PEF_container_pos);
  areas = sect->contents;

  while (areas) {
    a = areas->area;
    areas = areas->next;
    nbytes = a->active - a->low;
    if (a->h == NULL) {
      PEF_write(pef_refnum, &nbytes, a->low);
    } else {
      write_purified_area((LispObj *) a->low, (LispObj *) a->active, prefix_bytes);
    }
    prefix_bytes += nbytes;
  }
}

/*
  write relocation opcodes for section 'lsect'; don't touch
  lsect's actual contents.  'funky' indicates that the
  first several words of the data section contain
  pointers that may not -look- like pointers and thus
  that require special treatment.

*/

void
encode_relocations(logical_section *lsect, 
                   int funky, 
                   unsigned *countp, 
                   int current_section)
{
  int run_length = 0, run_length_limit = 0, last_section = -1, target_section;
  area_list *areas = lsect->contents;
  area *a;

  LispObj
    *current,
    *limit,
    header,
    *logaddr = 0,                 /* Current logical word address */
    *raddr = 0;                   /* Word address "beyond" last relocation */
  unsigned elements, subtag, nbytes, nwords, tag, delta_words, delta_bytes, nrelocs = 0;


  while (areas) {
    a = areas->area;
    areas = areas->next;

    current = (LispObj *) a->low;
    limit = (LispObj *) a->active;

    while (current < limit) {
      if (funky) {
        switch (funky) {
        case FUNKY_APPLICATION_PRIMARY:
        case FUNKY_NILREG_DATA:
          /*
            Start of static area looks like:
            dc.l header
            dc.l <import-ref> to import for kernel startup
            dc.l CODE ref to entrypoint
            dc.l DATA ref to nil (TOC)
            dcb.l 1024,various
            where there are 2 data refs, a 0, 2 code refs, and 1019 0s.
            We then resume normal programming at nil: 0 nil nil 0.
            Or, in the FUNKY_NILREG_DATA case: CODE nil nil SYMB.
            Ok, it gets normal -after- nil.
            */

          output_DELTA(4);
          (void)section_reference_offset((LogicalAddress)current[1], &target_section);
          output_SYMB(target_section-num_load_sections);
          output_CODE();          /* Could also do a DSC2 */
          output_DATA();
          delta_last_reloc(2);
          (void)section_reference_offset((LogicalAddress)current[6], &target_section);
          if (target_section < 0) {
            output_DELTA(4);
          } else {
            output_SECN(target_section);    /* link to mutable_data_section_header */
          }
          output_CODE();
          delta_last_reloc(1);
          if (funky == FUNKY_NILREG_DATA) {
            output_DELTA(1019*4);
            output_CODE();
            output_DATA();
            delta_last_reloc(1);
            (void)section_reference_offset((LogicalAddress)APPLICATION_LOADER_CFM_IMPORT, &target_section);
            output_SYMB(target_section-num_load_sections);
            *countp = 10;
            flush_halfword_buffer();            
            return;
          }
          raddr += 9;
          nrelocs = 6;
          break;

        case FUNKY_LIBRARY_DATA:                 /* library data section */
          output_CODE();
          delta_last_reloc(1);
          raddr += 2;
          nrelocs = 1;
          last_section = 1;
          break;

        case FUNKY_PRIVATE_MUTABLE_DATA:                 /* mutable_data_section_header */
          (void)section_reference_offset((LogicalAddress)current[1], &target_section);
          if (target_section >= 0) {
            output_DELTA(4);
            output_SECN(target_section);
            nrelocs = 2;
          } else {
            output_DELTA(8);
            nrelocs = 1;
          }
          output_SECN(current_section);
          output_SECN(current_section);
          (void)section_reference_offset((LogicalAddress)current[4], &target_section);
          output_SYMB(target_section-num_load_sections);
          output_SYMB(target_section-num_load_sections);
          nrelocs += 4;
          raddr += 24;
          funky = 0;
          break;
        }
        funky = 0;
      }
      header = *current;
      tag = fulltag_of(header);

      if (tag == fulltag_nodeheader) {
        if (((int) current) & 4) {
          Bug("Header shouldn't be here: 0x%08x\n", current);
        }
        current++;
        logaddr++;
        last_section = -1;
      } else if (tag == fulltag_immheader) {
        if (((int) current) & 4) {
          Bug("Header shouldn't be here: 0x%08x\n", current);
        }
        elements = header_element_count(header);
        subtag = header_subtag(header);

        if (subtag <= max_32_bit_ivector_subtag) {
          nbytes = (11 + (elements << 2)) & ~7;
        } else if (subtag <= max_8_bit_ivector_subtag) {
          nbytes = (11 + elements) & ~7;
        } else if (subtag <= max_16_bit_ivector_subtag) {
          nbytes = (11 + (elements << 1)) & ~7;
        } else if (subtag == subtag_double_float_vector) {
          nbytes = 8 + (elements << 3);
        } else {
          nbytes = (11 + ((elements + 7) >> 3)) & ~7;
        }
        nwords = nbytes >> 2;
        current += nwords;
        logaddr += nwords;
        last_section = -1;
      } else {                  /* not a header */
        if ((tag == fulltag_misc) ||
            (tag == fulltag_cons) ||
            (tag == fulltag_nil)) {
          (void) section_reference_offset((LogicalAddress) header, &target_section);
          if (target_section >= 0) {
            /* A relocatable object */
            delta_words = logaddr-raddr;
            delta_bytes = delta_words << 2;

            if ((target_section == last_section) &&
                (delta_words == 0) &&
                (++run_length < run_length_limit)) {
              delta_last_reloc(1);
            } else {
              if ((target_section == 1) &&
                  (255 >= delta_words) &&
                  (delta_words >= 1)) {
                output_DDAT(delta_words);
                nrelocs++;
                run_length_limit = 64;
              } else {
                while (delta_bytes >= 4096) {
                  output_DELTA(4096);
                  nrelocs++;
                  delta_bytes -= 4096;
                }
                if ((delta_bytes &= 4095) != 0) {
                  output_DELTA(delta_bytes);
                  nrelocs++;
                }
                switch (target_section) {
                case 0:
                  output_CODE();
                  run_length_limit = 512;
                  break;

                case 1:
                  output_DATA();
                  run_length_limit = 512;
                  break;

                default:
                  if (target_section < num_load_sections) {
                    output_SECN(target_section);
                  } else {
                    output_SYMB(target_section-num_load_sections);
                  }
                  run_length_limit = 0; /* screw: should use RPT */
                  break;
                }
                nrelocs++;
              }
              last_section = target_section;
              run_length = 1;
            }
            raddr = 1 + logaddr;
          }
        }
        current++;
        logaddr++;
      }
    }
  }
  *countp = nrelocs;
  flush_halfword_buffer();
}


void
write_backpatch(long pos, long size, void *data)
{
  long curpos;

  PEF_getpos(pef_refnum, &curpos);
  PEF_setpos(pef_refnum, fsFromStart, pos);
  PEF_write(pef_refnum, &size, data);
  PEF_setpos(pef_refnum, fsFromStart, curpos);
}


#define ROTL(x)  ( ( (x) << 1 ) - ( (x) >> (16) ) )

unsigned
hash_code(char *name, int length)
{
  int hash = 0;
  int len = 0;

  while (*name) {
    hash = ROTL(hash);
    hash ^= *name++;
    len++;
    if (--length == 0) break;
  }
  return ((unsigned short) (hash ^ (hash >> 16))) | (len << 16);
}


/*
  Write the loader section.  Make a pass over each
  section that -could- have relocations; we're screwed
  if there are any that -could- but dont.  Of course
  (a) this can't happen yet and (b) we probably aren't
  screwed too badly: we'll just create a relocation
  header that doesn't describe anything.
*/

void
write_loader_section(Boolean is_lib, unsigned init_section, unsigned init_offset)
{
  long curpos, loaderpos, relocpos, nbytes;
  loader_header lh;
  import_container container;
  import_symbol imp;
  relocation_header r;
  logical_import_container *logcontainerP;
  global_string_table *lst = make_gst();
  int num_exports, i, hash_slot_shift;
  logical_export **exports, *exp;
  logical_section *lsp;
  char *namep;

  num_exports = is_lib ? num_load_sections : 0;
  exports = construct_logical_exports(num_exports);
  hash_slot_shift = hash_chain_shift(num_exports);

  for (i = 0; i < num_exports; i++) {
    exp = exports[i];

    if (i == 0) {
      namep = "code0";
    } else if (i == 1) {
      namep = "data1";
    } else {
      namep = (import_containers+(i-2))->name;
    }
    strcpy(exp->name, namep);
    exp->section_number = i;
    exp->value = 0;
    exp->class = (i == 0) ? kCodeSymbol : kDataSymbol;
    exp->hash_code = hash_code(exp->name, 0);
    exp->gst_index = add_global_string(lst, exp->name, false);
    exp->hash_slot_index = hash_code_slot(exp->hash_code, hash_slot_shift);
  }

  qsort(exports, (size_t)num_exports, (size_t) sizeof(logical_export *), (sortfn)compare_logical_exports);
  align_section_data(3, &curpos);
  loaderpos = curpos;
  if (is_lib) {
    lh.entry_section = 0xffffffff;
    lh.entry_offset = 0;
  } else {
    lh.entry_section = 1;         /* Static rnil-relative section */
    lh.entry_offset = 8;          /* magic address in that section */
  }
  lh.init_section = init_section;
  lh.init_offset = init_offset;
  lh.term_section = 0xffffffff;
  lh.term_offset = 0;
  lh.num_import_containers = num_import_containers;
  lh.num_import_symbols = num_import_sections;
  lh.num_reloc_sections = num_load_sections - 1;
  lh.reloc_table_offset = 0;    /* backpatch later */
  lh.lst_offset = 0;            /* backpatch later */
  lh.hash_slot_table_offset = 0;/* backpatch later */
  lh.hash_slot_shift = hash_slot_shift;
  lh.export_count = num_exports;

  nbytes = sizeof(loader_header);
  PEF_write(pef_refnum, &nbytes, &lh);

  curpos += nbytes;

  {
    int next_imp = 0;
    for (i = 0, next_imp = 0, logcontainerP = import_containers; i < num_import_containers; i++, logcontainerP++) {
      container.name = add_global_string(lst, logcontainerP->name, true);
      container.old_imp_version = logcontainerP->old_imp_version;      
      container.current_version = logcontainerP->current_version;
      container.import_count = logcontainerP->num_imports;
      container.first_import = next_imp;
      next_imp += logcontainerP->num_imports;
      container.initorder = 0;      /* no initbefore/weak flags */
      if ((logcontainerP->flags & kWeakImport) != 0) {
        container.initorder |= kWeakLib;
      }
      container.reserved[0] = container.reserved[1] = container.reserved[2] = 0;
      nbytes = sizeof(import_container);
      PEF_write(pef_refnum, &nbytes, &container);
      curpos += nbytes;
    }
  }

  for (i = num_load_sections; (lsp = logical_sections[i]) != NULL; i++) {
    imp.class = lsp->section.external_section->class;
    imp.name_offset = add_global_string(lst, lsp->section.external_section->name, true);
    nbytes = sizeof(import_symbol);
    PEF_write(pef_refnum, &nbytes, &imp);
    curpos += nbytes;
  }

  for (i = 1; i < num_load_sections; i++) {
    lsp = logical_sections[i];
    r.section_number = i;
    r.reserved = 0;
    r.relocation_count = 0;       /* fill in later */
    r.first_relocation = 0;
    lsp->relocpos = curpos;
    nbytes = sizeof(relocation_header);
    PEF_write(pef_refnum, &nbytes, &r);
    curpos += nbytes;
  }

  relocpos = curpos - loaderpos;

  lh.reloc_table_offset = relocpos;

  {
    unsigned rcount, rtotal = 0;
    for (i = 1; i < num_load_sections; i++) {
      lsp = logical_sections[i];
      encode_relocations(lsp, 
                         (i == 1) ? 
                         (is_lib ? 
                          FUNKY_LIBRARY_DATA : 
                          ((init_section == 0xffffffff) ? FUNKY_APPLICATION_PRIMARY : 
                           FUNKY_NILREG_DATA)) : 
                         FUNKY_PRIVATE_MUTABLE_DATA , &rcount, i);
      {
        long newpos;

        PEF_getpos(pef_refnum, &newpos);
        
        if (newpos != (curpos + (rcount * 2))) {
          Bug("Bad relocation count for section %d : got %d, expected %d\n", i, rcount, (newpos - curpos)/2);
        }
      }
      curpos += (rcount * 2);
      r.section_number = i;
      r.relocation_count = rcount;
      r.first_relocation = (rtotal+rtotal);
      rtotal += rcount;
      write_backpatch(lsp->relocpos, sizeof(relocation_header), &r);
    }
  }

  lh.lst_offset = (curpos - loaderpos);
  while (lst->logsize & 3) {
    add_global_string(lst, "", true);
  }
  nbytes = lst->logsize;
  PEF_write(pef_refnum, &nbytes, lst->data);
  curpos += nbytes;

  lh.hash_slot_table_offset = (curpos - loaderpos);

  {
    int first = 0, count, j, k = 1<<hash_slot_shift;
    for (i = 0; i < k; i++) {
      count = 0;
      for (j = first; j < num_exports;j++) {
        if ((exports[j]->hash_slot_index) == i) {
          count++;
        } else {
          break;
        }
      }
      write_fullword((count<<18) | first);
      curpos += 4;
      first += count;
    }
  }

  for (i = 0; i < num_exports; i++) {
    write_fullword(exports[i]->hash_code);
    curpos += 4;
  }
  flush_fullword_buffer();
  {
    PEF_export_symbol PEFsym;

    for (i = 0; i < num_exports; i++) {
      exp = exports[i];
      PEFsym.class = exp->class;
      PEFsym.name_offset = exp->gst_index;
      PEFsym.value = exp->value;
      PEFsym.section_number = exp->section_number;
      nbytes = PEF_export_symbol_size;
      PEF_write(pef_refnum, &nbytes, &PEFsym);
      curpos += nbytes;
    }
  }

  {
    PEF_section *sectp = sections+num_load_sections;
    sectp->execsize = sectp->initsize = 0;
    sectp->rawsize = curpos - loaderpos;
    sectp->offset = loaderpos - PEF_container_pos;
  }
  write_backpatch(loaderpos, sizeof(loader_header), &lh);
}


void
initialize_sections(int libnum, Boolean nilreg_p)
{
  int i;
  PEF_section *sectp = sections;
  logical_section *ls;

  /* Section 0 is a code section.  Sections 1 thru (1- num_load_sections) are
     context shared data sections (maybe pidata).  The last section is a loader
     section.
     */

  for (i = 0; i < num_sections; i++, sectp++) {
    if (i < num_load_sections) {
      sectp->alignment = 4;
    } else {
      sectp->alignment = 0;
    }
    sectp->name = 0xffffffff;
    sectp->addr = 0;
    sectp->execsize = sectp->initsize = sectp->rawsize = 0;
    sectp->offset = 0;
    if (i == 0) {
      sectp->region_kind = section_kind_code;
      sectp->sharing_kind = kGlobalShare;
    } else if (i < num_load_sections) {
      sectp->region_kind = section_kind_data;
      sectp->sharing_kind = kContextShare;
    } else {
      sectp->region_kind = section_kind_loader;
      sectp->sharing_kind = kGlobalShare;
    }
    sectp->pad = 0;
  }

  /*
    Data sections other than section 1 are those
    with a non-zero owner.
    */

  ls = logical_sections[0];

  /* First, if we're saving an application, add "orphaned" readonly
     sections from excised libraries.
     next add any readonly sections that lisp (purify) has consed up;
     then, add the original readonly section.
     */
  if (libnum == 0) {
    /* It's pretty stupid to excise a library that was
       just created, but what the hell ... */
    collect_lsect_areas(ls, AREA_READONLY, 1, true, false);
    collect_lsect_areas(ls, AREA_READONLY, 1, false, false);
  }
  collect_lsect_areas(ls, AREA_READONLY, libnum, true, false);
  collect_lsect_areas(ls, AREA_READONLY, libnum, false, false);

  /* The (primary) data section */
  ls = logical_sections[1];
  if (libnum > 0) {
    collect_lsect_areas(ls, AREA_STATICLIB, libnum, true, false);
    collect_lsect_areas(ls, AREA_STATICLIB, libnum, false, false);
  } else {
    if (nilreg_p == false) {
      collect_lsect_areas(ls, AREA_DYNAMIC, 0, true, false);
      collect_lsect_areas(ls, AREA_STATIC, 0, false, false);
    }
    collect_lsect_areas(ls, AREA_STATIC, 0, false, true);

    /* Mutable-data sections (AREA_STATIC) "owned" by lisp libraries */
    for (i = 2; i < num_load_sections; i++) {
      ls = logical_sections[i];
      /* Since "maybe" isn't of type Boolean, we call this twice.
         Only one of these will succeed. */
      collect_lsect_areas(ls, AREA_STATIC, i, false, false);
      collect_lsect_areas(ls, AREA_STATIC, i, true, false);
    }
  }
}


/*
  Open the data fork of the current application
  */

OSErr
open_application_data_fork (short *refnum)
{

  ProcessSerialNumber psn;
  ProcessInfoRec info;
  FSSpec fs;
  OSErr err;

  psn.highLongOfPSN = 0;
  psn.lowLongOfPSN = kCurrentProcess;

  info.processInfoLength = sizeof(info);
  info.processName = NULL;
  info.processAppSpec = &fs;

  err = GetProcessInformation(&psn, &info);
  if (err != noErr) return(err);

  return FSpOpenDF(&fs, fsRdPerm, refnum);

}

OSErr
copy_cfm_container(short from_refnum, long from_offset, long length, short to_refnum, long *to_offset)
{
  unsigned char *buf = pi_buffer;
  long buf_size = sizeof(pi_buffer), to_pos, bytes_to_copy = length, fill_bytes, index;
  OSErr err;

  if ((err = SetFPos(from_refnum, fsFromStart, from_offset)) != noErr)
    return(err);
  if ((err = GetFPos(to_refnum, &to_pos)) != noErr)
    return(err);

  /* Align start of container to 16 byte boundary */
  fill_bytes = (((to_pos + 15) >> 4) << 4) - to_pos;
  if (fill_bytes > 0) {
    long i;
    to_pos = to_pos + fill_bytes;
    for (i = 0; i < fill_bytes; i++) {
      buf[i] = 0;
    };
    if ((err = FSWrite(to_refnum, &fill_bytes, buf)) != noErr)
      return(err);
  };
  
  for (index = 0; index < length; index = index + buf_size) {
    long count = (buf_size < bytes_to_copy) ? buf_size : bytes_to_copy;

    bytes_to_copy = bytes_to_copy - count;

    if ((err = FSRead(from_refnum, &count, buf)) != noErr)
       return(err);
    if ((err = FSWrite(to_refnum, &count, buf)) != noErr)
       return(err);
  };

  *to_offset = to_pos;
  return(noErr);

}

/*
  The 'cfrg(0)' resource for the application has already been created.
  It should have exactly one member which describes an application fragment.
  Use the values of 'pef_end' and 'PEF_container_pos' to set the start and
  length fields in the cfrg resource.

  'refnum' is the refnum of the application's data fork; we need to open
  the resource file.

*/

OSErr
update_pef_cfrg(short refnum, long pef_end)
{
  FCBPBRec hGetVolRecord;
  Str255 filename;
  FSSpec theFSS;
  short resfile, app_refnum;
  Boolean got_app_refnum = false;
  OSErr err;

  hGetVolRecord.ioCompletion = nil;
  hGetVolRecord.ioFCBIndx = 0;
  hGetVolRecord.ioVRefNum = 0;
  hGetVolRecord.ioRefNum = refnum;
  filename[ 0 ] = 0;
  hGetVolRecord.ioNamePtr = (StringPtr) filename;
  
  if ((err = PBGetFCBInfoSync(&hGetVolRecord)) != noErr) {
    return err;
  }
  if ((err = FSMakeFSSpec(hGetVolRecord.ioFCBVRefNum, hGetVolRecord.ioFCBParID, filename, &theFSS))
      != noErr) {
    return err;
  }

  resfile = FSpOpenResFile(&theFSS, fsRdWrPerm);
  if (resfile == -1) {
    return ResError();
  }
  {
    Handle h;
    cfrg *cfragp;
    cfrg_member *member;
    long nmembers, i;

    h = Get1Resource(kCFragResourceType, kCFragResourceID);
    if ((h == NULL) || (*h == NULL)) {
      err = ResError();
      CloseResFile(resfile);
      return err;
    }

    HLock(h);
    cfragp = *(cfrg **) h;
    nmembers = cfragp->nmembers;
    member = cfragp->members;
    for (i = 0; i < nmembers; i++) {
      if (member->usage == kApplicationCFrag) {
        member->offset = PEF_container_pos;
        member->length = pef_end - PEF_container_pos;
        ChangedResource(h);
      } else if (member->where == kDataForkCFragLocator) {
        if (!got_app_refnum) {
          long pos;
          if ((err = open_application_data_fork(&app_refnum)) != noErr) break;
          got_app_refnum = true;
          if ((err = GetEOF(refnum, &pos)) != noErr) break;
          if ((err = SetFPos(refnum, fsFromStart, pos)) != noErr) break;
        }
        if ((err = copy_cfm_container(app_refnum, member->offset, member->length, refnum, &(member->offset)))
            != noErr) break;
        ChangedResource(h);
      };
      member = (cfrg_member *) (((BytePtr) member) + member->member_size);
    };

    if (got_app_refnum) {
      FSClose(app_refnum);
    };

    UpdateResFile(resfile);
    CloseResFile(resfile);
  }
  return err;
}



/* Write out the heap(s) to the open file 'refnum'.
   If successful, close the file and exit().
   If an error occurs, return it to code that's in
   no position to do anything useful.
*/

OSErr
write_PEF_file(short refnum, 
               Boolean is_lib,
               unsigned lib_version, 
               unsigned init_section, 
               unsigned init_offset)
{
  OSErr err = noErr;
  PEF_header file_header;
  long iobytes, section_header_pos, eofpos;
  int i;

  init_pef_io(refnum);
  collect_excised_sections();

  file_header.magic = sufficiently_advanced;
  file_header.containerID = 'peff';
  file_header.arch = kPowerPCCFragArch;
  file_header.version = 1;
  GetDateTime((unsigned long *) &file_header.timestamp);
  file_header.olddefversion = file_header.oldimpversion = file_header.curversion = lib_version;
  file_header.nsections = num_sections;
  file_header.nloadsections = num_load_sections;
  file_header.memoryaddress = 0;

  iobytes = sizeof(PEF_header);
  PEF_write(refnum, &iobytes, &file_header);
  PEF_getpos(refnum, &section_header_pos);

  iobytes = sizeof(PEF_section) * num_sections;
  PEF_write(refnum, &iobytes, sections);

  write_pure_section(logical_sections[0]);

  write_data_section(logical_sections[1], is_lib ? FUNKY_LIBRARY_DATA : 
                     (( init_section == 0xffffffff) ?  FUNKY_APPLICATION_PRIMARY :
                      FUNKY_NILREG_DATA));

  for (i = 2; i < num_load_sections; i++) {
    write_data_section(logical_sections[i], FUNKY_PRIVATE_MUTABLE_DATA);
  }

  write_loader_section(is_lib, init_section, init_offset);

  write_backpatch(section_header_pos,
                  sizeof(PEF_section) * num_sections,
                  sections);

  PEF_getpos(pef_refnum, &eofpos);

  PEF_seteof(pef_refnum, eofpos);
  
  if (init_section != 0xffffffff) {
    err = save_application_data(pef_refnum, false);
    if (err != noErr) return err;
  }

  if (lib_version == 0) {
    update_pef_cfrg(pef_refnum, eofpos);
  }

  err = FSClose(pef_refnum);


  return err;
}


OSErr
save_old_application(short refnum)
{
  int i, j, nlogsect;
  logical_section *lsp;
  static_header *static_headerP;
  mutable_data_section_header *libP;
  logical_import_container *imp;
  logical_import *limp;
  OSErr err;

  SetCursor(*(GetCursor(watchCursor)));
  ShowCursor();

  err = setjmp(PEFjmp);
  if (err == noErr) {

    num_load_sections = next_libnum;
    num_sections = num_load_sections+1;
    num_import_containers = 1 + (next_libnum-2);
    num_import_sections = 1 + (2 * (next_libnum-2));

    /* We need an entry in the logical_sections table for each
       section that's present in the application, 2 for each lisp
       library, and 1 for the kernel. */

    nlogsect = num_load_sections+num_import_sections;

    sections = PEF_alloc(sizeof(PEF_section)*num_sections);

    lsp = PEF_alloc(sizeof(logical_section)*nlogsect);

    logical_sections = PEF_alloc(sizeof(logical_section *)*(nlogsect+1));

    limp = PEF_alloc(sizeof(logical_import)*num_import_sections);

    for (i = 0; i < num_load_sections;i++) {
      logical_section *lspP = lsp+i;
      logical_sections[i] = lspP;
      lspP->contents = NULL;
      lspP->relocpos = 0;
      lspP->external = false;
      lspP->section.physical_section = sections+i;
    }

    for (i = num_load_sections; i < nlogsect; i++) {
      logical_section *lspP = lsp+i;
      logical_sections[i] = lspP;
      lspP->contents = NULL;
      lspP->relocpos = 0;
      lspP->external = true;
      lspP->section.external_section = NULL;
    }

    logical_sections[nlogsect] = NULL;

    initialize_sections(0, false);

    /* Create import containers for all libraries + the kernel */
    import_containers = PEF_alloc(sizeof(logical_import_container)*num_import_containers);
    static_headerP = (static_header *) (&(lisp_global(STATIC_HEAP_START)));
    libP = static_headerP->next;

    for (i = 2, imp = import_containers; i < next_libnum;i++,  imp++, libP = libP->next) {
      imp->name = libP->libname;
      imp->flags = (libP->flags & kWeakImport);
      imp->num_imports = 2;
      imp->old_imp_version = imp->current_version = libP->timestamp;
    }
    imp->name = KERNEL_CFRG_NAME;
    imp->num_imports = 1;
    imp->current_version = KERNEL_CURRENT_VERSION;
    imp->old_imp_version = KERNEL_IMPLEMENTATION_VERSION;

    for (i = 2, j = num_load_sections, imp = import_containers; i < num_load_sections; i++, imp++) {
      lsp = logical_sections[j];
      lsp->external = true;
      lsp->contents = NULL;
      lsp->section.external_section = limp;
      limp->name = "code0";
      limp->class = kCodeSymbol | imp->flags;
      limp->container = imp;
      collect_lsect_areas(lsp, AREA_READONLY, i, true, false);
      collect_lsect_areas(lsp, AREA_READONLY, i, false, false);
      j++; limp++;
      lsp = logical_sections[j];
      lsp->external = true;
      lsp->contents = NULL;
      lsp->section.external_section = limp;
      limp->name = "data1";
      limp->class = kDataSymbol | imp->flags;
      limp->container = imp;
      collect_lsect_areas(lsp, AREA_STATICLIB, i, true, false);
      collect_lsect_areas(lsp, AREA_STATICLIB, i, false, false);
      j++;limp++;
    }
    limp->name = "set_nil_and_start";
    limp->container = imp;
    limp->class = kTVectSymbol;
    logical_sections[j]->section.external_section = limp;
    {
      area *a;
      area_list *list;
      BytePtr p = (BytePtr)MAIN_CFM_IMPORT;
      a = new_area(p, p+4, AREA_READONLY);
      list = PEF_alloc(sizeof(area_list));
      list->area = a;
      list->next = NULL;
      logical_sections[j]->contents = list;
    }

    err = write_PEF_file(refnum, false, 0, 0xffffffff, 0);
  }
  return err;
}

OSErr
save_application(short refnum)
{
  int i, j, nlogsect;
  logical_section *lsp;
  static_header *static_headerP;
  mutable_data_section_header *libP;
  logical_import_container *imp;
  logical_import *limp;
  OSErr err;

  SetCursor(*(GetCursor(watchCursor)));
  ShowCursor();

  find_or_create_nilreg_area();
  err = setjmp(PEFjmp);
  if (err == noErr) {

    num_load_sections = next_libnum;
    num_sections = num_load_sections+1;
    num_import_containers = 1 + (next_libnum-2); /* 1 for kernel, 1 for each library */
    num_import_sections = 2 + (2 * (next_libnum-2)); /* 2 from kernel, 2 from each library */

    /* We need an entry in the logical_sections table for each
       section that's present in the application, 2 for each lisp
       library, and 2 for the kernel. */

    nlogsect = num_load_sections+num_import_sections;

    sections = PEF_alloc(sizeof(PEF_section)*num_sections);

    lsp = PEF_alloc(sizeof(logical_section)*nlogsect);

    logical_sections = PEF_alloc(sizeof(logical_section *)*(nlogsect+1));

    limp = PEF_alloc(sizeof(logical_import)*num_import_sections);

    for (i = 0; i < num_load_sections;i++) {
      logical_section *lspP = lsp+i;
      logical_sections[i] = lspP;
      lspP->contents = NULL;
      lspP->relocpos = 0;
      lspP->external = false;
      lspP->section.physical_section = sections+i;
    }

    for (i = num_load_sections; i < nlogsect; i++) {
      logical_section *lspP = lsp+i;
      logical_sections[i] = lspP;
      lspP->contents = NULL;
      lspP->relocpos = 0;
      lspP->external = true;
      lspP->section.external_section = NULL;
    }

    logical_sections[nlogsect] = NULL;

    initialize_sections(0, true);

    /* Create import containers for all libraries + the kernel */
    import_containers = PEF_alloc(sizeof(logical_import_container)*num_import_containers);
    static_headerP = (static_header *) (&(lisp_global(STATIC_HEAP_START)));
    libP = static_headerP->next;

    import_containers->name = KERNEL_CFRG_NAME;
    import_containers->num_imports = 2;
    import_containers->current_version = KERNEL_CURRENT_VERSION;
    import_containers->old_imp_version = KERNEL_IMPLEMENTATION_VERSION;
    import_containers->flags = 0;

    for (i = 2, imp = import_containers+1; i < next_libnum;i++,  imp++, libP = libP->next) {
      imp->name = libP->libname;
      imp->flags = (libP->flags & kWeakImport);
      imp->num_imports = 2;
      imp->old_imp_version = imp->current_version = libP->timestamp;
    }

    imp = import_containers;
    j = num_load_sections;
    limp->name = "set_nil_and_start";
    limp->container = imp;
    limp->class = kTVectSymbol;
    logical_sections[j]->section.external_section = limp;
    {
      area *a;
      area_list *list;
      BytePtr p = (BytePtr)MAIN_CFM_IMPORT;
      a = new_area(p, p+4, AREA_READONLY);
      list = PEF_alloc(sizeof(area_list));
      list->area = a;
      list->next = NULL;
      logical_sections[j]->contents = list;
    }
    j++; limp++;

    limp->name = "application_loader";
    limp->container = imp;
    limp->class = kTVectSymbol;
    logical_sections[j]->section.external_section = limp;
    {
      area *a;
      area_list *list;
      BytePtr p = (BytePtr)APPLICATION_LOADER_CFM_IMPORT;
      a = new_area(p, p+4, AREA_READONLY);
      list = PEF_alloc(sizeof(area_list));
      list->area = a;
      list->next = NULL;
      logical_sections[j]->contents = list;
    }
    j++; limp++; imp++;

    for (i = 2; i < num_load_sections; i++, imp++) {
      lsp = logical_sections[j];
      lsp->external = true;
      lsp->contents = NULL;
      lsp->section.external_section = limp;
      limp->name = "code0";
      limp->class = kCodeSymbol | imp->flags;
      limp->container = imp;
      collect_lsect_areas(lsp, AREA_READONLY, i, true, false);
      collect_lsect_areas(lsp, AREA_READONLY, i, false, false);
      j++; limp++;
      lsp = logical_sections[j];
      lsp->external = true;
      lsp->contents = NULL;
      lsp->section.external_section = limp;
      limp->name = "data1";
      limp->class = kDataSymbol | imp->flags;
      limp->container = imp;
      collect_lsect_areas(lsp, AREA_STATICLIB, i, true, false);
      collect_lsect_areas(lsp, AREA_STATICLIB, i, false, false);
      j++;limp++;
    }
    err = write_PEF_file(refnum, false, 0, 1, (unsigned)(lisp_nil-fulltag_nil)-(unsigned)(nilreg_area->low));
  }
  return err;
}

/*
  The simple case of a shared libary: no imports, minimal data.
  */

OSErr
save_library(short refnum, unsigned libnum, unsigned *versionP)
{
  OSErr err;
  int i, nlogsect;
  logical_section *lsp;

  SetCursor(*(GetCursor(watchCursor)));
  ShowCursor();

  *versionP = 0;
  err = setjmp(PEFjmp);
  if (err == noErr) {
    num_load_sections = 2;
    num_sections = num_load_sections+1;
    num_import_containers = 0;
    num_import_sections = 0;

    nlogsect = num_load_sections;

    sections = PEF_alloc(sizeof(PEF_section)*num_sections);

    lsp = PEF_alloc(sizeof(logical_section)*num_load_sections);

    logical_sections = PEF_alloc(sizeof(logical_section *)*(nlogsect+1));

    for (i = 0; i < num_load_sections;i++) {
      logical_section *lspP = lsp+i;
      logical_sections[i] = lspP;
      lspP->contents = NULL;
      lspP->relocpos = 0;
      lspP->external = false;
      lspP->section.physical_section = sections+i;
    }

    logical_sections[nlogsect] = NULL;

    initialize_sections(libnum, false);
    {
      int i;
      static_header *static_headerP = (static_header *) (&(lisp_global(STATIC_HEAP_START)));
      mutable_data_section_header *libP = static_headerP->next;
      unsigned version;
      
      for (i = 2; i < libnum; i++) {
        libP = libP->next;
      }
      
      version = libP->timestamp;
      *versionP = version;

      return write_PEF_file(refnum, true, version, 0xffffffff, 0);
    }
  }
  return err;
}
