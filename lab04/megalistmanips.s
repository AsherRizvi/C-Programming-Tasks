# Declare global symbols
.globl map

# Data section
.data
arrays: .word 5, 6, 7, 8, 9
        .word 1, 2, 3, 4, 7
        .word 5, 2, 7, 4, 3
        .word 1, 6, 3, 8, 4
        .word 5, 2, 7, 8, 1

start_msg:  .asciiz "Lists before: \n"
end_msg:    .asciiz "Lists after: \n"

# Text section
.text
main:
    # Call create_default_list function to create a default linked list
    jal create_default_list
    mv s0, a0   # Save the head of the node list in s0

    # Print "Lists before: "
    la a1, start_msg
    li a0, 4
    ecall

    # Print the list
    add a0, s0, x0
    jal print_list

    # Print a newline
    jal print_newline

    # Call the map function
    add a0, s0, x0
    la  a1, mystery
    jal map

    # Print "Lists after: "
    la a1, end_msg
    li a0, 4
    ecall

    # Print the updated list
    add a0, s0, x0
    jal print_list

    # Exit program
    li a0, 10
    ecall

# Map function to apply a function to each element of the linked list
map:
    # Prologue
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s1, 4(sp)
    sw s0, 8(sp)

    beq a0, x0, done    # Base case: if a0 is null, exit

    add s0, a0, x0      # Save address of current node in s0
    add s1, a1, x0      # Save address of function in s1
    add t0, x0, x0      # Counter


    # also keep in mind that we should not make ANY assumption on which registers
    # are modified by the callees, even when we know the content inside the functions 
    # we call. this is to enforce the abstraction barrier of calling convention.
mapLoop:
    # (FOURTH ERROR: Load the array's address into t1)
    lw t1, 0(s0)        # load the address of the array of current node into t1 
    lw t2, 4(s0)        # load the size of the node's array into t2
    
    # (SECOND ERROR: t0 * 4 is the real offset in address.)
    slli t3, t0, 2      
    add t1, t1, t3      # offset the array address by the count
    lw a0, 0(t1)        # load the value at that address into a0

    # (LAST ERROR: Store the value of the temporary registers!)
    addi sp, sp, -12
    sw t0, 0(sp)
    sw t1, 4(sp)
    sw t2, 8(sp)

    jalr s1             # call the function on that value.

    lw t0, 0(sp)
    lw t1, 4(sp)
    lw t2, 8(sp)
    addi sp, sp, 12     
    # Store the returned value back into the array
    sw a0, 0(t1)

    addi t0, t0, 1      # Increment the count
    bne t0, t2, mapLoop # Repeat if we haven't reached the array size yet

    lw a0, 8(s0)        # Load the address of the next node into a0
    mv a1, s1           # Restore the address of the function into a1 to prepare for recursion
    jal  map            # Recurse

done:
    # Epilogue
    lw s0, 8(sp)
    lw s1, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 12
    jr ra

# Sample function to apply to each element of the linked list
mystery:
    mul t1, a0, a0
    add a0, t1, a0
    jr ra

# Function to create a default linked list
create_default_list:
    addi sp, sp, -4
    sw ra, 0(sp)
    li s0, 0  # Pointer to the last node handled
    li s1, 0  # Number of nodes handled
    li s2, 5  # Size of each node's array
    la s3, arrays

loop:
    li a0, 12
    jal malloc      # Allocate memory for the next node
    mv s4, a0
    li a0, 20
    jal malloc      # Allocate memory for this node's array

    sw a0, 0(s4)    # Set node->arr = malloc
    lw a0, 0(s4)
    mv a1, s3
    jal fillArray   # Copy integers over to node->arr

    sw s2, 4(s4)    # Set node->size = size
    sw  s0, 8(s4)   # Set node->next = previously created node

    add s0, x0, s4  # Update last to point to the current node
    addi s1, s1, 1  # Increment nodes handled
    addi s3, s3, 20 # Point to the next set of integers

    li t6 5
    bne s1, t6, loop # Continue until all nodes are handled

    mv a0, s4
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

# Helper function to fill the array of a node with integers
fillArray:
    lw t0, 0(a1) # t0 gets array element
    sw t0, 0(a0) # node->arr gets array element
    lw t0, 4(a1)
    sw t0, 4(a0)
    lw t0, 8(a1)
    sw t0, 8(a0)
    lw t0, 12(a1)
    sw t0, 12(a0)
    lw t0, 16(a1)
    sw t0, 16(a0)
    jr ra

# Function to print the linked list
print_list:
    bne a0, x0, printMeAndRecurse
    jr ra   # Nothing to print

printMeAndRecurse:
    mv t0, a0           # t0 gets the address of the current node
    lw t3, 0(a0)        # t3 gets the array of the current node
    li t1, 0            # t1 is index into array

printLoop:
    slli t2, t1, 2
    add t4, t3, t2
    lw a1, 0(t4)        # a0 gets value in current node's array at index t1
    li a0, 1            # Prepare for print integer ecall
    ecall
    li a1, ' '          # a0 gets address of string containing space
    li a0, 11           # Prepare for print string ecall
    ecall
    addi t1, t1, 1
    li t6 5
    bne t1, t6, printLoop   # Continue while i != 5

    li a1, '\n'         # Print newline character
    li a0, 11
    ecall

    lw a0, 8(t0)        # a0 gets address of next node
    j print_list        # Recurse

# Function to print a newline
print_newline:
    li a1, '\n'
    li a0, 11
    ecall
    jr ra

# Function to allocate memory
malloc:
    mv a1, a0           # Move a0 into a1 so that we can do the syscall correctly
    li a0, 9
    ecall
    jr ra
