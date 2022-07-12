.data
	# Denumire teste: in.txt in2.txt in3.txt
	fisierIntrare: .asciz "in3.txt"
	
	ok: .long 0
	optzeci: .long 80
	noua: .long 9
	zero: .long 0
	nrMax: .long 500
	cmdCitire: .asciz "r"
	cmdScriere: .asciz "w"
	fisierIesire: .asciz "out.txt"
	formatLineFeed: .asciz "\n"
	formatSpatiu: .asciz " "
	formatNegativ: .asciz "-1"
	separatori: .asciz " \n"
	s: .space 401
	v: .space 401
	pat: .space 401
	elem: .space 4

.text

.global main

void_afisare:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	movl 8(%ebp), %esi
	xorl %ecx, %ecx
	
	pushl %ecx
	pushl $cmdScriere
	pushl $fisierIesire
	call fopen
	popl %edi
	popl %edi
	popl %ecx
	
et_for_1:
	cmp noua, %ecx
	je continua_for_1
	
	xorl %edx, %edx
et_for_2:
	cmp noua, %edx
	je continua_for_2
	
	pushl %eax
	pushl %edx
	movl %ecx, %eax
	movl noua, %ebx
	xorl %edx, %edx
	mull %ebx
	popl %edx
	addl %edx, %eax
	movl (%esi, %eax, 4), %edi
	popl %eax
	
	movl %edi, elem
	add $48, elem
	
	pushl %edx
	pushl %ecx
	pushl %eax
	pushl %eax
	pushl elem
	call fputc
	popl %edi
	popl %edi
	popl %eax
	popl %ecx
	popl %edx
	
	pushl %edx
	pushl %ecx
	pushl %eax
	pushl %eax
	pushl $formatSpatiu
	call fputs
	popl %edi
	popl %edi
	popl %eax
	popl %ecx
	popl %edx
	
	incl %edx
	jmp et_for_2

continua_for_2:
	pushl %edx
	pushl %ecx
	pushl %eax
	pushl %eax
	pushl $formatLineFeed
	call fputs
	popl %edi
	popl %edi
	popl %eax
	popl %ecx
	popl %edx
	
	incl %ecx
	jmp et_for_1
	
continua_for_1:
	pushl %eax
	call fclose
	popl %edi
	
	popl %esi
	popl %ebp
	ret
	
int_valid:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %ebx
	movl 8(%ebp), %esi
	movl 12(%ebp), %ebx 
	
	movl $1, %ecx
	movl (%esi, %ebx, 4), %edi
	
et_for_linie:
	movl %ebx, %eax
	subl %ecx, %eax
	addl $1, %eax
	xorl %edx, %edx
	pushl %ebx
	movl noua, %ebx
	divl %ebx
	popl %ebx

	cmp zero, %edx
	je continua_for_linie
	
	movl %ebx, %eax
	subl %ecx, %eax
	
	cmp (%esi, %eax, 4), %edi
	je return_valid_0
	
	incl %ecx
	jmp et_for_linie
	
continua_for_linie:
	movl $1, %ecx
	
et_for_coloana:
	movl %ecx, %eax
	pushl %ebx
	movl noua, %ebx
	xorl %edx, %edx
	mull %ebx
	popl %ebx
	
	pushl %edi
	movl %ebx, %edi
	
	subl %eax, %edi
	movl %edi, %eax
	popl %edi
	
	cmp zero, %eax
	jl continua_for_coloana

	subl noua, %eax	
	cmp (%esi, %eax, 4), %edi
	je return_valid_0
	
	incl %ecx
	jmp et_for_coloana

continua_for_coloana:

movl %ebx, %ecx
	
et_while_3:
	pushl %ebx
	movl %ecx, %eax
	xorl %edx, %edx
	movl $3, %ebx
	divl %ebx
	popl %ebx
	
	cmp zero, %edx
	je continua_while_3
	
	subl $1, %ecx
	cmp (%esi, %ecx, 4), %edi
	je return_valid_0
	
	jmp et_while_3
	
continua_while_3:

et_while_1:
	movl $0, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $3, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $6, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $27, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $30, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $33, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $54, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $57, %eax
	cmp %eax, %ecx
	je continua_while_1
	movl $60, %eax
	cmp %eax, %ecx
	je continua_while_1
	
	subl $7, %ecx
	
et_while_2:
	pushl %ebx
	movl %ecx, %eax
	xorl %edx, %edx
	movl $3, %ebx
	divl %ebx
	popl %ebx
	
	cmp zero, %edx
	je continua_while_2
	
	subl $1, %ecx
	cmp (%esi, %ecx, 4), %edi
	je return_valid_0
	
	jmp et_while_2
	
continua_while_2:
	jmp et_while_1	
	
continua_while_1:
	
	movl $1, %eax
	popl %ebx
	popl %esi
	popl %ebp
	ret

return_valid_0:
	movl $0, %eax
	popl %ebx
	popl %esi
	popl %ebp
	ret

void_p:
	pushl %ebp
	movl %esp, %ebp
	
	pushl %esi
	pushl %edi
	pushl %ebx
	movl 8(%ebp), %esi
	movl 12(%ebp), %edi
	movl 16(%ebp), %ebx
	
	movl (%esi, %ebx, 4), %edx
	movl $1, %ecx
et_for_p:
	cmp noua, %ecx
	jg continua_for_p
	movl $1, %eax
	cmp ok, %eax
	je continua_for_p
		
	cmp zero, %edx
	jne atribuire_pattern
	
	movl %ecx, (%edi, %ebx, 4)
	
continua_atribuire_pattern:
	pushl %ebx
	pushl %edx
	pushl %ecx
	pushl %ebx
	pushl %edi
	call int_valid #apelare valid
	popl %edi
	popl %ebx
	popl %ecx
	popl %edx
	popl %ebx
	
	cmp zero, %eax
	jne verifica_afisare
	
	cmp zero, %edx
	jne continua_for_p
	
continua_verifica_afisare:
	incl %ecx
	jmp et_for_p

continua_for_p:
	movl zero, %eax
	popl %ebx
	popl %edi
	popl %esi
	popl %ebp
	ret

atribuire_pattern:
	movl (%esi, %ebx, 4), %eax
	movl %eax, (%edi, %ebx, 4)
	jmp continua_atribuire_pattern
	
verifica_afisare:
	
	cmp optzeci, %ebx
	je apeleaza_afisare
	
	incl %ebx
	
	pushl %edx
	pushl %ecx
	pushl %ebx
	pushl %edi
	pushl %esi
	call void_p #apelare recursiva
	popl %esi
	popl %edi
	popl %eax
	popl %ecx
	popl %edx
	
	subl $1, %ebx
	
continua_apeleaza_afisare:
	jmp continua_verifica_afisare

apeleaza_afisare:
	movl $1, %edx
	movl %edx, ok
	addl $1, %eax
	pushl %ecx
	pushl %edx
	pushl %edi
	call void_afisare
	popl %eax
	popl %edx
	popl %ecx
	jmp continua_apeleaza_afisare

main:
	pushl $cmdCitire
	pushl $fisierIntrare
	call fopen
	popl %ebx
	popl %ebx
	
continua_fopen:
	xorl %edx, %edx
	
et_for_fgets:
	cmp optzeci, %edx
	jg continua_for_fgets
	
	pushl %edx
	pushl %ecx
	pushl %eax
	pushl %eax
	pushl nrMax
	pushl $s
	call fgets
	popl %ebx
	popl %ebx
	popl %ebx
	popl %eax
	popl %ecx
	popl %edx
	
	pushl %eax
	pushl %edx
	
	pushl $separatori
	pushl $s
	call strtok
	popl %ebx
	popl %ebx
	
	xorl %ecx, %ecx
	movl $pat, %esi
	
et_for_citire:
	cmp $0, %eax
	je continua_citire
	
	pushl %ecx
	pushl %eax
	call atoi
	popl %ebx
	popl %ecx
	
	popl %edx
	pushl %eax
	movl %edx, %eax
	pushl %edx
	xorl %edx, %edx
	movl $9, %ebx
	mull %ebx
	popl %edx
	addl %ecx, %eax
	movl %eax, %ebx
	popl %eax
	movl %eax, (%esi, %ebx, 4)
	pushl %edx
	
	pushl %ecx
	pushl $separatori
	pushl $0
	call strtok 
	popl %ebx
	popl %ebx
	popl %ecx
	
	incl %ecx
	jmp et_for_citire
	
continua_citire:
	popl %edx
	popl %eax
	incl %edx
	jmp et_for_fgets
	
continua_for_fgets:	
	pushl %edx
	pushl %eax
	call fclose
	popl %ebx
	popl %edx
	
	pushl zero
	pushl $v
	pushl $pat
	call void_p
	popl %ebx
	popl %ebx
	popl %ebx

verifica_ok:
	movl ok, %eax
	cmp zero, %eax
	je afisare_negativ
	jmp et_exit
	
afisare_negativ:
	pushl $formatNegativ
	call printf
	popl %ebx
	
et_exit:
	movl $1, %eax
	xorl %ebx, %ebx
	int $0x80
