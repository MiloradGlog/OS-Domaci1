

	org 100h
main:
	; otvaranje fajla
	mov ah, 3dh
	mov dx, inputf
	mov al, 0
	int 21h
	; u ax se nalazi file handle
	

	mov bx, ax
	mov ah, 3fh
	mov cx, 256
	mov dx, buf
	int 21h
	; procitano i u ax se nalazi broj procitanih bajtova
	
	push ax
	
	;close
	mov ah, 3eh
	int 21h
	
	mov cx, 0
	mov ah, 3ch
	mov dx, outf
	int 21h
	; kreiran fajl i handle je u ax
	
	
	mov bx, ax
	pop cx
	mov dx, buf
	mov ah, 40h
	int 21h
	
	;close
	mov ah, 3eh
	int 21h
	
	
	
	
	ret
	
	
segment .data
inputf: db 'in.txt', 0
outf:	db 'out.txt', 0
buf:	resb 256
	
	
	
