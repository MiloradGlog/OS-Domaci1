video_mem equ 0b800h

	org 100h
main:
	
	mov si, string1
	mov dl, 03h
	mov bx, 160
	call _dprint
	
	
	
	ret
	
	
_dprint:
	pusha
	mov ax, video_mem
	mov es, ax
	
.skok:

	mov al, byte [si]
	
	or al, al	;cmp al, 0
	jz .end		;je .end
	
	mov byte [es:bx], al
	inc bx
	mov byte [es:bx], dl
	inc bx
	inc si


	jmp .skok
	
	
.end:
	popa
	ret
	
segment .data
string1: db 'Hello World',0




