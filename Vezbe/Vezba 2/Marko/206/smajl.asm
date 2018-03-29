video_mem equ 0b800h
centar equ 2000
esc equ 1bh

	org 100h
main:
	mov ax, video_mem
	mov es, ax
	mov dl, 02h
	mov bx, centar
	
petlja:
	call prikazi_smajl
	
	mov ah, 0
	int 16h
	
	call obrisi_smajl
	
	cmp al, esc
	je izlaz
	
	cmp al, 'd'
	je idiDesno
	
	cmp al, 'a'
	je idiLevo
	
	cmp al, 'w'
	je idiGore
	
	cmp al, 's'
	je idiDole

	jmp petlja
	
	
idiDesno:
	add bx, 2
	jmp petlja
idiLevo:
	sub bx, 2
	jmp petlja
idiGore:
	sub bx, 160
	jmp petlja
idiDole:
	add bx, 160
	jmp petlja

	
izlaz:
	ret

prikazi_smajl:
	mov byte [es:bx], byte 1
	inc bx
	mov byte [es:bx], dl
	inc dl
	dec bx
	ret
	
obrisi_smajl:
	mov byte [es:bx], byte ' '
	inc bx
	mov byte [es:bx], byte 02h
	dec bx
	ret

	
segment .data
string1: db 'Hello World',0




