.globl main

.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1
    sub t1, x0, a0
    mul a0, t0, t1
    jr ra

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0  # Initialize t0 (k) to 0
    addi s0, x0, 0  # Initialize s0 (sum) to 0
    la s1, source   # Load address of the source array into s1
    la s2, dest     # Load address of the dest array into s2
loop:
    slli s3, t0, 2   # Calculate the offset by shifting t0 left by 2 (multiply by 4 for word size)
    add t1, s1, s3   # Calculate the address of source[k]
    add t1, s1, s3
    add t3, s2, s3 
    lw t2, 0(t1)     # Load the value from source[k] into t2
    beq t2, x0, exit  # Exit the loop if t2 (source[k]) is 0
    add a0, x0, t2
    addi sp, sp, -8
    sw t0, 0(sp)
    sw t2, 4(sp)
    jal fun
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8
    add t2, x0, a0
    add t3, s2, s3   # Calculate the address of dest[k]
    sw t2, 0(t3)
    add s0, s0, t2     # Add the result of fun(source[k]) to s0
    addi t0, t0, 1     # Increment t0 (k) by 1
    jal x0, loop       # Jump back to the loop label
exit:
    add a0, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra