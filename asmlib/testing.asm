			; Zona configuracion de memoria
;--------------------------------------------------------------------;
		
		.module 		testing
		
		.area			_TESTING
		
		;>>>> Etiquetas globales internas <<<<
		
		.globl			isdigit
		.globl			isalpha
		.globl			tolower
		.globl			toupper
		
		;------------------------------------;
		
		
;--------------------------------------------------------------------;
		; Fin zona configuracion memoria
		
		
		
		
		
		
		; Inicio definicion de constantes
;--------------------------------------------------------------------;												
			
fin		.equ			0xFF01				
teclado		.equ			0xFF02
pantalla	.equ			0xFF00

;--------------------------------------------------------------------;
		; Fin definicion de constantes
		
		
		
		
		; Objetos subrutinas
;--------------------------------------------------------------------;
;--------------------------------------------------------------------;
		; Fin objetos subrutinas
		
		
		
		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;				isdigit					;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Comprueba si el contenido del registro A es un digito en ASCII	;
; Si es así, pone el flag Z a 1, en otro caso, lo pone a 0.		;
;									;	
; Input: Dato contenido en registro A 					;
; Output: flag Z 							;
;									;
; Registros afectados: CC						;
; Flags afectados: 	|E|F|H|I|N|Z|V|C|				;
;			| | |X| |X|X|0|X|				;
;									;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

isdigit:		
		pshs			b
		
		
		ldb			#0x30			;;;;;;;;;
		pshs			a				;
									;	
	testing_isdigit_for:						;
									;
		cmpb			#0x3A				;
		beq			testing_isdigit_finFor		; Bucle for (B = 0x30; B <= 0x40; ++B)
									;	if (A = B)
			cmpb			,s			;		break
			beq			testing_isdigit_finFor	;
		incb							;
		bra			testing_isdigit_for	;;;;;;;;;

	testing_isdigit_finFor:
	
		puls			a
		
		cmpb			#0x3A			;;;;;;;;;
		beq			testing_isdigit_notDigit	;
									;
		orcc			#0x04 	; Ponemos a		; 	
						; 1 el flag Z		; if (B = 0x3A)
									;	noEsUnDigito
		bra			testing_isdigit_finIsDigit	; else	
									; 	esDigito
	testing_isdigit_notDigit:					;	
									;
		andcc			#0xFB	; Ponemos a		;
						; 0 el flag Z		; 
								;;;;;;;;;	
												
	testing_isdigit_finIsDigit:
	
		puls			b
		rts
				
;--------------------------------------------------------------------;
		; Fin isdigit
		
		
		
		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;				isalpha					;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Comprueba si el contenido del registro A es un caracter alfabetico	;
; en ASCII; si es así, pone el flag Z a 1, en otro caso, lo pone a 0.	;
;									;
; Input: Dato contenido en registro A 					;
; Output: flag Z 							;
;									;
; Registros afectados: CC						;
; Flags afectados: 	|E|F|H|I|N|Z|V|C|				;
;			| | |X| |X|X|0|X|				;
;									;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

isalpha:		
		pshs			b
		
		ldb			#0x41			;;;;;;;;;
		pshs			a				;
									;
	testing_isalpha_for1:						;
									;
		cmpb			#0x5B				;
		beq			testing_isalpha_finFor1		; Bucle for (B = 'A'; B <= '['; ++B)
									;	if (A = B)
			cmpb			,s			;		break
			beq			testing_isalpha_finFor2	;
									; En ASCII (... 'x', 'y', 'z', '[')
		incb							;
		bra			testing_isalpha_for1	;;;;;;;;;

	testing_isalpha_finFor1:
		
		
		ldb			#0x61			;;;;;;;;;
									;
	testing_isalpha_for2:						;
									;
		cmpb			#0x7B				;
		beq			testing_isalpha_finFor2		; Bucle for (B = 'a'; B <= '{'; ++B)
									;	if (A = B)
			cmpb			,s			;		break
			beq			testing_isalpha_finFor2	;
									; En ASCII (... 'X', 'Y', 'Z', '{')
		incb							;
		bra			testing_isalpha_for2	;;;;;;;;;

	testing_isalpha_finFor2:
		
		
		puls			a
				
		cmpb			#0x5B			;;;;;;;;;
		beq			testing_isalpha_notAlpha	;
		cmpb			#0x7B				; if (B = 0x5B || B = 0x7B)
		beq			testing_isalpha_notAlpha	;	noEsAlpha
		orcc			#0x04	; Ponemos a 		; else
						; 1 el flag Z		;	esAlpha
		bra			testing_isalpha_finIsAlpha	;		
									; 
	testing_isalpha_notAlpha:					;
									;	
		andcc			#0xFB	; Ponemos a 		;
						; 0 el flag Z		;
								;;;;;;;;;					
	testing_isalpha_finIsAlpha:
			
		puls			b
		rts
				
;--------------------------------------------------------------------;
		; Fin isalpha
		
		
		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;				toupper					;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Cambia los caracteres alfabeticos por sus correspondientes mayusculas	;
;									;	
; Input: Dato contenido en registro A 					;
; Output: Dato contenido en el registro A 				;
;									;
; Registros afectados: A, CC						;
; Flags afectados: 	|E|F|H|I|N|Z|V|C|				;
;			| | |X| |X|X|X|X|				;
;									;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

toupper:

		cmpa			#'a
		blo			testing_toupper_sinCambios
		cmpa			#'z
		bhi			testing_toupper_sinCambios
		
		suba			#0x20	; Diferencia entre letra minuscula y
						; mayuscula en el codigo ASCII
		
	testing_toupper_sinCambios:
	
		rts
		
;--------------------------------------------------------------;
		; Fin toupper
		
		
		
		
		
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;				tolower					;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Cambia los caracteres alfabeticos por sus correspondientes minusculas	;
;									;	
; Input: Dato contenido en registro A 					;
; Output: Dato contenido en el registro A 				;
;									;
; Registros afectados: A, CC						;
; Flags afectados: 	|E|F|H|I|N|Z|V|C|				;
;			| | |X| |X|X|X|X|				;
;									;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

tolower:

		cmpa			#'A
		blo			testing_tolower_sinCambios
		cmpa			#'Z
		bhi			testing_tolower_sinCambios
		
		adda			#0x20	; Diferencia entre letra minuscula y
						; mayuscula en el codigo ASCII
		
	testing_tolower_sinCambios:
	
		rts
		
;--------------------------------------------------------------;
		; Fin tolower