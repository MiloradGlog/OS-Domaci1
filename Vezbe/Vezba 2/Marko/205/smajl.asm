video_mem equ 0b800h
start_pos equ 2000
esc		  equ 1bh

	org 100h
	
main:
	
	mov ax, video_mem
	mov es, ax
	mov dl, 02h
	mov bx, start_pos
	
start:

	xor ax, ax		;mov ax, 0 ali brze
	int 16h
	
	cmp al, esc
	je kraj
	
	cmp al, 'w'
	je idiGore
	
	cmp al, 's'
	je idiDole
	
	cmp al, 'a'
	je idiLevo
	
	cmp al, 'd'
	je idiDesno
	
	jmp start
	
	
idiGore:
	call obrisi
	sub bx, 160
	call ispisiSmajl
	jmp start
	



idiDole:
	call obrisi
	add bx, 160
	call ispisiSmajl
	jmp start


idiLevo:
	call obrisi
	sub bx, 2
	call ispisiSmajl
	jmp start


idiDesno:
	call obrisi
	add bx, 2
	call ispisiSmajl
	jmp start
	
	
kraj:
	ret
	


ispisiSmajl:
	mov byte [es:bx], byte 1
	inc bx
	
	; boja
	inc dl
	
	mov byte [es:bx], dl
	dec bx
	ret
	
obrisi:
	mov byte [es:bx], byte ' '
	inc bx
	mov byte [es:bx], 07h
	dec bx
	ret
	
	
	
	
	
	
	
	