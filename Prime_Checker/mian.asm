.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
Include Irvine32.inc

.data
 ; Memory Declaration

 input_message db "[]=> Enter a number: ", 0
 prime_message db "[+] The number is prime.", 0
 not_prime_message db "[+] The number is not prime.", 0

.code
main PROC
; Main Code
    ; Print the input message
    mov edx, OFFSET input_message
    call WriteString

    ; Read the input number
    call ReadInt
    ; EAX now contains the input number

    ; Check if the number is less than or equal to 1
    cmp eax, 1
    jle not_prime

    ; Check if the number is 2
    cmp eax, 2
    je is_prime

    ; Check if the number is even
    test eax, 1
    jz not_prime

    ; Initialize counter in the ECX register
    mov ecx, 3

check_divisor:
    ; Check if the counter is greater than the square root of the number
    mov edx, ecx
    imul edx, edx
    cmp edx, eax
    jg is_prime

    ; Check if the number is divisible by the counter
    xor edx, edx
    idiv ecx
    cmp edx, 0
    je not_prime

    ; Increment the counter by 2
    add ecx, 2
    jmp check_divisor

is_prime:
    ; Print the prime message
    mov edx, OFFSET prime_message
    call WriteString
    jmp exit_kerdo

not_prime:
    ; Print the not prime message
    mov edx, OFFSET not_prime_message
    call WriteString

exit_kerdo:

INVOKE ExitProcess, 0
main ENDP
END main