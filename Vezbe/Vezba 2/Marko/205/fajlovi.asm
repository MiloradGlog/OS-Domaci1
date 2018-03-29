

	org 100h
	
main:
	
	;ucitaj iz fajla
	
	
	mov ah, 3dh
	mov al, 0
	mov dx, file1
	int 21h 	;fopen
				;u ax se nalazi file handle otvorenog fajla
	
	mov bx, ax	;sada je file handle u bx
	mov cx, 256
	mov ah, 3fh
	mov dx, buf
	int 21h		;fgets
	
	push ax		;na steku cuvamo duzinu ucitanog stringa
	
	mov ah, 3eh
	int 21h 	;fclose

	
	
	;kreiraj file
	mov ah, 3ch
	mov cx, 0
	mov dx, file2
	int 21h
	;ax je file handle
	
	
	mov ah, 40h
	mov dx, buf
	pop cx
	int 21h 	;fputs
	
	mov ah, 3eh
	int 21h 	;fclose
	
	ret
	

	
segment .data

file1:  db 'in.txt', 0
file2:  db 'out.txt', 0
buf: 	resb 256