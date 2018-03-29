; ==================================================
; Vezba 1: primer1.asm
;    - Ispisivanje poruke na ekranu upotrebom DOS-a
;
; Prevodjenje:
;      nasm primer1.asm -f bin -o primer1.com
; ================================================== 



	org 100h
	mov ah, 00h
	int 16h
	call printw
	int 0x20


printw:
 push ax
 shr ax, 8
 call printb
 pop ax
 push ax
 and  ax, 0xff
 call printb
 pop ax
 ret
printb:
  push ax
  shr al, 4
  call printasc
  pop ax
  and al, 0xf
  call printasc
  ret
printasc:
  add al, 0x30
  cmp al, 0x39
  jle printasc_e
  add al, 0x7
  printasc_e:
  mov dl, al
  mov ah, 0x2
  int 0x21
  ret


poruka: db 'mile$'
