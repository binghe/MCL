# Makefile for OSX-native pmcl kernel
# % make -f Makefile.unix
# $Log: Makefile.unix,v $
# Revision 1.7  2003/12/08 04:09:44  gtbyers
# Don't do weak linking.  Add "install" make target, commit to main branch.
#
# Revision 1.5.2.1  2003/12/03 20:34:11  gtbyers
# Don't do weak linking.
#
# Revision 1.5  2003/11/10 17:31:50  gtbyers
# Support compiling with gcc3.3, whose preprocessor is broken in the opposite way from previous OSX versions.  Set the OSX_KERNEL_VERSION to 0x501.  Link in the dcmd/debugging support, and assert that we're on 10.2 or later and can therefore use weak shared libraries and frameworks.
#
# Revision 1.4  2003/01/13 20:13:31  gtbyers
# Define OSX_KERNEL_VERSION=0x0500; pass it as value of #defined PMCL_OSX_NATIVE_KERNEL.
#
# Revision 1.3  2002/11/25 06:05:58  gtbyers
# Add $c_debug to $cflags.  (What a concept.)
#
# Revision 1.2  2002/11/18 04:55:32  gtbyers
# Import into CVS; use CVS mod history comments (like this one.)
#


kernel_current_version = 	"0x04009000"
kernel_implementation_version =	"0x04009000"
# backward-compatible to:
kernel_definition_version = 	"0x04009000"

OSX_KERNEL_VERSION="0x0502"
kernel_cfrg_name = "pmcl-kernel4.4"

SPOBJ = spjump.o sp_call.o subprims.o 
# ASMOBJ = asmutils.o imports.o

SPINC =	lisp.s m4macros.m4 constants.s macros.s errors.s uuo.s

KSPOBJ= $(SPOBJ)


COBJECTS = pmcl-kernel.o gc.o bits.o kernel-init.o lisp-exceptions.o mathtrap.o loader.o pef.o \
 debugf.o qt.o lisp-debug.o plbt.o plprint.o ppcprint.o lispdcmd.o plsym.o

KERNELOBJECTS = imports.o $(COBJECTS) $(KSPOBJ) asmutils.o qtppc.o

AS = as
M4 = gm4
M4FLAGS = -DDARWIN
ASFLAGS = -force_cpusubtype_ALL -arch ppc
c_defines = -DDARWIN -DCARBON -DTARGET_API_MAC_CARBON=1 -DPMCL_OSX_NATIVE_KERNEL=$(OSX_KERNEL_VERSION)

c_options = -fpascal-strings -arch ppc -mmacosx-version-min=10.4
c_debug = -g

CHEADERS = area.h bits.h constants.h lisp-errors.h gc.h lisp.h lisp-exceptions.h \
	lisp_globals.h macros.h memprotect.h loader.h


kernel_entrypoints = -init lib_initialize -term lib_terminate -main __appstart

CIncludes = -I./

cflags =   $(CIncludes) $(c_symopt) $(c_optimize) $(c_defines) $(c_options) $(c_debug) -Wno-deprecated-declarations -Wno-format

NATIVE_KERNEL = pmcl-OSX-kernel
all:	$(NATIVE_KERNEL)

$(NATIVE_KERNEL): $(KERNELOBJECTS)
	MACOSX_DEPLOYMENT_TARGET=10.2 $(CC) -bundle -g -framework Carbon -arch ppc -mmacosx-version-min=10.4 -o $@ $(KERNELOBJECTS) 

clean:
	 rm -f $(KERNELOBJECTS)  $(NATIVE_KERNEL)

# just clean up .c objects.  Clean up the kernel symbol files as well,
# since one of them may have been created by another compiler/linker pair.
cleanc:
	rm -f $(COBJECTS) console.o

cclean: cleanc

install: $(NATIVE_KERNEL)
	cp -p $(NATIVE_KERNEL) ../..

.s.o:
	$(M4) $(M4FLAGS)  $< | $(AS) $(ASFLAGS) -o $@

%.o: %.c
	$(CC) -c $(cflags) $<  -o $@


$(SPOBJ): $(SPINC)
$(COBJECTS): $(CHEADERS)

pef.o: pef.h pef.c $(CHEADERS)
	$(CC) -c $(cflags) -DKERNEL_CURRENT_VERSION=$(kernel_current_version) \
	-DKERNEL_IMPLEMENTATION_VERSION=$(kernel_implementation_version) \
	-DKERNEL_CFRG_NAME="\"$(kernel_cfrg_name)\"" \
	pef.c  -o pef.o

kernel-init.o: ../kernel-init.c
	$(CC) -c $(cflags) $<  -o $@
