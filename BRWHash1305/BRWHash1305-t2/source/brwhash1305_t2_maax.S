/* assembly to compute brwhash1305 using t = 2  */

#include "brwhash1305_macro.h"
	
	.p2align 5
	.globl brwhash1305_t2_maax
	 
brwhash1305_t2_maax:

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
	
	/* h */
	movq 	%rdi,56(%rsp)
	/* k */
	movq 	%rdx,64(%rsp)
	
	/* manage k using %rdi */
	movq    %rdx,%rdi
	
	xorq 	%rdx,%rdx
	/* store l in %rax */
	movq	%rcx,%rax
	/* divide l by t^2 for t = 2*/
	movq	$4,%rbx
	divq	%rbx

	/* store l/4 and l%4 */	
	movq	%rax,72(%rsp)
	movq	%rdx,80(%rsp)

	/* hamming weight of l/4 */
	popcnt	%rax,%rcx
	movq	%rcx,88(%rsp)

	/* skip BRW loop if l/4 equals to 0 */
	cmpq	$0,%rax
	je	.L0
	
	/* initialize and store stack top address */
	leaq	120(%rsp),%rax
	movq	%rax,96(%rsp)

	/* initialize counter for .LBRW loop */
	movq	$1,%rax
	movq	%rax,104(%rsp)
	
.LBRW:
	/* manage keypowers array using %rdi */
	movq	64(%rsp),%rdi

	/* compute unreduced BRW over three message blocks */
	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)
	
	/* number of trailing zeroes in %rax */
	movq	104(%rsp),%rax
	tzcnt	%rax,%rcx
	
	movq	%rcx,112(%rsp)

	/* skip stack pop if number of trailing zeroes is 0 */ 
	cmp	$0,%rcx
	je	.LPUSH

	/* initialize counter for .LPOP0 loop */
	movq	$0,%rcx	

	/* access stack top address before entering to the pop operations */
	movq	96(%rsp),%rdi
	
.LPOP0:
	/* add stack top to the running unreduced field element */
	brw_stack_add_top()
	/* update stack top */
	subq	$40,%rdi
	
	incq	%rcx
	cmpq	112(%rsp),%rcx
	jl	.LPOP0
	
	/* store stack top address after all the pop operations */
	movq	%rdi,96(%rsp)
	
.LPUSH:	
	/* reduce */
	brw_reduce(%r11,%r12,%r9,%r10)

	/* access keypowers[t+k], first get the offset */
	movq	$2,%rdi
	addq	112(%rsp),%rdi
	imul	$24,%rdi,%rdi
	/* then add the offset to the base address of keypowers array */
	addq	64(%rsp),%rdi
	
	/* add the appropriate key power to the fourth message block */
	brw_add_block1(3,0,%r13,%r14,%r15)
	
	/* compute unreduced field multiplication */
	brw_mul()	

	/* update and store the stack top address */
	movq	96(%rsp),%rdi
	addq	$40,%rdi
	movq	%rdi,96(%rsp)
	
	/* push the unreduced field element to the stack */
	brw_stack_push()

	/* update message block address */
	addq	$64,%rsi

	movq    104(%rsp),%rax
	addq    $1,%rax
	movq    %rax,104(%rsp)	
	cmpq    72(%rsp),%rax
	jle     .LBRW
	
.L0:
	/* remainder number of blocks */
	movq	80(%rsp),%rcx
	
	/* number of remainder blocks is 0 */
	cmpq	$0,%rcx
	je	.LR0

	/* number of remainder blocks is 1 */
	cmpq	$1,%rcx
	je	.LR1

	/* number of remainder blocks is 2 */
	cmpq	$2,%rcx
	je	.LR2
	
	/* number of remainder blocks is 3 */
	cmpq	$3,%rcx
	je	.LR3

.LR0:
	/* initialize to 0*/
	brw_init_zero(%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1
.LR1:
	/* initialize to the current message block */
	brw_init_msg_block(0,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1

.LR2:
	movq	64(%rsp),%rdi

	/* multiply first message block with tau */
	brw_mul_tau(0,0)

	/* add the second message block to the result */
	brw_add_block3(1,%r8,%r9,%r10,%r11,%r12)
	
	jmp	.L1

.LR3:
	movq	64(%rsp),%rdi

	/* compute unreduced BRW over three message blocks */
	brw_add_block1(0,0,%r8,%r11,%r12)
	brw_add_block2(1,1,%r13,%r14,%r15)
	brw_mul()
	brw_add_block3(2,%r8,%r9,%r10,%r11,%r12)
	
.L1:
	/* skip stack pop operations if hamming weight is 0 */
	cmpq	$0,88(%rsp)
	je	.LF
	
	/* initialize counter for .LPOP1 loop */
	movq	$0,%rcx

	/* access stack top address before entering to the POP opeartions */
	movq	96(%rsp),%rdi
	
.LPOP1:
	/* add stack top to the running unreduced field element */
	brw_stack_add_top()

	/* update stack top address */
	subq	$40,%rdi
	
	incq	%rcx
	cmpq	88(%rsp),%rcx
	jl	.LPOP1
	
	/* update stack top address after all the pop operations */
	movq	%rdi,96(%rsp)

.LF:	
	/* final reduction */
	reduce_5limb(%r9,%r10,%r11,%r12)
	reduce_3limb(%r8,%r9,%r10)
	
	/* get unique representation */
	make_unique()

	/* store the final value */	
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
