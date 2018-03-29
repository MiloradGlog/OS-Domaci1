
	org 100h
	
	;otvorimo datoteku in.txt za citanje
	mov ah, 3dh ;operacija OPEN
	mov al, 0 ;access mode: 0 = read, 1 = write, 2 = read+write
	mov dx, ime_in ;ime datoteke ide u DX
	int 21h ;izvrsavamo otvaranje; file handle je u AX
	
	;procitamo datoteku in.txt
	mov bx, ax ;cuvamo file handle u BX
	mov ah, 3fh ;operacija READ
	mov cx, 256 ;citamo maksimalno 256 bajtova
	mov dx, podaci ;dx pokazuje na bafer u koji smestamo podatke
	int 21h ;izvrsavamo citanje, broj procitanih bajtova je u AX
	
	push ax ;cuvamo velicinu datoteke na steku
	
	;zatvorimo datoteku in.txt
	mov ah, 3eh ;operacija CLOSE
	;bx je vec postavljen
	int 21h  ;izvrsavamo operaciju zatvaranja; nema povratne vrednosti
	
	;kreiramo datoteku out.txt
	mov ah, 3ch ;operacija CREATE
	mov cx, 0 ;atributi - sve prazno
	mov dx, ime_out ;dx je ime datoteke koju kreiramo
	int 21h ;izvrsavamo kreiranje; file handle je u AX
	
	;pisemo datoteku out.txt
	mov bx, ax ;file handle ide u BX
	mov ah, 40h ;operacija WRITE
	pop cx ;velicina podataka ide u CX
	mov dx, podaci ;DX pokazuje na podatke koje upisujemo
	int 21h ;izvrsavamo upis
	
	;zatvorimo datoteku out.txt
	mov ah, 3eh ;operacija CLOSE
	;bx je dobar
	int 21h ;izvrsavamo zatvaranje
	
	ret ;kraaaajjj
	
ime_in: db 'in.txt',0
podaci: resb 256
ime_out: db 'out.txt', 0
