
	org 100h
	
	;otvorimo datoteku in.txt
	mov ah, 3dh ;kod otvaranja datoteke
	mov al, 0 ;al = 0 - otvaramo za citanje (1 - pisanje, 2 - citanje i pisanje)
	mov dx, ime_in ;naziv datoteke koju citamo
	int 21h ;otvara datoteku, file handle ce biti u AX
	
	;citamo datoteku in.txt
	mov bx, ax ;smestimo file handle u bx
	mov ah, 3fh ;kod citanja datoteke
	mov cx, 256 ;pretpostavimo da je datoteka dugacka max 256 bajtova
	mov dx, contents ;dx je pokazivac na niz u koji smestamo podatke
	int 21h ;cita datoteku, u AX je prava velicina datoteke
	
	;zelimo da sacuvamo vrdnost iz AX za pisanje
	push ax ;na steku cuvamo pravu velicinu datoteke
	
	;zatvorimo datoteku in.txt
	mov ah, 3eh ;kod zatvaranja datoteke
	;bx je vec dobar
	int 21h ;zatvara datoteku na koju pokazuje bx
	
	;kreiramo odredisnu datoteku out.txt
	mov ah, 3ch ;kod kreiranja datoteke
	mov cx, 0 ;bez atributa
	mov dx, ime_out ;naziv datoteke koju kreiramo
	int 21h ;kreira datoteku, file handle ce biti u AX
	
	;pisemo u out.txt
	mov bx, ax ;smestamo file handle u BX
	mov ah, 40h ;kod pisanja podataka u datoteku
	pop cx ;sa steka skidamo velicinu datoteke i smestamo u cx
	mov dx, contents
	int 21h
	
	;zatvorimo out.txt
	mov ah, 3eh
	int 21h
	
	ret
	
ime_in: db 'in.txt',0
ime_out: db 'out.txt',0
contents: resb 256 ;rezervisemo 256 bajtova za podatke