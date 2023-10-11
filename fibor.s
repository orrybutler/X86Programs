.global fibonacci
.text

fibonacci:
	#set up the stack frame
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx #push ebx register onto the stack frame
	subl $4, %esp #allocate space on the stack frame
	#check if input is less than zero if it is jump to input error
	cmpl $0, 8(%ebp) 
    js input_error
	#check if n is greater than 1 if so jump to recursion if no load n into eax and output
	cmpl $1, 8(%ebp)
	jg	recursion
	#check if n is equal to zero go to f0 if so
	cmpl $0, 8(%ebp)
	je f0
	#check if n is equal to one go to f1 if so
	cmpl $1, 8(%ebp)
	je f1
recursion:
	#mov n into the eax register and decrement by 1 to get n - 1
	movl 8(%ebp), %eax
	subl $1, %eax
	subl $4, %esp #allocate space on the stack frame
	pushl %eax #push eax register onto the stack frame
	call fibonacci #callculate fibonacci(n - 1)
	addl $4, %esp #reset the stack frame
	movl %eax, %ebx #move the eax register into storage at ebx storing fibonacci(n - 1)
	movl 8(%ebp), %eax #move n value stored on the stack frame into the eax register
	subl $2, %eax #subtract 2 from n getting n - 2 
	subl $4, %esp #allocate space on the stack frame
	pushl %eax #push value stored in eax onto the stack frame
	call fibonacci #calulate fibonacci(n - 2)
	addl $4, %esp #reset the stack frame
	addl %ebx, %eax #add the two registers and get fibonacci(n - 1) + fibonacci(n - 2) in the eax register
	jo overflow_error #if addition overflows jump to overflow error
output:
	#fix the stack frame and output what is stored in eax
	movl -4(%ebp), %ebx
	leave
	ret
overflow_error:
	#if input error set eax to -1 and jump up to output
	movl $-1, %eax
	jmp output
input_error:
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
