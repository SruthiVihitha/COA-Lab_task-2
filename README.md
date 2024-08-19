### Overview
This repository contains two assembly programs written for the EMU8086 emulator. Both programs perform basic arithmetic operations and display the result using the DOS interrupt `int 21h`. The programs demonstrate the addition of numbers and the conversion of the result into a human-readable format.

### Program 1: 16-bit Addition and Display

#### Files
- **Program 1:** 
  ```assembly
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
  ```

#### Description
- **Objective:** Add two 16-bit numbers and print the result.
- **Instructions:**
  - The program starts by loading two 16-bit numbers (`num1` and `num2`) into the AX register.
  - The `add` instruction is used to add the two numbers.
  - The result is printed using a subroutine (`PrintNumber16`) that handles the conversion of the 16-bit number into ASCII characters for display.
  - The program ends by printing a newline and exiting gracefully with DOS interrupt `int 21h, ah=4Ch`.

#### Subroutines
- **PrintNumber16:** Converts the 16-bit number in the AX register to ASCII and prints it to the screen. It uses a stack-based approach to print each digit from most significant to least significant.

### Program 2: 8-bit Addition and Display in Hexadecimal

#### Files
- **Program 2:**
  ```assembly
  org 100h

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
  ```

#### Description
- **Objective:** Add two 8-bit hexadecimal numbers and print the result in hexadecimal format.
- **Instructions:**
  - The program loads two 8-bit numbers (`num1` and `num2`) into the AL register and adds them.
  - The result is stored in the BL register.
  - The program then converts the high and low nibbles of the result into their respective ASCII characters.
  - The program handles cases where the nibble value is greater than 9, ensuring that the correct hexadecimal characters are printed.
  - The result is printed as a two-digit hexadecimal number.

#### Output
- **Program 1:** Outputs a decimal result of the addition.
  ![image](https://github.com/user-attachments/assets/914a229e-15c7-4970-8846-c3fa63932a72)

- **Program 2:** Outputs a two-digit hexadecimal result of the addition.
![image](https://github.com/user-attachments/assets/a28c9d04-194f-48e3-a7e7-a33d11c406f0)


### Execution
- To run these programs, load them into the EMU8086 emulator and execute. The results will be displayed in the console.

### Notes
- Ensure that the data segment is properly set up if modifying the code.
- The programs use DOS interrupts, so they are intended to run in an environment that supports these (such as DOSBox or EMU8086).
