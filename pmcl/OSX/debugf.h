/*
    File: debugf.h
    
    Description:
        debugf is like printf.  Routines implemented herein provide a subset
	of the standard C library's sprintf functionality.  The differences
	with this implementation include:
	
	it's small (around 2k once compiled)
	
	it doesn't call any toolbox or os routines.  it's entirely self contained
	and does not call any toolbox routines or stdclib routines.  The only call
	made outside of this library is the DebugStr call inside of the debugf
	routine.

	it's safe to call at interrupt time (assuming there's the stack
	space to do it).
	
	debugf can be called anywhere it is safe to call DebugStr.

    Copyright:
        © Copyright 2000 Apple Computer, Inc. All rights reserved.
    
    Disclaimer:
        IMPORTANT:  This Apple software is supplied to you by Apple Computer, Inc.
        ("Apple") in consideration of your agreement to the following terms, and your
        use, installation, modification or redistribution of this Apple software
        constitutes acceptance of these terms.  If you do not agree with these terms,
        please do not use, install, modify or redistribute this Apple software.

        In consideration of your agreement to abide by the following terms, and subject
        to these terms, Apple grants you a personal, non-exclusive license, under Apple’s
        copyrights in this original Apple software (the "Apple Software"), to use,
        reproduce, modify and redistribute the Apple Software, with or without
        modifications, in source and/or binary forms; provided that if you redistribute
        the Apple Software in its entirety and without modifications, you must retain
        this notice and the following text and disclaimers in all such redistributions of
        the Apple Software.  Neither the name, trademarks, service marks or logos of
        Apple Computer, Inc. may be used to endorse or promote products derived from the
        Apple Software without specific prior written permission from Apple.  Except as
        expressly stated in this notice, no other rights or licenses, express or implied,
        are granted by Apple herein, including but not limited to any patent rights that
        may be infringed by your derivative works or by other works in which the Apple
        Software may be incorporated.

        The Apple Software is provided by Apple on an "AS IS" basis.  APPLE MAKES NO
        WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED
        WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR
        PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND OPERATION ALONE OR IN
        COMBINATION WITH YOUR PRODUCTS.

        IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL OR
        CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
        GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
        ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION
        OF THE APPLE SOFTWARE, HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT
        (INCLUDING NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN
        ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

    Change History (most recent first):
        Wed, Feb 16, 2000 -- created
*/

#ifndef __DEBUGF__
#define __DEBUGF__

#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <Types.h>
#include <StdArg.h>
#endif

/* vsoutputf is like vsprintf except:
	- it only understands a different set of format specifies:
	format:  %[.N]F
	.N is an optional argument specifying the width of the printed field.
	F is the format specifier.  it can be one of the following:
		s - argument is a c style string,
		p - argument is a pascal style string
		c - argument is a single character
		b - print argument as a binary number
		n - print argument as a base 4 number
		o - print argument as an octal number
		d - print argument as a signed decimal number
		u - print argument as an unsigned decimal number
		x - print argument as a hexidecimal number.
	example:
		debugf("%s bug is %x %.4d %p.", "That", 57005, 10, "\ptimes over");
	calls up macsbug and prints:
		That bug is DEAD 0010 times over.
	*/

#ifdef __cplusplus
extern "C" {
#endif

/* vsoutputf outputs args using format to the string s.  it returns
	the length of the string data stored in s.  This routine
	does not add a trailing zero byte to the end of the output
	string.  */
int vsoutputf(char *s, const char *fmt, va_list arg);

/* soutputf is like sprintf, except it is safe to call it at
	interrupt time. it outputs fmt using the ... arguments
	to the string s and adds a trailing zero to the end
	of the generated string. it returns the length of the
	string (including the trailing zero byte). */
int soutputf(char *s, const char *fmt, ...);

/* PLoutputf is like soutputf, except it outputs the string
	to a pascal style string p and returns a pointer to
	that string. */
StringPtr PLoutputf(StringPtr p, const char *fmt, ...);

/* debugf outputs the fmt and ... parameters to a pascal string
	and passes that string to DebugStr(). */
void debugf(char const *fmt, ...);

#ifdef __cplusplus
}
#endif

#endif
