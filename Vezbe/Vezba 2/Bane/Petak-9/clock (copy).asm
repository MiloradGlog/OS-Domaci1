START_POS	equ	288
NO_OF_ROWS	equ 10


org 100h



	;postavljanje pocetne pozicije
	mov ax, 0B800h
	mov es, ax
	
	mov bx, START_POS

	mov ax, bx	
	add ax, 32

	mov cl, 30

	;u dl pushujem broj reda
	mov dx, 0
	push dx

	jmp ispisi
	
	jmp kraj


ispisi:
	
	call ispisi_prazan_red
	call novi_red
	call ispisi_vreme_red
	call novi_red
	call ispisi_prazan_red
	call novi_red
	
	
	ret


novi_red:
	add bx, 128
	mov ax, bx
	add ax, 32
	ret
	


ispisi_prazan_red:

	mov dl, ' '
	mov dh, dl
	mov byte [es:bx], dh
	inc bx
	mov byte [es:bx], cl
	dec bx
	
	add bx, 2
	cmp bx, ax
	je kraj	

	jmp ispisi_prazan_red





	


print_red_char:
	
	mov dh, dl
	mov byte [es:bx], dh
	inc bx
	mov byte [es:bx], cl
	dec bx
	
	
	inc dl
	add bx, 2
	;da li treba da postoji
	cmp bx, ax
	je kraj	

	ret


ispisi_red:

	mov dl, 'a'
	call print_red_char
	mov dl, 'b'
	call print_red_char
	
	cmp bx, ax
	je kraj	
	
	jmp ispisi_red




;funkcije za vreme -----------------------------------------------------

ispisi_vreme_red:

	;push ax
	push ax
	
	;cita sate, minute i sekunde i upisuje ih u ah i al i pushuje sekunde i minute na stack
	call procitaj_sekunde
	;sekund push
	push ax
	
	call procitaj_minute
	;minut push
	push ax
	
	call procitaj_sate

	;ispisuje prva cetiri karaktera
	mov dl, ' '
	call print_red_char
	mov dl, ' '
	call print_red_char
	mov dl, ' '
	call print_red_char
	mov dl, 186
	call print_red_char
	
	;ispisuje sate
	push ax
	or al, 30h
	mov dl, al
	call print_red_char
	pop ax
	or ah, 30h
	mov dl, ah
	call print_red_char
	;:
	mov dl, ':'
	call print_red_char
	;ispisuje minute
	;minut pop
	pop ax
	push ax
	or al, 30h
	mov dl, al
	call print_red_char
	pop ax
	or ah, 30h
	mov dl, ah
	call print_red_char
	;:
	mov dl, ':'
	call print_red_char
	;ispisuje sekunde
	;sekund pop
	pop ax
	push ax
	or al, 30h
	mov dl, al
	call print_red_char
	pop ax
	or ah, 30h
	mov dl, ah
	call print_red_char
	
	;ispisuje poslednja cetiri karaktera
	mov dl, 186
	call print_red_char
	mov dl, ' '
	call print_red_char
	mov dl, ' '
	call print_red_char
	mov dl, ' '
	call print_red_char
	
	pop ax
	
	cmp bx, ax
	je kraj	
	
	jmp kraj
	



procitaj_sate:
	
	
	push cx
	push dx
	
	mov ah, 2ch
	int 21h
	mov  ah,0
   	mov  al,ch                       ;dividend
   	mov  cl,10                       ;divisor
   	div  cl                          ;quotient in al, remainder in ah
	
	pop dx
	pop cx
	
	;OVDE SI STAO, ZASTO NE ISPISUJE SATE DOBRO U DISPLAY-u DOLE?
	;MOZDA DA SE NAPRAVI READ FROM REGISTER ILI FROM DL RECIMO
	ret

procitaj_minute:
	
	push cx
	push dx
	
	mov ah, 2ch
	int 21h
	mov  ah,0
   	mov  al,cl                       ;dividend
   	mov  cl,10                       ;divisor
   	div  cl                          ;quotient in al, remainder in ah
	
	pop dx
	pop cx
	
	;OVDE SI STAO, ZASTO NE ISPISUJE SATE DOBRO U DISPLAY-u DOLE?
	;MOZDA DA SE NAPRAVI READ FROM REGISTER ILI FROM DL RECIMO
	ret
	
procitaj_sekunde:
	
	push cx
	push dx
	
	mov ah, 2ch
	int 21h
	mov  ah,0
   	mov  al,dh                       ;dividend
   	mov  cl,10                       ;divisor
   	div  cl                          ;quotient in al, remainder in ah
	
	pop dx
	pop cx
	
	;OVDE SI STAO, ZASTO NE ISPISUJE SATE DOBRO U DISPLAY-u DOLE?
	;MOZDA DA SE NAPRAVI READ FROM REGISTER ILI FROM DL RECIMO
	ret





kraj:
	ret

