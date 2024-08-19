org 100h

jmp start

num1 dw 123           
num2 dw 15           
msg db 'Result: $'   
newline db 0Dh, 0Ah, '$' 

start:
    mov ax, [num1]  
    
    add ax, [num2]  
    
    call PrintNumber16  

    mov dx, offset newline 
    mov ah, 09h           
    int 21h               
    
    mov ah, 4Ch        
    int 21h            

PrintNumber16 proc                    
    cmp ax, 0
    jne PrintDigits
    mov dl, '0'
    mov ah, 02h
    int 21h
    ret

PrintDigits:
    mov cx, 0           
    mov bx, 10          

PrintLoop:
    xor dx, dx          
    div bx              
    push dx             
    inc cx              
    test ax, ax         
    jnz PrintLoop       

PrintStack:
    pop dx              
    add dl, '0'         
    mov ah, 02h         
    int 21h             
    loop PrintStack     
    
    ret
PrintNumber16 endp
