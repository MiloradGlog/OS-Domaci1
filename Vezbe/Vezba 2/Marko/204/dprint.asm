video_mem equ 0b800h

	org 100h
main:
	mov si, string1
	mov bx, 160
	mov dl, 02h
	call _dprint
	
	ret
	
_dprint:
	pusha
	mov ax, video_mem
	mov es, ax
	
.skok:
	mov al, byte [ds:si]
	
	or al, al	;cmp al, 0
	jz .izlaz	;je .izlaz

.LFtest:	
	cmp al, 0ah
	jne .LFSkip
	add bx, 160
	jmp .skipPrint
.LFSkip:

.CRtest:
	cmp al, 0dh
	jne .CRSkip
	mov ax, bx
	push bx
	mov bl, 160
	div bl
	pop bx
	mov al, ah
	xor ah, ah	
	sub bx, ax
	
	jmp .skipPrint
.CRSkip:
	
	mov byte [es:bx], al
	inc bx
	mov byte [es:bx], dl
	inc bx
	
.skipPrint:
	inc si
	jmp .skok
	
	
		
	
	
.izlaz:
	popa
	ret
	
	
segment .data
string1: db 'print', 0ah, 'memorija', 0


