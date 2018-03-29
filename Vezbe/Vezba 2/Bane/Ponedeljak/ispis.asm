
	org 100h
	
	;es je segment video memorije
	mov ax, 0B800h
	mov es, ax
	
	;bx je pomeraj unutar tog segmenta
	mov bx, 1000
	
	mov si, poruka

ispis:
	;procitamo podatak sa lokacije na koju pokazuje si
	mov al, byte [si]
	
	;provera izlaza
	;cmp al, 0
	;je kraj
	
	;upisemo podatak u video memoriju
	mov byte [es:bx], al
	inc bx ;bx pokazuje na boju za trenutni karakter
	mov byte [es:bx], 82h ;zelena na crnoj
	
	inc bx ;bx pokazuje na lokaciju za naredni karakter u video memoriji
	inc si ;si pokazuje na naredni karakter koji ispisujemo
	jmp ispis
	
kraj:
	ret
	
poruka: db 'Ispis u video memoriji',0