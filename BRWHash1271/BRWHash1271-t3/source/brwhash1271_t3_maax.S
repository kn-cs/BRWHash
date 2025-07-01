/* assembly to compute brwhash1271 using t = 3  */

#include "brwhash1271_macro.h"
	
	.p2align 5
	.globl brwhash1271_t3_maax
	 
brwhash1271_t3_maax:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$672,%rsp 

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)
	
	movq 	%rdi,56(%rsp)
	movq 	%rdx,64(%rsp)
	
	movq    %rdx,%rdi
	
	xorq 	%rdx,%rdx
	movq	%rcx,%rax
	movq	$8,%rbx
	divq	%rbx

	movq	%rax,72(%rsp)
	movq	%rdx,80(%rsp)

	popcnt	%rax,%rcx
	movq	%rcx,88(%rsp)

	cmpq	$0,%rax
	je	.L0
	
	leaq	152(%rsp),%rax
	movq	%rax,96(%rsp)

	movq	$1,%rax
	movq	%rax,104(%rsp)
	
.LBRW:
	movq	64(%rsp),%rdi

	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_block3(2,%r8,%r9,%r10,%r11,%rax)
	brw_reduce_4l()
	brw_add_block2(3,2,%r14,%r15)
	brw_mul(%r8,%r9)
	brw_store_temp(120)
	
	brw_add_block1(4,0,%r12,%r13)
	brw_add_block2(5,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%rax)
	movq	zero(%rip),%r12	
	brw_add_temp(120)	
	
	movq	104(%rsp),%rax
	tzcnt	%rax,%rcx
	
	movq	%rcx,112(%rsp)
	cmp	$0,%rcx
	je	.LPUSH

	movq	$0,%rcx	
	movq	96(%rsp),%rdi
	
.LPOP0:
	brw_stack_add_top()
	subq	$32,%rdi
	
	incq	%rcx
	cmpq	112(%rsp),%rcx
	jl	.LPOP0
	
	movq	%rdi,96(%rsp)
	
.LPUSH:	
	brw_reduce_5l()	
	brw_reduce_4l()

	movq	$3,%rdi
	addq	112(%rsp),%rdi
	imul	$16,%rdi,%rdi
	addq	64(%rsp),%rdi
	
	brw_add_block1(7,0,%r14,%r15)
	brw_mul(%r8,%r9)
	
	movq	96(%rsp),%rdi
	addq	$32,%rdi
	movq	%rdi,96(%rsp)
	
	brw_stack_push()

	addq	$120,%rsi

	movq    104(%rsp),%rax
	addq    $1,%rax
	movq    %rax,104(%rsp)	
	cmpq    72(%rsp),%rax
	jle     .LBRW
	
.L0:
	movq	80(%rsp),%rcx
	
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

.LR0:
	brw_init_zero(%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1
.LR1:
	brw_init_msg_block(0,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1

.LR2:
	movq	64(%rsp),%rdi
	
	brw_mul_tau(0,0)
	brw_add_block3(1,%r8,%r9,%r10,%r11,%rax)	
	movq	zero(%rip),%r12
	
	jmp	.L1

.LR3:
	movq	64(%rsp),%rdi
	
	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_block3(2,%r8,%r9,%r10,%r11,%rax)	
	movq	zero(%rip),%r12
	
	jmp	.L1
	
.LR4:
	movq	64(%rsp),%rdi
	
	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_block3(2,%r8,%r9,%r10,%r11,%rax)
	brw_reduce_4l()
	brw_add_block2(3,2,%r14,%r15)
	brw_mul(%r8,%r9)	
	movq	zero(%rip),%r12
	
	jmp	.L1
	
.LR5:
	movq	64(%rsp),%rdi
	
	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_block3(2,%r8,%r9,%r10,%r11,%rax)
	brw_reduce_4l()
	brw_add_block2(3,2,%r14,%r15)
	brw_mul(%r8,%r9)
	brw_add_block3(4,%r8,%r9,%r10,%r11,%rax)
	movq	zero(%rip),%r12	
	adcq	zero(%rip),%r12
	
	jmp	.L1
	
.LR6:
	movq	64(%rsp),%rdi

	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_block3(2,%r8,%r9,%r10,%r11,%rax)
	brw_reduce_4l()
	brw_add_block2(3,2,%r14,%r15)
	brw_mul(%r8,%r9)
	brw_store_temp(120)	
	brw_mul_tau(4,0)
	brw_add_block3(5,%r8,%r9,%r10,%r11,%rax)	
	movq	zero(%rip),%r12
	brw_add_temp(120)
	
	jmp	.L1
	
.LR7:
	movq	64(%rsp),%rdi
	
	brw_add_block1(0,0,%r12,%r13)
	brw_add_block2(1,1,%r14,%r15)
	brw_mul(%r12,%r13)
	brw_add_block3(2,%r8,%r9,%r10,%r11,%rax)
	brw_reduce_4l()
	brw_add_block2(3,2,%r14,%r15)
	brw_mul(%r8,%r9)
	brw_store_temp(120)
	
	brw_add_block1(4,0,%r12,%r13)
	brw_add_block2(5,1,%r14,%r15)
	brw_mul(%r12,%r13)
	movq	zero(%rip),%r12
	brw_add_temp(120)
	brw_add_block3(6,%r8,%r9,%r10,%r11,%rax)
	adcq	zero(%rip),%r12
	
.L1:
	cmpq	$0,88(%rsp)
	je	.LF	

	movq	$0,%rcx
	movq	96(%rsp),%rdi

.LPOP1:
	brw_stack_add_top()
	subq	$32,%rdi
	
	incq	%rcx
	cmpq	88(%rsp),%rcx
	jl	.LPOP1
	
.LF:	
	reduce_5limb()	
	reduce_4limb()
	reduce_2limb()
	
	make_unique()

	andq	mask62(%rip),%r9
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
