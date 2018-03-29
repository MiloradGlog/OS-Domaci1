
	org 100h
	
	;open file
	mov ah, 3dh ;operacija OPEN
	mov al, 0 ;0 = read, 1 = write, 2 = read+write
	mov dx, ime_in ;ime fajla ide u DX
	int 21h ;ako je uspesno, AX je file handle
	
	;read file
	mov bx, ax ;file handle mora da bude u BX
	mov ah, 3fh ;operacija READ
	
	mov cx, 256 ;max velicina fajla je 256 bajtova
	mov dx, podaci
	int 21h ;prava velicina podataka se nalazi u AX
	
	push ax ;na steku se nalazi velicina podataka\
	
	;close file
	mov ah, 3eh ;operacija CLOSE
	;BX je vec postavljen
	int 21h
	
	;create file
	mov ah, 3ch ;operacija CREATE
	mov cx, 0h ;atributi su 0
	mov dx, ime_out ;naziv fajla ide u DX
	int 21h ;u AX se nalazi file handle
	
	;write file
	mov bx, ax ;BX je file handle
	mov ah, 40h ;operacija WRITE
 	pop cx ;broj bajtova koji se upisuje skidamo sa steka
	mov dx, podaci ;podaci koji se upisuju
	int 21h
	
	;close file
	mov ah, 3eh ;operacija CLOSE
	;BX je vec postavljen
	int 21h
	
	ret
	
	
ime_in: db 'in.txt',0
podaci: resb 256
ime_out: db 'out.txt',0