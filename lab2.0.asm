num1 db 23h
num2 db 25h

start:
    mov al, num1        
    add al, num2        
    mov bl, al          
    
    mov al, bl          
    shr al, 4           
    and al, 0Fh         
    add al, 30h         
    cmp al, 39h         
    jle print_digit1    
    add al, 7           

print_digit1:
    mov dl, al          
    mov ah, 02h         
    int 21h             

    mov al, bl          
    and al, 0Fh         
    add al, 30h         
    cmp al, 39h         
    jle print_digit2    
    add al, 7           

print_digit2:
    mov dl, al          
    mov ah, 02h         
    int 21h             
    
    mov ah, 4Ch         
    int 21h             
