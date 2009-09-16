/*

$Log: kernel-init.c,v $
Revision 1.3  2006/02/03 19:58:18  alice
probably no change

Revision 1.2  2002/11/25 05:58:42  gtbyers
Add CVS log marker.  native_set_nil_and_start takes extra parameters to pass CFM kernel imports to native kernel.


;;      Change History (most recent first):
;;  12 4/19/96 akh  d101 from gb
;;  (do not edit before this line!!)
*/

/* Find and load the subprims; establish (& export) subprims_base.
   This must happen before clients (which import subprims_base) get loaded
   by the OS PEF loader. */
   
/*
 11/27/06 try to lose subprims resource for OSX-KERNEL
  ------- 5,2b4
  01/30/01 akh HoldMemory and UnholdMemory missing in OSX Public Beta (phooey)
  01/24/01 akh if CARBON look there for thread stuff
  01/20/01 akh makedataexecutable after getmemfragment - bug in public beta
  12/17/00 akh dont insall vmfix period - trying to make 4.3.1 kernel work
       doesn't work because no longer in system heap(see makefile) so goes when MCL quits.
       Its absence doesn't seem to matter
 08/07/00 akh dont install vmfix if carbon either - makes quit not work
 07/20/00 akh dont install vmfix if osx
 04/04/00 akh lose getzone, setzone for carbon ????
 03/30/00 akh dont do threadslib if carbon - doesn't matter - the real problem was elsewhere
 03/28/00 akh runtime check for osx re getting subprims and move or don't 
 02/18/00 akh gestaltequ => gestalt, cfraghfslocatorptr again, kloAdlib -> kloadcfrag
  02/21/97 bill  Look up NewThread, DisposeThread, YieldToThread in "ThreadsLib".
  01/29/97 gb    export entrypoint descriptors for GCC.
  ------ 4.0
  06/10/96 gb    new exception scheme.
  ------ 3.9
  04/26/96 gb    projector comments inside C comments
  04/15/96 gb    load VMFX(1) if not already loaded.
  ------ 3.9f1c2
  04/10/96 gb    lib_initialize: always return noErr, let main() detect errors.
  03/26/96 gb    code cleanup.
  03/01/96 bill  Fix Alice's 2/27 checkin comment (2/27/96 below)
  03/01/96 gb   set cache_line_size from DriverServicesLib
  02/23/96 gb   bind theZone around CloseConnection call in lib_terminate.
  02/27/96  akh  gary's fix for closeconnection
  01/31/96 bill close the kernel's resource fork when we're done with it.
  01/25/96  gb  open kernel_refnum with fsRdPerm.  Initialize
                lexpr_return, lexpr_return1v from subprims exports.
  12/24/95  gb  lib_terminate kills vbl task.
  12/13/95  gb  M-x detabify.
*/

#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <CodeFragments.h>
#include <Resources.h>
#include <Files.h>
#include <Folders.h>
#include <Gestalt.h>
#include <Retrace.h>
#include <LowMem.h>
#include <timer.h>
#endif
/* #include "lisp.h" */

#include <stdio.h>

/* stdio for stderr only */

#ifdef __GNUC__
/*
   So far, GCC neglects to export a function's descriptor
   (it exports a label defined in the descriptor's csect
   instead.)  PPCLink needs to have the descriptors themselves
   exported in order to set up the -init and -term entry points.
   Note that this creates duplicate exported labels.
*/
#ifndef PMCL_OSX_NATIVE_KERNEL
asm (".globl lib_initialize[DS]");
asm (".globl lib_terminate[DS]");
#endif
#endif

typedef unsigned LispObj;
#define is_osx() (os_version >= 0x00001000)

LispObj subprims_base = 0;
LispObj lexpr_return = 0;
LispObj lexpr_return1v = 0;
LispObj *emulator_base = 0;

CFragConnectionID subprims_connection = 0;
CFragConnectionID mixedmode_connection = 0;
Handle subprims_handle = NULL;

CFragConnectionID threadslib_connection = 0;
CFragConnectionID interfacelib_connection = 0;
CFragConnectionID carbonlib_connection = 0;


ProcPtr our_NewThread = NULL,
        our_DisposeThread = NULL,
        our_YieldToThread = NULL,
        /* our_newthreadentry = NULL, */
        our_CallOSTrapUniversalProc = NULL,
        our_CallUniversalProc = NULL,
        our_NewHandleSys = NULL,
        our_LockMemory = NULL,
        our_UnlockMemory = NULL,
        our_HoldMemory = NULL,
        our_UnholdMemory = NULL;


int cache_block_size = 32;
short
kernel_refnum = 0;


unsigned
os_version = 0;

void
check_os_version ()
{ 
  Gestalt(gestaltSystemVersion, (long *)&os_version);
}

int altivec_available = 0;

void
check_for_altivec()
{
  long flags = 0;
  Gestalt(gestaltPowerPCProcessorFeatures, &flags);
  altivec_available = ((flags & (1 << gestaltPowerPCHasVectorInstructions)) != 0);
}
  

            
      
long SSXH_version = 0;

#ifdef CARBON
#define StripAddress(p) p
#endif

#ifndef PMCL_OSX_NATIVE_KERNEL
typedef enum {
    NSObjectFileImageFailure, /* for this a message is printed on stderr */
    NSObjectFileImageSuccess,
    NSObjectFileImageInappropriateFile,
    NSObjectFileImageArch,
    NSObjectFileImageFormat, /* for this a message is printed on stderr */
    NSObjectFileImageAccess
} NSObjectFileImageReturnCode;

NSObjectFileImageReturnCode (*native_NSCreateObjectFileImageFromFile)(char *, void**);
void * (* native_NSLinkModule)(void *, char *, unsigned);
void   (* native_NSDestroyObjectFileImage)(void *);
void * (* native_NSLookupSymbolInModule)(void *, char *);
void * (* native_NSAddressOfSymbol)(void *);

#define NSLINKMODULE_OPTION_NONE		0x0
#define NSLINKMODULE_OPTION_BINDNOW		0x1
#define NSLINKMODULE_OPTION_PRIVATE		0x2
#define NSLINKMODULE_OPTION_RETURN_ON_ERROR	0x4

void *
open_native_module(char *path)
{
  void *imagefile;
  void *module = NULL;

  if (native_NSCreateObjectFileImageFromFile(path, &imagefile) ==
      NSObjectFileImageSuccess) {
    module = native_NSLinkModule(imagefile, 
				 path,
				 NSLINKMODULE_OPTION_RETURN_ON_ERROR | 
				 NSLINKMODULE_OPTION_BINDNOW);
    native_NSDestroyObjectFileImage(imagefile);
  }
  return module;
}

/*
  This returns a (possibly null) pointer to a 2-element CFM transfer
  vector.
*/
void *
lookup_symbol_in_native_module(char *symname, void *module)
{
  if (module) {
    void *sym = native_NSLookupSymbolInModule(module, symname);
    if (sym) {
      void *addr = native_NSAddressOfSymbol(sym);
      if (addr) {
	/* Cons up a 2-element transfer vector to keep CFM happy. */
	void **tv = (void **)malloc(8);
	if (tv) {
	  tv[0] = addr;
	  tv[1] = NULL;
	  return tv;
	}
      }
    }
  }
  return NULL;
}

OSErr (*native_lib_initialize)(CFragInitBlockPtr) = NULL;
void (*native_set_nil_and_start)(LispObj, void *, void *) = NULL;
OSErr (*native_application_loader)(CFragInitBlockPtr,LispObj) = NULL;

CFBundleRef
get_system_bundle()
{
  FSRef fsr;

  if (FSFindFolder(kOnAppropriateDisk, kFrameworksFolderType, true, &fsr) ==
      noErr) {
    CFURLRef frameworksURL = CFURLCreateFromFSRef(NULL, &fsr);
    if (frameworksURL) {
      CFURLRef systemURL = 
	CFURLCreateCopyAppendingPathComponent(NULL, 
					      frameworksURL,
					      CFSTR("System.framework"),
					      false);
      if (systemURL) {
	CFBundleRef sysbundle = CFBundleCreate(NULL, systemURL);
	if (sysbundle && CFBundleLoadExecutable(sysbundle)) {
	  return sysbundle;
	}
      }
    }
  }    
  return (CFBundleRef)0;
}

void
find_native_library(CFragInitBlockPtr initblk)
{
  CFragSystem7LocatorPtr loc = &(initblk->fragLocator);
  CFragLocatorKind where = loc->where;

  if (CFragHasFileLocation (where)) {
    FSSpecPtr fss = loc->u.onDisk.fileSpec;
    FSSpec nativeLibfss;
    FSRef fsr;
    CFBundleRef systemBundle;

    /* systemBundle = CFBundleGetBundleWithIdentifier(CFSTR("com.apple.System")); */

    systemBundle = get_system_bundle();

    if (systemBundle) {
      (void *) 	native_NSCreateObjectFileImageFromFile = 
	CFBundleGetFunctionPointerForName(systemBundle,
					  CFSTR("NSCreateObjectFileImageFromFile"));

      (void *) native_NSLinkModule = 	
	CFBundleGetFunctionPointerForName(systemBundle,
					  CFSTR("NSLinkModule"));

      (void *) native_NSDestroyObjectFileImage = 
	CFBundleGetFunctionPointerForName(systemBundle,
					  CFSTR("NSDestroyObjectFileImage"));

      (void *) native_NSLookupSymbolInModule = 	
	CFBundleGetFunctionPointerForName(systemBundle,
					  CFSTR("NSLookupSymbolInModule"));

      (void *) native_NSAddressOfSymbol = 	
	CFBundleGetFunctionPointerForName(systemBundle,
					  CFSTR("NSAddressOfSymbol"));

      FSMakeFSSpec(fss->vRefNum,fss->parID,"\ppmcl-OSX-kernel", &nativeLibfss);

      if (FSpMakeFSRef(&nativeLibfss, &fsr) == noErr) {
	CFURLRef nativelibURL;
	
	if (nativelibURL = CFURLCreateFromFSRef(NULL, &fsr)) {
	  unsigned char nativelibpath[1024];
	  void *nativemodule;

	  if (CFURLGetFileSystemRepresentation(nativelibURL,
					       true,
					       nativelibpath,
					       sizeof(nativelibpath)-1)) {
	    nativemodule = open_native_module((char *)nativelibpath);

	    if (nativemodule) {
	      (void *)native_application_loader =
		lookup_symbol_in_native_module("_application_loader",
					       nativemodule);
	      (void *)native_lib_initialize =
		lookup_symbol_in_native_module("_lib_initialize",
					       nativemodule);
	      (void *)native_set_nil_and_start =
		lookup_symbol_in_native_module("_set_nil_and_start",
					       nativemodule);
	    }
	  }
	}
      }
    }
  }
}

#endif


OSErr
lib_initialize(CFragInitBlockPtr initblk)
{
#ifdef PMCL_OSX_NATIVE_KERNEL
  OSErr err;
  Str255 errmsg;
  Ptr mainaddr;
  CFragSymbolClass sclass;
#endif
  /* CFragHFSLocatorPtr loc = &(initblk->fragLocator); */
  CFragSystem7LocatorPtr loc = &(initblk->fragLocator);
  CFragLocatorKind where = loc->where;
  short current = CurResFile();
  int (*cache_line_hook)(void) = NULL;
#ifndef CARBON
  CFragConnectionID driver_services_connID;
  THz oldzone = GetZone();
#endif

  check_os_version();

#ifndef PMCL_OSX_NATIVE_KERNEL
  if (is_osx()) {
    find_native_library(initblk);
    if (native_lib_initialize) {
      return native_lib_initialize(initblk);
    }
  }
#else

  /* exception_init(); moved to after thread init stuff */

  /* DebugStr ("\pone"); 
  fprintf (stderr, "\nOne \n");
  fflush (stderr);
  */

  if (cache_line_hook != NULL) {
    cache_block_size = (*cache_line_hook)();
  }

  if (CFragHasFileLocation (where)) {
    FSSpecPtr fss = loc->u.onDisk.fileSpec;

    kernel_refnum = FSpOpenResFile(fss, fsRdPerm);

    if (kernel_refnum == -1) {
      UseResFile(current);
      return (noErr);
    }
  } else {
    return (noErr);
  }


  err = GetSharedLibrary("\pMixedMode",
                         kPowerPCCFragArch,
                         kFindCFrag,
                         &mixedmode_connection,
                         &mainaddr,
                         errmsg);
  if (err == noErr) {
    err = FindSymbol(mixedmode_connection, 
                     "\pEmulated68KContext", 
                     (Ptr *)&emulator_base,
                     &sclass);
    if (err) {
      emulator_base = (LispObj) 0;
    }
  }
  err = GetSharedLibrary("\pInterfaceLib", 
                         kPowerPCCFragArch,
                         kLoadCFrag,
                         &interfacelib_connection,
                         &mainaddr,
                         errmsg);
  if (err == noErr) {
   err = FindSymbol(interfacelib_connection, 
                     "\pNewHandleSys",
                     (Ptr *)&our_NewHandleSys,
                     &sclass);
  
   if (err == noErr) {
     err = FindSymbol(interfacelib_connection, 
                     "\pCallOSTrapUniversalProc",
                     (Ptr *)&our_CallOSTrapUniversalProc,
                     &sclass);
     err = FindSymbol(interfacelib_connection, 
                     "\pCallUniversalProc",
                     (Ptr *)&our_CallUniversalProc,
                     &sclass);
  }
 }
 err = noErr;

#ifdef CARBON
  err = GetSharedLibrary("\pCarbonLib", 
                         kPowerPCCFragArch,
                         kLoadCFrag,
                         &carbonlib_connection,
                         &mainaddr,
                         errmsg);
  if (err == noErr) {
   err = FindSymbol(carbonlib_connection, 
                     "\pHoldMemory",
                     (Ptr *)&our_HoldMemory,
                     &sclass);
  }
  if (err == noErr) {
   err = FindSymbol(carbonlib_connection, 
                     "\pUnholdMemory",
                     (Ptr *)&our_UnholdMemory,
                     &sclass);
  }
 err = noErr;
#endif
  
#ifndef PMCL_OSX_NATIVE_KERNEL
  err = GetSharedLibrary("\psubprims", 
                         kPowerPCCFragArch,
                         kFindCFrag,
                         &subprims_connection,
                         &mainaddr,
                         errmsg);
  if (err) {
    /* Subprims not already loaded; should be a copy in our
       resource fork.  See if we can find our resource fork ... */
    Handle h;
       
      
    h = Get1Resource('SUBP', 0);
    if (h == NULL) {
      UseResFile(current);
      return (-1);
    }
    HLock(h);
    {
      Ptr p = StripAddress(*h);
      Ptr newp = p;
      DetachResource(h);
      subprims_handle = h;
      /* If pre OSX move the stuff to the system heap, else do nothing
       because presumably our address space starts around 0 or so.
       You should be so lucky!
       Subprims need to live in first 32mb of Virtual or some darn memory */
 
    if (is_osx() == false)   

         {
         subprims_handle = (Handle)our_NewHandleSys(GetHandleSize(h));
         HLock(subprims_handle);
         newp = StripAddress(*subprims_handle); 
         BlockMoveData (p, newp, GetHandleSize(h)); 
         DisposeHandle(h);
         h = subprims_handle;
         p = newp;
        }
 
      
      err = GetMemFragment(p, 
                           GetHandleSize(h), 
                           "\psubprims",
                           kLoadCFrag,
                           &subprims_connection,
                           &mainaddr,
                           errmsg);
      if (is_osx())
         { MakeDataExecutable (p, GetHandleSize(h)); /* workaround for OSX PB bug? */
         }
      if (err) {
        UseResFile(current);
        return noErr;
      }
    }
  }
#endif

/* You really don't want to look these up in ThreadsLib; just import them.
   Before OS 7.5 or so, ThreadsLib was a separate INIT; it's been in the system file
   ever since.
*/
#ifndef CARBON
  err = GetSharedLibrary("\pThreadsLib", 
                         kPowerPCCFragArch,
                         kLoadCFrag,
                         &threadslib_connection,
                         &mainaddr,


  /* It is important that NewThread is looked up last here.
     The "lisp-exceptions.c" code assumes that if it is not NULL, then
     all three variables are valid ProcPtr's. */
  if (err == noErr) {
    err = FindSymbol(threadslib_connection, 
                     "\pYieldToThread",
                     (Ptr *)&our_YieldToThread,
                     &sclass);
    if (err == noErr) {
      err = FindSymbol(threadslib_connection, 
                       "\pDisposeThread",
                       (Ptr *)&our_DisposeThread,
                       &sclass);
      if (err == noErr) {
        FindSymbol(threadslib_connection, 
                   "\pNewThread",
                   (Ptr *)&our_NewThread,
                   &sclass);
      }
    }
  }
#endif
 /* DebugStr("\pbefore exception init"); */
 exception_init();

 
  /*
    Since we have the kernel's resource fork open, we should look to see if
    we need to install a 'sane' system exception handler. */

#ifndef CARBON
  if (Gestalt('SSXH', &SSXH_version) != noErr) {
    Handle h = Get1Resource('SSXH', 0);
    UniversalProcPtr p;

    if (h != NULL) {
      HLock(h);
      DetachResource(h);
      p = (UniversalProcPtr) StripAddress(*h);
      CallUniversalProc(p, kCStackBased);

      Gestalt('SSXH', &SSXH_version);
    }
  }
#endif

    
  UseResFile(current);
  CloseResFile(kernel_refnum);
  kernel_refnum = 0;

  /* Ok.  subprims_connection is now a valid connection ID.  Use it to
     find .subprims_base. */

#ifndef PMCL_OSX_NATIVE_KERNEL
  err = FindSymbol(subprims_connection, 
                   "\p.subprims_base", 
                   (Ptr *)&subprims_base,
                   &sclass);
    
  if (err) {
    return noErr;
  }

  err = FindSymbol(subprims_connection, 
                   "\pstart_lisp", 
                   (Ptr *)&start_lisp,
                   &sclass);
    
  if (err) {
    return noErr;
  }


  err = FindSymbol(subprims_connection, 
                   "\p.nvalret", 
                   (Ptr *)&lexpr_return,
                   &sclass);
  
  if (err) {
    return noErr;
  }

  err = FindSymbol(subprims_connection, 
                   "\p.popj", 
                   (Ptr *)&lexpr_return1v,
                   &sclass);
    
  if (err) {
    return noErr;
  }

  err = FindSymbol(subprims_connection, 
                   "\p.ret1valn", 
                   (Ptr *)&ret1valn,
                   &sclass);

#endif 
  return noErr;
#endif
  return 17;
}


void
lib_terminate()
{
#if 0
#ifndef CARBON
  extern VBLTask *cmain_vblQ;
#else
  extern TMTask *cmain_vblQ;
#endif
  extern RoutineDescriptorPtr cmain_descriptor;
  exception_cleanup();
  if (cmain_vblQ != NULL) {
#ifndef CARBON
    VRemove((QElem *)cmain_vblQ);
#else
   RmvTime((QElem *)cmain_vblQ);
#endif
    DisposePtr((Ptr)cmain_vblQ);

   /* could use DisposeTimerUPP here but its not defined in headers we are using today */
   /* also might dispose metering_descriptor */
    DisposePtr((Ptr)cmain_descriptor);
  }
  if (kernel_refnum) {
    CloseResFile(kernel_refnum);
  }
  if (subprims_handle) {
#ifndef CARBON
    THz oldzone = GetZone();
#endif

    /*
      Binding 'theZone' is necessary here, since CloseConnection()
      uses it to determine the CFM context of the connection ID.
    */

#ifndef CARBON
    SetZone(LMGetApplZone());
#endif
    if (CloseConnection(&subprims_connection) == noErr) {
      DisposeHandle(subprims_handle);
    }
#ifndef CARBON
    SetZone(oldzone);
#endif
  }
#endif
}

#ifndef PMCL_OSX_NATIVE_KERNEL
#ifdef __GNUC__
__main()
{
}
#endif

main()
{
  return 17;
}
#endif

#ifdef PMCL_OSX_NATIVE_KERNEL
void *CFM_set_nil_and_start = NULL;
void *CFM_application_loader = NULL;
#endif

void
set_nil_and_start(LispObj r
#ifdef PMCL_OSX_NATIVE_KERNEL
, void *arg0, void *arg1
#endif
)
{
#ifndef PMCL_OSX_NATIVE_KERNEL
  extern void (*native_set_nil_and_start)(LispObj, void*, void*);
  extern void application_loader();
  if (native_set_nil_and_start) {
    /* Pass CFM versions of imported functions to native version */
    native_set_nil_and_start(r,  (void *)set_nil_and_start, (void *)application_loader); 
  } else {
  	return;
  }
#else
  CFM_set_nil_and_start = arg0;
  CFM_application_loader = arg1;

 /* DebugStr ("\pzero"); */ 
  set_nil(r);
  /* DebugStr ("\ptwo"); */
  main();
#endif
}

#ifndef PMCL_OSX_NATIVE_KERNEL
OSErr
application_loader(CFragInitBlockPtr initblk, LispObj r)
{
  if (native_application_loader) {
    return native_application_loader(initblk, r);
  }
  return paramErr;
}
#endif

