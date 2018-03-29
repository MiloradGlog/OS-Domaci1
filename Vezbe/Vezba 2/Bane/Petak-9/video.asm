
	org 100h
	
	mov ax, 0B800h
	mov es, ax
	
	mov bx, 320 ;es:bx nam pokazuje na poziciju u video memoriji
	
	mov [poruka], 'ispisasds'
	
	mov si, poruka
	
petlja:
	mov al, byte [ds:si] ;citamo bajt sa lokacije na koju pokazuje SI
	
	cmp al, 0
	je  kraj
	
	mov byte [es:bx], al ;upisujemo taj bajt u video memoriju
	inc bx ;es:bx sada pokazuje na bajt koji opisuje boju trenutnog karaktera
	mov byte [es:bx], 82h
	
	inc si	;SI pokazuje na naredni karakter koji treba ispisati
	inc bx  ;BX pokazuje na narednu lokaciju u video memoriji
	
	jmp petlja
	
kraj:
	ret
	
	
poruka: db 'Ispis u video memoriji',0