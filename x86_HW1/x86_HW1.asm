[org 0x7c00]		; Assembly command
					; Let NASM compiler know starting address of memory
					; BIOS reads 1st sector and copied it on memory address 0x7c00
[bits 16] 			; Assembly command
					; Let NASM compiler know that this code consists of 16its

[SECTION .text] 	; Text section

START:				; Boot loader(1st sector) starts
    cli				; Clear interrupt
    xor ax, ax		; Initialize ax register
	mov ax, 0x8FF
	mov ds, ax		; Set data segment register
	mov bx, 0x00
	mov al, 0x01

;-----------Following code is for filling some values in the memory-------------;

mem:																		
	mov byte [ds:bx], al
	cmp bx, 0xFF
	je test_end
	jmp re

re:
	add al, 0x02
	add bx, 0x01
	jmp mem
	
test_end:
	cli
	xor ax, ax
	mov ds, ax
    mov ax, 0xB800
    mov es, ax 
	
;-------------------------------------------------------------------------------;

	sti						; Set interrupt
	
    call load_sectors 		; Load rest sectors
    jmp sector_2

load_sectors:			 	; Read and copy the rest sectors of disk

   	push es
    xor ax, ax
    mov es, ax									; es=0x0000
 	mov bx, sector_2 							; es:bx, Buffer Address Pointer
    mov ah,2 									; Read Sector Mode
    mov al,(sector_end - sector_2)/512 + 1  	; Sectors to Read Count
    mov ch,0 									; Cylinder Number=0
    mov cl,2 									; Sector Number=2
    mov dh,0 									; Head=0
    mov dl,0 									; Drive=0, A:drive
	int 0x13 									; BIOS interrupt
												; Services depend on ah value
    pop es
    ret

times   510-($-$$) db 0 		; $ : current address, $$ : start address of SECTION
								; $-$$ means the size of source
dw      0xAA55 					; signature bytes
								; End of Master Boot Record(1st Sector)
								
		

sector_2:						; Program Starts
	mov ax, 0x8FF
	mov ss, ax
	mov sp, 0x10
	mov ax, 0x1234
	push ax
	mov bx, 0x8FFC
	mov dl, byte [ds:bx]
	add ah, dl
	xchg al, bh
	mov bx, 0x8FFD
	mov word[ds:bx], ax
	sub al, ah
	mov bx, 0x8FFF
	mov byte[ds:bx], al

	
;-------------------------Write your code here----------------------------------;	
; Print your Name in VMware screen											    ;
; Print your ID in VMware screen											    ;
; Print the value(word size) in the Stack Pointer after executing the above code;
;																	    		;
;																	    		;
;																	    		;
;																	    		;
;																	    		;
;																	    		;
;-------------------------------------------------------------------------------;
print_string:
	mov cx, 0	;row number
	mov di, 0	;column number

	mov esi, ID
	call print_string_loop
	mov esi, NAMEE
	call new_line
	call print_string_loop
	mov esi, Answer
	call new_line
	call print_string_loop
	call print_sp
	jmp exit

print_string_loop:
	lodsb             ; DS:SI의 데이터를 AL로 로드하고 SI 증가
	cmp al, 0         ; NULL이면 문자열 끝
	je done_print
	mov byte [es:di], al   ; 문자 출력
	inc di
	mov byte [es:di], 0x07  ; 속성(흰색 글자, 검정 배경)
	inc di
	jmp print_string_loop

done_print:
	ret

new_line:
	inc cx
	mov ax, cx
	mov bx, 160
	mul bx
	mov di, ax
	ret
print_sp:
	pop bx
	push cx
	mov cx, 0	;count
print_sp_loop:
	mov ax, 0xF000
	and ax, bx
	shr ax, 12
	cmp al, 0xA
	jae print_alphabet
	jmp print_number
print_alphabet:
	add al, 0x37
	jmp print_sp_loop2
print_number:
	add al, 0x30
	jmp print_sp_loop2

print_sp_loop2:
	mov byte [es:di], al   ; 문자 출력
	inc di
	mov byte [es:di], 0x07  ; 속성(흰색 글자, 검정 배경)
	inc di
	shl bx, 4
	inc cx
	cmp cx, 4
	je done_print_sp
	jmp print_sp_loop

done_print_sp:
	pop cx
	ret

exit:

;---------------------- Write your Name and ID here-----------------------------;

ID  db 'ID : 2020311573',0
NAMEE db 'NAME : Shin Jong Hoon',0
Answer db 'A value in Stack Pointer(word size) : ',0

;-------------------------------------------------------------------------------;
	
sector_end:

