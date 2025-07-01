/* assembly to compute brwhash1305 using t = 4  */

#include "brwhash1305_macro.h"
	
	.p2align 5
	.globl brwhash1305_t4_maax
	 
brwhash1305_t4_maax:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$800,%rsp 

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)
	
	movq 	%rdi,56(%rsp)
	movq 	%rsi,64(%rsp)
	movq 	%rdx,72(%rsp)
	movq 	%rcx,80(%rsp)
	
	movq    %rdx,%rdi
	
	xorq 	%rdx,%rdx
	movq	%rcx,%rax
	movq	$16,%rbx
	divq	%rbx

	movq	%rax,88(%rsp)
	movq	%rdx,96(%rsp)

	popcnt	%rax,%rcx
	movq	%rcx,104(%rsp)

	cmpq	$0,%rax
	je	.L0	
	
	leaq	216(%rsp),%rax
	movq	%rax,112(%rsp)

	movq	$1,%rax
	movq	%rax,120(%rsp)
	
.LBRW:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(8,0,%r8,%r11,%r12)
	brw_add_block2(9,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(10,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(11,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(12,0,%r8,%r11,%r12)
	brw_add_block2(13,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(176)
	brw_add_block3(14,%r8,%r9,%r10,%r11,%r12)	
	brw_add_temp(136)
	
	movq	120(%rsp),%rax
	tzcnt	%rax,%rcx
	
	movq	%rcx,128(%rsp)

	cmp	$0,%rcx
	je	.LPUSH

	movq	$0,%rcx	

	movq	112(%rsp),%rdi
	
.LPOP0:
	brw_stack_add_top()

	subq	$40,%rdi
	
	incq	%rcx
	cmpq	128(%rsp),%rcx
	jl	.LPOP0
	
	movq	%rdi,112(%rsp)
	
.LPUSH:	
	brw_reduce(%r11,%r12,%r9,%r10)

	movq	$4,%rdi
	addq	128(%rsp),%rdi
	imul	$24,%rdi,%rdi
	addq	72(%rsp),%rdi
	
	brw_add_block2(15,0,%r13,%r14,%r15)
	
	brw_mul()	

	movq	112(%rsp),%rdi
	addq	$40,%rdi
	movq	%rdi,112(%rsp)
	
	brw_stack_push()

	addq	$256,%rsi

	movq    120(%rsp),%rax
	addq    $1,%rax
	movq    %rax,120(%rsp)	
	cmpq    88(%rsp),%rax
	jle     .LBRW
	
.L0:
	movq	96(%rsp),%rcx
	
	cmpq	$0,%rcx
	je	.LR0

	cmpq	$1,%rcx
	je	.LR1

	cmpq	$2,%rcx
	je	.LR2
	
	cmpq	$3,%rcx
	je	.LR3
	
	cmpq	$4,%rcx
	je	.LR4
	
	cmpq	$5,%rcx
	je	.LR5
	
	cmpq	$6,%rcx
	je	.LR6
	
	cmpq	$7,%rcx
	je	.LR7
	
	cmpq	$8,%rcx
	je	.LR8

	cmpq	$9,%rcx
	je	.LR9

	cmpq	$10,%rcx
	je	.LR10
	
	cmpq	$11,%rcx
	je	.LR11
	
	cmpq	$12,%rcx
	je	.LR12
	
	cmpq	$13,%rcx
	je	.LR13
	
	cmpq	$14,%rcx
	je	.LR14
	
	cmpq	$15,%rcx
	je	.LR15	

.LR0:
	brw_init_zero(%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1

.LR1:
	brw_init_msg_block(0,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1

.LR2:
	movq	72(%rsp),%rdi

	brw_mul_tau(0,0)
	brw_add_block3(1,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1

.LR3:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1	
	
.LR4:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	
	jmp	.L1	
	
.LR5:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(4,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1	
	
.LR6:
	movq	72(%rsp),%rdi
	
	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	brw_mul_tau(4,0)
	brw_add_block3(5,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)
	
	jmp	.L1
	
.LR7:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1	
	
.LR8:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	
	jmp	.L1
	
.LR9:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(8,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1
	
.LR10:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	brw_mul_tau(8,0)
	brw_add_block3(9,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)
	
	jmp	.L1
	
.LR11:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(8,0,%r8,%r11,%r12)
	brw_add_block2(9,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(10,%r8,%r9,%r10,%r11,%r12)	
	brw_add_temp(136)
	
	jmp	.L1
	
.LR12:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(8,0,%r8,%r11,%r12)
	brw_add_block2(9,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(10,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(11,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)	
	
	jmp	.L1
	
.LR13:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(8,0,%r8,%r11,%r12)
	brw_add_block2(9,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(10,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(11,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(12,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)
	
	jmp	.L1
	
.LR14:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(8,0,%r8,%r11,%r12)
	brw_add_block2(9,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(10,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(11,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)	
	brw_mul_tau(12,0)
	brw_add_block3(13,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)
	brw_add_temp(136)
	
	jmp	.L1
	
.LR15:
	movq	72(%rsp),%rdi

	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(3,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(4,0,%r8,%r11,%r12)
	brw_add_block2(5,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(7,3,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(8,0,%r8,%r11,%r12)
	brw_add_block2(9,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(10,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(11,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(12,0,%r8,%r11,%r12)
	brw_add_block2(13,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(176)
	brw_add_block3(14,%r8,%r9,%r10,%r11,%r12)	
	brw_add_temp(136)
	
.L1:    
	cmpq	$0,104(%rsp)
	je	.LF
	
	movq	$0,%rcx

	movq	112(%rsp),%rdi
	
.LPOP1:
	brw_stack_add_top()

	subq	$40,%rdi
	
	incq	%rcx
	cmpq	104(%rsp),%rcx
	jl	.LPOP1
	
	movq	%rdi,112(%rsp)

.LF:	
	reduce_5limb(%r9,%r10,%r11,%r12)
	reduce_3limb(%r8,%r9,%r10)
	
	make_unique()

	movq 	56(%rsp),%rdi
	movq    %r8,0(%rdi)
	movq    %r9,8(%rdi)

	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
