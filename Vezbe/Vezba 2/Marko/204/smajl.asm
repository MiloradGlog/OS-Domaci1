video_mem equ 0b800h
centar equ 2000
esc equ 1bh

	org 100h
main:
	mov ax, video_mem		;push word video_mem
	mov es, ax				;pop es
	mov bx, centar
	mov dl, 02h
	
skok:
	
	call printSmajl
	mov ah, 0
	int 16h		;ucitava karakter sa tastature u al
	call printSpace
	
	
	cmp al, esc
	je izlaz
	
	cmp al, 'w'
	je idiGore
	
	cmp al, 's'
	je idiDole
	
	cmp al, 'a'
	je idiLevo
	
	cmp al, 'd'
	je idiDesno
	
	
	jmp skok

idiGore:
	sub bx, 160
	jmp skok

idiDole:
	add bx, 160
	jmp skok	

idiDesno:
	add bx, 2
	jmp skok
	
idiLevo:
	sub bx, 2
	jmp skok
	
izlaz:
	ret
	
printSmajl:
	mov ch, byte [es:bx]
	mov byte [es:bx], byte 1
	inc bx
	mov cl, byte [es:bx]
	mov byte [es:bx], dl
	dec bx
	inc dl
	ret
	
printSpace:
	mov byte [es:bx], ch
	inc bx
	mov byte [es:bx], cl
	dec bx
	ret
	
	
	
