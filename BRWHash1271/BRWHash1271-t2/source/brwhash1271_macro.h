#ifndef __BRWHASH1271ASM__
#define __BRWHASH1271ASM__

/* macros used in the main assembly */

#define brw_add_block1(x,y,a,b)		\
						\
	movq    15*x+0(%rsi),a;    		\
	movq    15*x+8(%rsi),b;   		\
	andq	mask56(%rip),b;		\
						\
	addq    16*y+0(%rdi),a;    		\
	adcq    16*y+8(%rdi),b;    		\

#define brw_add_block2 brw_add_block1		\

#define brw_add_block3(x,a,b,c,d,e)		\
						\
	movq    15*x+8(%rsi),e;		\
	andq	mask56(%rip),e;		\
	addq    15*x+0(%rsi),a;		\
	adcq    e,b;				\
	adcq    zero(%rip),c;			\
	adcq    zero(%rip),d;			\
	
#define brw_init_zero(a,b,c,d,e)		\
						\
	movq    zero(%rip),a;			\
	movq    zero(%rip),b;			\
	movq    zero(%rip),c;			\
	movq    zero(%rip),d;			\
	movq    zero(%rip),e;			\
	
#define brw_init_msg_block(x,a,b,c,d,e)	\
						\
	movq    15*x+0(%rsi),a;		\
	movq    15*x+8(%rsi),b;		\
	andq	mask56(%rip),b;		\
	movq    zero(%rip),c;			\
	movq    zero(%rip),d;			\
	movq    zero(%rip),e;			\
	
#define brw_mul(a,b)				\
						\
	xorq    %rdx,%rdx;			\
	movq    a,%rdx;   			\
						\
	mulx    %r14,%r8,%rbp;  		\
	mulx    %r15,%rbx,%r10;		\
	adcx    %rbx,%rbp;			\
	adcx    zero(%rip),%r10;    		\
						\
	xorq    %r11,%r11;			\
	movq    b,%rdx;			\
	   					\
	mulx    %r14,%r9,%r12;			\
	adcx    %rbp,%r9;			\
	adox    %r12,%r10;			\
	    					\
	mulx    %r15,%rbx,%r12;		\
	adcx    %rbx,%r10;			\
	adox    %r12,%r11;			\
	adcx    zero(%rip),%r11;		\

#define brw_mul_tau(m,t)			\
						\
	xorq    %rdx,%rdx;			\
	movq    15*m+0(%rsi),%rdx;   		\
						\
	mulx    t+0(%rdi),%r8,%r9;   		\
	mulx    t+8(%rdi),%rbx,%r10;		\
	adcx    %rbx,%r9;			\
	adcx    zero(%rip),%r10;    		\
						\
	xorq    %r11,%r11;			\
	movq    15*m+8(%rsi),%rdx;		\
	andq	mask56(%rip),%rdx;		\
	   					\
	mulx    t+0(%rdi),%rbx,%rbp;		\
	adcx    %rbx,%r9;			\
	adox    %rbp,%r10;			\
	    					\
	mulx    t+8(%rdi),%rbx,%rbp;		\
	adcx    %rbx,%r10;			\
	adox    %rbp,%r11;			\
	adcx    zero(%rip),%r11;		\
	
#define brw_reduce_5l reduce_5limb		\

#define brw_reduce_4l reduce_4limb		\

#define brw_stack_push()			\
						\
	movq    %r8,0(%rdi);			\
	movq    %r9,8(%rdi);			\
	movq    %r10,16(%rdi);			\
	movq    %r11,24(%rdi);			\
	
#define brw_stack_add_top()			\
						\
	addq    0(%rdi),%r8;			\
	adcq    8(%rdi),%r9;			\
	adcq    16(%rdi),%r10;			\
	adcq    24(%rdi),%r11;			\
	adcq    zero(%rip),%r12;		\
	
#define reduce_5limb()				\
						\
	shld    $2,%r11,%r12;			\
						\
	andq	mask62(%rip),%r11;		\
	xorq    %rdx,%rdx;			\
	adcx    %r12,%r8;			\
	adcx    %rdx,%r9;			\
	adcx    %rdx,%r10;			\
	adcx    %rdx,%r11;			\
	
#define reduce_4limb()				\
						\
	shld    $1,%r10,%r11;			\
	shld    $1,%r9,%r10;			\
						\
	andq	mask63(%rip),%r9;		\
	xorq    %rdx,%rdx;			\
	adcx    %r10,%r8;			\
	adcx    %r11,%r9;			\

#define reduce_2limb()				\
						\
	movq    %r9,%r10;			\
	shrq    $63,%r10;			\
	andq	mask63(%rip),%r9;		\
	addq    %r10,%r8;			\
	adcq    zero(%rip),%r9;		\

#define make_unique()				\
						\
	movq    %r8,%r11;			\
	movq    %r9,%r12;			\
						\
	subq    p0(%rip),%r8;			\
	sbbq    p1(%rip),%r9;			\
						\
	movq    %r9,%r10;			\
	shlq    $1,%r10;			\
						\
	cmovc   %r11,%r8;			\
	cmovc   %r12,%r9;			\

/* macro used for computing the key powers */

#define tau_squaren()				\
						\
	movq    %rcx,%rdx;			\
	addq    %rdx,%rdx;			\
	mulx    %rax,%r9,%r10;			\
						\
	movq    %rax,%rdx;  			\
	mulx    %rdx,%rax,%rdx;		\
	addq    %rdx,%r9;			\
						\
	movq    %rcx,%rdx;			\
	mulx    %rdx,%rcx,%r11;		\
	adcq    %rcx,%r10;			\
	adcq    $0,%r11;			\
						\
	shld    $1,%r10,%r11;			\
	shld    $1,%r9,%r10;			\
						\
	andq	mask63(%rip),%r9;		\
	xorq	%rdx,%rdx;			\
	adcx    %r10,%rax;			\
	adcx    %r11,%r9;			\
						\
	movq    %r9,%rcx;			\
	andq	mask63(%rip),%rcx;		\
	shrq    $63,%r9;			\
	addq    %r9,%rax;			\
	adcq    $0,%rcx;			\
		
#endif
