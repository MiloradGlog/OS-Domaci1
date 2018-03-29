
ASCII_SMILE	equ 1
ZELENA		equ 02h
ASCII_ESC	equ 1bh

	org 100h
	
	;postavljanje pocetne pozicije
	mov ax, 0B800h
	mov es, ax
	
	mov bx, 400
	
	mov cl, ZELENA
	
	jmp iscrtavanje
	
petlja:
	;citanje dugmeta sa tastature
	mov ah, 0
	int 16h
	
	;pomeranje smajlija ili izlazak iz programa
	cmp al, 'w'
	je pomeri_gore
	cmp al, 's'
	je pomeri_dole
	cmp al, 'a'
	je pomeri_levo
	cmp al, 'd'
	je pomeri_desno
	cmp al, ASCII_ESC
	je kraj
	
	jmp petlja
	
pomeri_gore:
	sub bx, 160 ;pomeramo smajlija u prethodni red
	jmp iscrtavanje
	
pomeri_dole:
	add bx, 160
	jmp iscrtavanje
	
pomeri_levo:
	sub bx, 2
	jmp iscrtavanje

pomeri_desno:
	add bx, 2
	jmp iscrtavanje
	
	;iscrtavanje smajlija
iscrtavanje:
	mov byte [es:bx], ASCII_SMILE
	inc bx
	mov byte [es:bx], cl
	dec bx
	
	inc cl
	jmp petlja
	
kraj:
	ret
	
	
	
	
