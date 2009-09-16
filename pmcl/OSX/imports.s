# import CFM versions of C functions lisp needs during startup
# $Log: OSXimports.unix-s,v $
# Revision 1.5  2006/02/03 20:01:54  alice
# add some for bootstrapping macho
#
# Revision 1.4  2005/06/25 23:37:20  alice
# *** empty log message ***
#
# Revision 1.3  2003/02/12 21:40:38  gtbyers
# Thread locking/unlocking.
#
# Revision 1.2  2002/11/18 04:55:36  gtbyers
# Import into CVS; use CVS mod history comments (like this one.)
#
	

define(`defimport',`
	.globl _$1
	.static_data
$1:	.long _$1,0
	.data
	.long $1
')

	.data
import_ptrs_start:
	defimport(read)
	defimport(write)
	defimport(open)
	defimport(close)
	defimport(ioctl)
	defimport(mclMakeDataExecutable)
	defimport(GetSharedLibrary)
	defimport(FindSymbol)
	defimport(CountSymbols)
	defimport(GetIndSymbol)
	defimport(allocate_tstack)
	defimport(allocate_vstack)
	defimport(register_cstack)
	defimport(condemn_area_chain)
	defimport(metering_control)
	defimport(excise_library)
	defimport(lisp_egc_control)
	defimport(lisp_bug)
	defimport(xNewThread)
	defimport(xYieldToThread)
	defimport(xThreadCurrentStackSpace)
	defimport(xDisposeThread)
	defimport(lock_binding_stack)
	defimport(unlock_binding_stack)
        defimport(remove_tmtask)
        defimport(restore_tmtask)
        defimport(start_vbl)
        defimport(__CFStringMakeConstantString)
        defimport(CFBundleGetFunctionPointerForName)
        defimport(FSFindFolder)
        defimport(CFURLCreateFromFSRef)
        defimport(CFURLCreateCopyAppendingPathComponent)
        defimport(CFBundleCreate)
        defimport(CFBundleLoadExecutable)
        defimport(CFStringCreateWithCString)
        defimport(CFRelease)
        defimport(CFBundleGetBundleWithIdentifier)
        defimport(PBHOpenSync)
        defimport(PBGetEOFSync)
        defimport(PBCloseSync)
        defimport(PBReadSync)
        defimport(PBSetFPosSync)
        

.globl _import_ptrs_base
_import_ptrs_base: .long import_ptrs_start

