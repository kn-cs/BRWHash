/* assembly to compute brwhash1305 using t = 5  */

#include "brwhash1305_macro.h"
	
	.p2align 5
	.globl brwhash1305_t5_maax
	 
brwhash1305_t5_maax:

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
	movq	$32,%rbx
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)
	
	brw_add_block1(24,0,%r8,%r11,%r12)
	brw_add_block2(25,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(26,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(27,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)	
	
	brw_add_block1(28,0,%r8,%r11,%r12)
	brw_add_block2(29,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(30,%r8,%r9,%r10,%r11,%r12)
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

	movq	$5,%rdi
	addq	128(%rsp),%rdi
	imul	$24,%rdi,%rdi
	addq	72(%rsp),%rdi
	
	brw_add_block2(31,0,%r13,%r14,%r15)
	
	brw_mul()	

	movq	112(%rsp),%rdi
	addq	$40,%rdi
	movq	%rdi,112(%rsp)
	
	brw_stack_push()

	addq	$512,%rsi

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
	
	cmpq	$16,%rcx
	je	.LR16

	cmpq	$17,%rcx
	je	.LR17

	cmpq	$18,%rcx
	je	.LR18
	
	cmpq	$19,%rcx
	je	.LR19
	
	cmpq	$20,%rcx
	je	.LR20
	
	cmpq	$21,%rcx
	je	.LR21
	
	cmpq	$22,%rcx
	je	.LR22
	
	cmpq	$23,%rcx
	je	.LR23
	
	cmpq	$24,%rcx
	je	.LR24

	cmpq	$25,%rcx
	je	.LR25

	cmpq	$26,%rcx
	je	.LR26
	
	cmpq	$27,%rcx
	je	.LR27
	
	cmpq	$28,%rcx
	je	.LR28
	
	cmpq	$29,%rcx
	je	.LR29
	
	cmpq	$30,%rcx
	je	.LR30
	
	cmpq	$31,%rcx
	je	.LR31		

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
	
	jmp	.L1
	
.LR16:
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
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()	
	
	jmp	.L1
	
.LR17:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(16,%r8,%r9,%r10,%r11,%r12)	
	
	jmp	.L1
	
.LR18:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	brw_mul_tau(16,0)
	brw_add_block3(17,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)
	
	jmp	.L1
	
.LR19:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)	
	brw_add_temp(136)
	
	jmp	.L1
	
.LR20:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)	
	
	jmp	.L1
	
.LR21:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(20,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)	
	
	jmp	.L1
	
.LR22:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	brw_mul_tau(20,0)
	brw_add_block3(21,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)
	brw_add_temp(136)	
	
	jmp	.L1
	
.LR23:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)
	brw_add_temp(136)	
	
	jmp	.L1
	
.LR24:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	
	jmp	.L1
	
.LR25:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)	
	brw_add_block3(24,%r8,%r9,%r10,%r11,%r12)	
	
	jmp	.L1
	
.LR26:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)
	brw_mul_tau(24,0)
	brw_add_block3(25,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)	
	
	jmp	.L1
	
.LR27:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)
	
	brw_add_block1(24,0,%r8,%r11,%r12)
	brw_add_block2(25,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(26,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)
	
	jmp	.L1
	
.LR28:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)
	
	brw_add_block1(24,0,%r8,%r11,%r12)
	brw_add_block2(25,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(26,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(27,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	
	jmp	.L1
	
.LR29:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)
	
	brw_add_block1(24,0,%r8,%r11,%r12)
	brw_add_block2(25,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(26,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(27,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(28,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(136)	
	
	jmp	.L1
	
.LR30:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)	
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)
	
	brw_add_block1(24,0,%r8,%r11,%r12)
	brw_add_block2(25,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(26,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(27,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	brw_mul_tau(28,0)
	brw_add_block3(29,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_add_temp(136)
	
	jmp	.L1
	
.LR31:
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
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(15,4,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(136)
	
	brw_add_block1(16,0,%r8,%r11,%r12)
	brw_add_block2(17,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(18,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)	
	brw_add_block2(19,2,%r13,%r14,%r15)
	brw_mul()
	brw_store_temp(176)
	
	brw_add_block1(20,0,%r8,%r11,%r12)
	brw_add_block2(21,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(22,%r8,%r9,%r10,%r11,%r12)
	brw_add_temp(176)	
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(23,3,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)
	
	brw_add_block1(24,0,%r8,%r11,%r12)
	brw_add_block2(25,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(26,%r8,%r9,%r10,%r11,%r12)
	brw_reduce(%r11,%r12,%r9,%r10)
	brw_add_block2(27,2,%r13,%r14,%r15)
	brw_mul()
	brw_add_temp(136)
	brw_store_temp(136)	
	
	brw_add_block1(28,0,%r8,%r11,%r12)
	brw_add_block2(29,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(30,%r8,%r9,%r10,%r11,%r12)
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
