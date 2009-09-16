/*
   Copyright (C) 1994-2001 Digitool, Inc
   This file is part of OpenMCL.  

   OpenMCL is licensed under the terms of the Lisp Lesser GNU Public
   License , known as the LLGPL and distributed with OpenMCL as the
   file "LICENSE".  The LLGPL consists of a preamble and the LGPL,
   which is distributed with OpenMCL as the file "LGPL".  Where these
   conflict, the preamble takes precedence.  

   OpenMCL is referenced in the preamble as the "LIBRARY."

   The LLGPL is also available online at
   http://opensource.franz.com/preamble.html
*/

#include "lisp.h"
#include "area.h"
#include "lisp-exceptions.h"
#include "lisp_globals.h"


void
describe_symbol(LispObj sym)
{
  lispsymbol *rawsym = (lispsymbol *)(untag(sym));
  LispObj function = rawsym->fcell;

  Dprintf("Symbol %s at #x%08X", print_lisp_object(sym), sym);
  Dprintf("  value    : %s", print_lisp_object(rawsym->vcell));
  if (function != nrs_UDF.vcell) {
    Dprintf("  function : %s", print_lisp_object(function));
  }
}
  
  
unsigned skip_over_ivector(unsigned, LispObj);

/*
  Walk the heap until we find a symbol
  whose pname matches "name".  Return the 
  tagged symbol or NULL.
*/

LispObj
find_symbol_in_range(LispObj *start, LispObj *end, char *name)
{
  LispObj header;
  int n = strlen(name);
  char *s = name, *p;
  while (start < end) {
    header = *start;
    if (header_subtag(header) == subtag_symbol) {
      LispObj 
        pname = deref(start, 1),
        pname_header = header_of(pname);
      if ((header_subtag(pname_header) == subtag_simple_base_string) &&
          (header_element_count(pname_header) == n)) {
        p = (char *) (pname + misc_data_offset);
        if (strncmp(p, s, n) == 0) {
          return ((LispObj)start)+fulltag_misc;
        }
      }
    }
    if (fulltag_of(header) == fulltag_nodeheader) {
      start += (~1 & (2 + header_element_count(header)));
    } else if (fulltag_of(header) == fulltag_immheader) {
      start = (LispObj *) skip_over_ivector((unsigned)start, header);
    } else {
      start += 2;
    }
  }
  return (LispObj)NULL;
}

LispObj 
find_symbol(char *name)
{
  area *a =  ((area *) lisp_global(ALL_AREAS))->succ;
  area_code code;
  LispObj sym;

  while ((code = a->code) != AREA_VOID) {
    if ((code == AREA_STATIC) ||
        (code == AREA_DYNAMIC)) {
      sym = find_symbol_in_range((LispObj *)(a->low), (LispObj *)(a->active), name);
      if (sym) {
        break;
      }
    }
    a = a->succ;
  }
  return sym;
}

    
void 
plsym(ExceptionInformation *xp, char *pname) 
{
  long	address = 0;

  address = find_symbol(pname);
  if (address == 0) {
    Dprintf("Can't find symbol.");
    return;
  }
  
  if ((fulltag_of(address) == fulltag_misc) &&
      (header_subtag(header_of(address)) == subtag_symbol)){
    describe_symbol(address);
  } else {
    fprintf(stderr, "Not a symbol.\n");
  }
  return;
}

