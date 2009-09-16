# QuickThreads for native kernel
# $Log: OSXqtppc.unix-s,v $
# Revision 1.2  2002/11/18 04:55:40  gtbyers
# Import into CVS; use CVS mod history comments (like this one.)
#

QT_save_backlink = 0
QT_save_crsave = 4
QT_save_savelr = 8
QT_save_unused = 12
QT_save_savetoc = 20
QT_save_params = 24
QT_save_savevrsave = 56
QT_save_savenvrs = 60
QT_save_savefpscr = 136
QT_save_savef14 = 144
QT_save_savef15 = 152
QT_save_savef16 = 160
QT_save_savef17 = 168
QT_save_savef18 = 176
QT_save_savef19 = 184
QT_save_savef20 = 192
QT_save_savef21 = 200
QT_save_savef22 = 208
QT_save_savef23 = 216
QT_save_savef24 = 224
QT_save_savef25 = 232
QT_save_savef26 = 240
QT_save_savef27 = 248
QT_save_savef28 = 256
QT_save_savef29 = 264
QT_save_savef30 = 272
QT_save_savef31 = 280

QT_save_savev20 = 288
QT_save_savev21 = 304
QT_save_savev22 = 320
QT_save_savev23 = 336
QT_save_savev24 = 352
QT_save_savev25 = 368
QT_save_savev26 = 384
QT_save_savev27 = 400
QT_save_savev28 = 416
QT_save_savev29 = 432
QT_save_savev30 = 448
QT_save_savev31 = 464
QT_save_savevscr = 480
QT_save_size = 496
	
	.globl _qt_block
_qt_block:	
	andi. r0,r1,8
	mflr r0
	stw r0,QT_save_savelr(r1)
	bne 1f
	stwu r1,-QT_save_size(r1)
	b 2f
1:	stwu r1,-(QT_save_size+8)(r1)
2:	stmw r13,QT_save_savenvrs(r1)
	bcl 20,31,Lhere
Lhere:	mflr r12
	addis r9,r12,ha16(L_altivec_available$non_lazy_ptr-Lhere)
	lwz r15,lo16(L_altivec_available$non_lazy_ptr-Lhere)(r9)
	lwz r15,0(r15)
	cmpwi r15,0
	mffs f0
	stfd f0,QT_save_savefpscr(r1)
	stfd f14,QT_save_savef14(r1)
	stfd f15,QT_save_savef15(r1)
	stfd f16,QT_save_savef16(r1)
	stfd f17,QT_save_savef17(r1)
	stfd f18,QT_save_savef18(r1)
	stfd f19,QT_save_savef19(r1)
	stfd f20,QT_save_savef20(r1)
	stfd f21,QT_save_savef21(r1)
	stfd f22,QT_save_savef22(r1)
	stfd f23,QT_save_savef23(r1)
	stfd f24,QT_save_savef24(r1)
	stfd f25,QT_save_savef25(r1)
	stfd f26,QT_save_savef26(r1)
	stfd f27,QT_save_savef27(r1)
	stfd f28,QT_save_savef28(r1)
	stfd f29,QT_save_savef29(r1)
	stfd f30,QT_save_savef30(r1)
	stfd f31,QT_save_savef31(r1)
	beq 3f
	li r14,QT_save_savev20
	stvx v20,r1,r14
	li r14,QT_save_savev21
	stvx v21,r1,r14
	li r14,QT_save_savev22
	stvx v22,r1,r14
	li r14,QT_save_savev23
	stvx v23,r1,r14
	li r14,QT_save_savev24
	stvx v24,r1,r14
	li r14,QT_save_savev25
	stvx v25,r1,r14
	li r14,QT_save_savev26
	stvx v26,r1,r14
	li r14,QT_save_savev27
	stvx v27,r1,r14
	li r14,QT_save_savev28
	stvx v28,r1,r14
	li r14,QT_save_savev29
	stvx v29,r1,r14
	li r14,QT_save_savev30
	stvx v30,r1,r14
	li r14,QT_save_savev31
	stvx v31,r1,r14
	mfspr r14,256
	stw r14,QT_save_savevrsave(r1)
	mfvscr v0
	li r14,QT_save_savevscr
	stvx v0,r1,r14
3:
	stw r2,QT_save_savetoc(r1)
	mr r12,r3
	mtctr r12
	mr r3,r1
	mr r1,r6
	bctrl
	cmpwi r15,0
	lfd f0,QT_save_savefpscr(r1)
	mtfsf 0xff,f0
	lfd f14,QT_save_savef14(r1)
	lfd f15,QT_save_savef15(r1)
	lfd f16,QT_save_savef16(r1)
	lfd f17,QT_save_savef17(r1)
	lfd f18,QT_save_savef18(r1)
	lfd f19,QT_save_savef19(r1)
	lfd f20,QT_save_savef20(r1)
	lfd f21,QT_save_savef21(r1)
	lfd f22,QT_save_savef22(r1)
	lfd f23,QT_save_savef23(r1)
	lfd f24,QT_save_savef24(r1)
	lfd f25,QT_save_savef25(r1)
	lfd f26,QT_save_savef26(r1)
	lfd f27,QT_save_savef27(r1)
	lfd f28,QT_save_savef28(r1)
	lfd f29,QT_save_savef29(r1)
	lfd f30,QT_save_savef30(r1)
	lfd f31,QT_save_savef31(r1)
	beq 4f
	li r14,QT_save_savev20
	lvx v20,r1,r14
	li r14,QT_save_savev21
	lvx v21,r1,r14
	li r14,QT_save_savev22
	lvx v22,r1,r14
	li r14,QT_save_savev23
	lvx v23,r1,r14
	li r14,QT_save_savev24
	lvx v24,r1,r14
	li r14,QT_save_savev25
	lvx v25,r1,r14
	li r14,QT_save_savev26
	lvx v26,r1,r14
	li r14,QT_save_savev27
	lvx v27,r1,r14
	li r14,QT_save_savev28
	lvx v28,r1,r14
	li r14,QT_save_savev29
	lvx v29,r1,r14
	li r14,QT_save_savev30
	lvx v30,r1,r14
	li r14,QT_save_savev31
	lvx v31,r1,r14
	li r14,QT_save_savevscr
	lvx v0,r1,r14
	mtvscr v0
	lwz r14,QT_save_savevrsave(r1)
	mtspr 256,r14
4:
	lmw r13,QT_save_savenvrs(r1)
	lwz r1,QT_save_backlink(r1)
	lwz r0,QT_save_savelr(r1)
	mtlr r0
	blr

	
	.globl _qt_start
	.globl _qt_error
_qt_start:	
	mtctr r17
	mr r12,r17
	mr r3,r14
	mr r4,r15
	mr r5,r16
	bctrl
	b _qt_error

	
	.globl _invoke_user_function
_invoke_user_function:	
	mtctr r4
	mr r12,r4
	bctr


	.comm _altivec_available,4
	.non_lazy_symbol_pointer
L_altivec_available$non_lazy_ptr:
	.indirect_symbol _altivec_available
	.long 0
	


	
