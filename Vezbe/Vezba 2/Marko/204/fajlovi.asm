
	org 100h
main:

	;fopen
	mov ah, 3dh
	mov al, 0
	mov dx, infile
	int 21h
	;file handle je u ax
	
	
	;fgets
	mov bx, ax
	mov ah, 3fh
	mov cx, 256
	mov dx, buffer
	int 21h
	;ax je brj procitanih bajtova
	push ax
	
	;fclose
	mov ah, 3eh
	int 21h
	
	;fopen ('w' i O_CREAT)
	;kreiranje fajla
	mov ah, 3ch
	mov cx, 0
	mov dx, outfile
	int 21h
	;file handle je u ax
	
	
	;fputs
	mov bx, ax
	mov ah, 40h
	pop cx
	mov dx, buffer
	int 21h
	
	;fclose
	mov ah, 3eh
	int 21h
	
	
	ret
	
segment .data
infile: db 'in.txt', 0
outfile: db 'out.txt', 0
buffer:	resb 256