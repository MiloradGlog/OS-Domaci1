
SMAJLI	equ 1
ZELENA	equ 82h
DUGME_W	equ 119
DUGME_A equ 97
DUGME_S equ 115
DUGME_D equ 100
DUGME_ESC equ 27

	org 100h
	
	mov ax, 0B800h
	mov es, ax
	
	;TODO: postaviti smajlija na poziciju kursora
	mov bx, 400
	;postavi pocetnu poziciju
	mov cl, ZELENA ;pocetna boja
	
	jmp prikaz
petlja:
	;citaj dugme sa tastature
	mov ah, 0
	int 16h ;cita tastaturu, i smesta ASCII karakter u AL
	
	;pomeri smajlija i proveri kraj
	cmp al, DUGME_ESC ;ako je ESC, izlazimo iz programa
	je kraj
	;skacemo na odgovarajucu labelu
	cmp al, DUGME_A
	je pomeri_levo 
	cmp al, DUGME_D
	je pomeri_desno
	cmp al, DUGME_W
	je pomeri_gore
	cmp al, DUGME_S
	je pomeri_dole
	;ako nije ni jedno dugme
	jmp petlja
	
	;pomeramo bx
pomeri_levo:
	sub bx, 2
	jmp prikaz
pomeri_desno:
	add bx, 2
	jmp prikaz
pomeri_dole:
	add bx, 160
	jmp prikaz
pomeri_gore:
	sub bx, 160
	jmp prikaz ;ne radi nista :)
	
	;iscrtaj smajlija
prikaz:
	mov byte [es:bx], SMAJLI
	inc bx
	mov byte [es:bx], cl
	inc cl
	dec bx ;bx pokazuje na lokaciju smajlija kog smo iscrtali
	
	jmp petlja
	
kraj:
	ret