# ...
.globl factorial

.data
n: .word 8  # You can change this value to test different factorials

.text
main:
    la t0, n          # Load address of n into t0
    lw a0, 0(t0)      # Load value of n into a0
    jal ra, factorial # Call the factorial function

    # Print the result
    addi a1, a0, 0
    addi a0, x0, 1
    ecall              # Print Result

    # Exit
    addi a0, x0, 10
    ecall              # Exit

factorial:
    beq  a0, x0, return1   # Base case: if a0=0, return 1
    beq  a0, x0, return1   # Base case: if a0=1, return 1

    addi t3, x0, 1         # Initialize fact = 1

loop:
    slti t2, a0, 2         # Check if a0 is less than 2
    bne  t2, x0, done      # If t2 != 0, branch to done

    mul  t3, t3, a0        # Multiply fact by a0
    addi a0, a0, -1        # Decrement a0
    j    loop              # Jump back to loop

return1:
    addi a0, x0, 1         # Return 1
    jr   ra

done:
    addi a0, t3, 0         # Return fact
    jr   ra
