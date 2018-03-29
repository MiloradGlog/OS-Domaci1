
	org 100h
	
	;pocetna vrednost za es:bx
	mov ax, 0B800h
	mov es, ax
	
	mov bx, 320 ;pocetak drugog reda u video memoriji
	
	mov si, poruka ;si pokazuje na poruku u RAM
	
petlja:
	mov al, byte [si] ;procitamo bajt sa lokacije na koju pokazuje SI
	
	cmp al, 0 ;proverimo da li smo dosli do kraja
	je kraj
	
	mov byte [es:bx], al ;upis karaktera u video memoriju
	inc bx
	mov [es:bx], byte 02h ;upis boje za trenutni karakter
	
	inc si ;naredni karakter u RAM
	inc bx ;naredna pozicija u video memoriji
	
	jmp petlja
	
kraj:
	ret
	
poruka: db 'Video upis stagod', 0