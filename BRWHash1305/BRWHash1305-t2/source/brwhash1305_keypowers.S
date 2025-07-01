/* assembly to compute the key powers */

#include "brwhash1305_macro.h"
		
	.p2align 5
	.globl brwhash1305_keypowers
		
brwhash1305_keypowers:

	movq 	%rsp,%r11
	andq    $-32,%rsp
	subq 	$64,%rsp

	movq 	%r11,0(%rsp)
	movq 	%r12,8(%rsp)
	movq 	%r13,16(%rsp)
	movq 	%r14,24(%rsp)
	movq 	%r15,32(%rsp)
	movq 	%rbx,40(%rsp)
	movq 	%rbp,48(%rsp)

	movq    0(%rdi),%r14
	movq    8(%rdi),%r15

	/* tau^2 */
	tau_square()
	addq	$24,%rdi
	movq	%r8,0(%rdi)
	movq	%r9,8(%rdi)
	movq	%r10,16(%rdi)
	
	cmpq	$1,%rsi
	je	.L1

	/* remaining squares */
.L0:
	tau_squaren()
	addq	$24,%rdi
	movq	%r8,0(%rdi)
	movq	%r9,8(%rdi)
	movq	%r10,16(%rdi)
	
	decq	%rsi
	cmpq	$1,%rsi
	jg	.L0

.L1:	
	movq 	0(%rsp),%r11
	movq 	8(%rsp),%r12
	movq 	16(%rsp),%r13
	movq 	24(%rsp),%r14
	movq 	32(%rsp),%r15
	movq 	40(%rsp),%rbx
	movq 	48(%rsp),%rbp

	movq 	%r11,%rsp

	ret
