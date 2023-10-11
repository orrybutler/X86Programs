.globl fibonacci
.text
fibonacci:
    #set up the stack fram
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp
    #check if input is less than zero if so jump to input error
    cmpl $0, 8(%ebp)
    js input_error
    #check if input is zero then jump to f0 to set the fibonacci number to zero
    cmpl $0, 8(%ebp)
    je f0
    #check if input is 1 if so jump to f1 to set fibonacci number to 1
    cmpl $1, 8(%ebp)
    je f1
    movl 8(%ebp), %ecx #set ecx register equal to the inputed value
    movl $0, %edx #%set edx register equal to 0
    movl $1, %eax #%set eax register equal to 1
add_numbers:
    movl %eax, -4(%ebp) #move eax into a temporary stoarge location
    addl %edx, %eax #add the two fibonnaci numbers together
    jo overflow_error #when addition overflows go to overflow error
    movl -4(%ebp), %edx #set the edx register equal to the value in the temporary storage location
    #iterate until the counter is equal to 1
    decl %ecx
    cmpl $1, %ecx
    jne add_numbers
output:
    #fix the stack frame and then return value stored in eax or the fibonacci number
    leave 
    ret
input_error:
    #if input error set eax to -1 and jump up to output
    movl $-1, %eax
    jmp output
overflow_error:
    #if overflow error set eax to -1 and jump up to output
    movl $-1, %eax
    jmp output
f0:
    #set eax to 0 for the zero fibonacci number
    movl $0, %eax
    jmp output
f1:
    #set eax to 1 for the first fibonacci number
    movl $1, %eax
    jmp output