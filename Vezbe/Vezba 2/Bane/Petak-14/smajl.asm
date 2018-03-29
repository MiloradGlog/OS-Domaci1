
ASCII_SMILE	equ	1
VID_SEG		equ 	0B800h
START_POS	equ	400
GREEN		equ 	02h
ASCII_ESC	equ	1bh
LEVO		equ     61h
DESNO		equ 	64h
GORE		equ	77h
DOLE		equ	73h


	org 100h
	
	;postavimo pocetnu poziciju za smajlija
	mov ax, VID_SEG
	mov es, ax
	mov bx, START_POS
	mov cl, GREEN
	
petlja:
	;iscrtamo smajlija
	mov byte [es:bx], ASCII_SMILE
	inc bx
	mov byte [es:bx], cl
	dec bx
	inc cl
	
	;procitamo vrednost sa tastature
	mov ah, 0
	int 16h		;AL je ASCII karakter koji je pritisnut
	
	;pomerimo smajlija zavisno od vrednosti sa tastature
	;ili zavrsimo rad programa
	

	jmp compare_input	



compare_input:

	push al

	cmp al, GORE
	je idi_gore
	cmp al, DOLE
	je idi_dole
	cmp al, LEVO
	je idi_levo
	cmp al, DESNO
	je idi_desno
	cmp al, ASCII_ESC
	je kraj

	jmp compare_dl
	
compare_dl:
	pop dl	

	cmp dl, GORE
	je idi_gore
	cmp dl, DOLE
	je idi_dole
	cmp dl, LEVO
	je idi_levo
	cmp dl, DESNO
	je idi_desno
	cmp dl, ASCII_ESC
	je kraj
	
	jmp petlja


idi_gore:
	sub bx, 160
	jmp petlja
idi_dole:
	add bx, 160
	;poslednja_komanda DB DOLE
	jmp petlja
idi_levo:
	sub bx, 2
	;poslednja_komanda DB LEVO
	jmp petlja
idi_desno:
	add bx, 2

	jmp petlja
	
	;ponovo iscrtamo, citamo, itd...
	
	jmp petlja
	
kraj:
	ret
	
