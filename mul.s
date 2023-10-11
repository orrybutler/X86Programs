.globl multiply
.text

multiply:
    #set up the stack frame
	pushl %ebp
	movl %esp, %ebp
    subl $4, %esp #decrease stack frame for storage at -4(%ebp)
	movl 8(%ebp), %edx #put the second value passed in into the edx register
    movl  12(%ebp), %ecx #put the first value passed in into the ecx register
    movl %ecx, -4(%ebp) #put value stored in %ecx into storage at -4(%ebp) on the stack frame
    #set up counter for all 32 bits and output value
    movl $0, %eax
    movl $32, -4(%ebp)
    cmpl $0, %edx
    jns first_positive
    notl %edx
    addl $1, %edx
first_positive:
    cmpl $0, %ecx
    jns loop
    notl %ecx
    addl $1, %ecx
loop:
    #shift the edx register right into carry if carry is set or the zero bit is 1 skip if 0 jump shift left
    shr $1, %edx
    jnc shift_left
    #add the shifted value to the eax register
    addl %ecx, %eax
    # check for overflow if overflow jump to overflow error
    jo overflow_error
shift_left:
    shl $1, %ecx # shift the first value left into carry
    #dec counter for each shift iterate until counter equals to zero
    decl -4(%ebp)
    cmpl $0, -4(%ebp)
    jne loop
    cmpl $0, 8(%ebp)
    jns fix_negative1
    cmpl $0, 12(%ebp)
    jns fix_negative2
output:
    #fix the stack frame and output value stored in eax register
    leave
    ret
overflow_error:
    #when overlow move -1 into eax register and jump to output to output -1
    movl $-1, %eax
    jmp output
fix_negative1:
    cmpl $0, 12(%ebp)
    jns output 
    notl %eax
    addl $1, %eax
    jmp output
fix_negative2:
    cmpl $0, 8(%ebp)
    jns output 
    notl %eax
    addl $1, %eax
    jmp output