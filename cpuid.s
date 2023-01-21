	.file	"cpuid.c"
	.text
	.globl	cpuid
	.def	cpuid;	.scl	2;	.type	32;	.endef
	.seh_proc	cpuid
cpuid:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movl	(%rax), %eax
	movq	16(%rbp), %rdx
	movl	8(%rdx), %edx
/APP
 # 13 "cpuid.c" 1
	movl %eax, %eax	
movl %edx, %ecx	
cpuid	
movl %eax, %r9d	
movl %ebx, %r8d	
movl %ecx, %ecx	
movl %edx, %edx	

 # 0 "" 2
/NO_APP
	movq	16(%rbp), %rax
	movl	%r9d, (%rax)
	movq	16(%rbp), %rax
	movl	%r8d, 4(%rax)
	movq	16(%rbp), %rax
	movl	%ecx, 8(%rax)
	movq	16(%rbp), %rax
	movl	%edx, 12(%rax)
	nop
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (Rev9, Built by MSYS2 project) 12.2.0"
