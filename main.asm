.extern le_teclado, 0
.globl main
main:
 
 #menu
 li $v0,4
 la $a0,texto9
 syscall
 #tocar em tempo real
 li $v0,4
 la $a0,texto6
 syscall
 #rocar de uma string
 li $v0,4
 la $a0,texto7
 syscall
 #op��o
 li $v0,4
 la $a0,texto8
 syscall
 li $v0,5
 syscall
 move $s5,$v0
	li 		$v0, 4		 	# $v0 := 4 (n�mero do servi�o que ser� solicitado)
		la		$a0, texto2		# $a0 := endere�o representado pelo r�tulo texto (endere�o da string a ser impressa na tela)
		syscall					# Faz chama ao sistema solicitando servi�o 4: imprime string na tela
			
		li		$v0,5
		syscall	
		move 		$a2,$v0 # $a2 fica com o instrumento
		
	
		li 		$v0, 4		 	# $v0 := 4 (n�mero do servi�o que ser� solicitado)
		la		$a0, texto3		# $a0 := endere�o representado pelo r�tulo texto (endere�o da string a ser impressa na tela)
		syscall					# Faz chama ao sistema solicitando servi�o 4: imprime string na tela
		move $a0,$zero	
		li		$v0,5
		syscall	
		move 		$a3,$v0 # $a3 fica com o volume
		

		li 		$v0, 4		 	# $v0 := 4 (n�mero do servi�o que ser� solicitado)
		la		$a0, texto4		# $a0 := endere�o representado pelo r�tulo texto (endere�o da string a ser impressa na tela)
		syscall					# Faz chama ao sistema solicitando servi�o 4: imprime string na tela
				move $a0,$zero
		li		$v0,5
		syscall	
		move 		$s2,$v0 # $a3 fica com a dura��o das notas em milessegundos
		move $a0,$zero

		li 		$v0, 4		 	# $v0 := 4 (n�mero do servi�o que ser� solicitado)
		la		$a0, texto5		# $a0 := endere�o representado pelo r�tulo texto (endere�o da string a ser impressa na tela)
		syscall					# Faz chama ao sistema solicitando servi�o 4: imprime string na tela
			
		li		$v0,5
		syscall	
		move 		$s1,$v0 # $a3 fica com o intervalo de tempo entre cada nota 
 beq $s5,2, toca_musica
 beq $s5,1,toca_musica_real
#jal toca_musica
jal fim



 

 
#fim le_teclado*********************************************************************************************************************************

#toca_musica_tempo_real:


#toca_musica***********************************************************************************************************************************
		toca_musica:
		li 		$v0, 4		 	# $v0 := 4 (n�mero do servi�o que ser� solicitado)
		la		$a0, texto		# $a0 := endere�o representado pelo r�tulo texto (endere�o da string a ser impressa na tela)
		syscall					# Faz chama ao sistema solicitando servi�o 4: imprime string na tela
		li 		$v0, 8			# $v0 := 8 (n�mero do servi�o que ser� solicitado)
		la		$a0, notas		# $a0 := endere�o representado pelo r�tulo notas (endere�o da string a ser lida do teclado)
		li		$a1, 100
		syscall	
		move $t0,$zero
		
		loop:
		lb $a0,notas($t0)
		beq $a0,$zero,fim
		li $v0,31
		move $a1,$s2
		syscall
		li 	$v0, 32			# $v0 := 32 (n�mero do servi�o que ser� solicitado)
		move	$a0, $s1			# $a0 := dura��o da espera (500 milisegundos)
		syscall
		addi $t0,$t0,1					# Faz chama ao sistema solicitando servi�o 32: espera
		j loop
		
		toca_musica_real:
		li 		$v0, 4		 	# $v0 := 4 (n�mero do servi�o que ser� solicitado)
		la		$a0, texto		# $a0 := endere�o representado pelo r�tulo texto (endere�o da string a ser impressa na tela)
		syscall
		move $a1,$s2
		loop1:
		li $v0,12
		syscall
		move $a0,$v0
		beq $a0,48,fim
		li   $v0,31
		syscall
		li $v0,32
		move $a0,$s1
		syscall
		j loop1
		
		
		
		
#fim********************************************************************************************************************************************
fim:
		li 		$v0, 10			# $v0 := 10 (n�mero do servi�o que ser� solicitado)
		syscall					# Faz chama ao sistema solicitando servi�o 10: exit (encerra execu��o do programa)
			
		

			# Faz chama ao sistema solicitando servi�o 8: l� string do teclado

	.data
texto: .asciiz	"entre com as notas : \n"

texto2: .asciiz "entre com os instrumento um numero de 0-127\n"

texto3: .asciiz "entre com o volume que quer tocar um numero de 1-127\n" 

texto4: .asciiz "entre com a dura��o de cada nota em milesegundos \n"

texto5: .asciiz "entre com o tempo entre as notas \n"

texto6: .asciiz "Tocar em tempo Real (1)\n"

texto7: .asciiz "Tocar de uma String (2)\n"

texto8: .asciiz "Ecolha uma op��o:\n"

texto9: .asciiz "MENU\n\n"
notas: .space 100




