.import lotsofaccumulators.s

.data
inputarray: .word 1,2,3,4,5,6,7,0   
inputarray1: .word 0

TestPassed: .asciiz " Accumulator Test Passed "
TestFailed: .asciiz " Accumulator Test Failed "

FunctionOne: .asciiz "accumulatorone test has been:"
FunctionTwo: .asciiz "accumulatortwo test has been:"
FunctionThree: .asciiz "accumulatorthree test has been:"
FunctionFour: .asciiz "accumulatorfour test has been:"
FunctionFive: .asciiz "accumulatorfive test has been:"

.text

main: # PLEASE UNCOMMENT THE TEST THAT YOU WANT TO VERIFY 

    # # *** TEST 1 For accumulatorone function  *** 

    # # Test accumulatorone
     la a0, FunctionOne
     jal print_string
     la t1, accumulatorone
     mv a1, t1
     li s0, 1
     jal test_accumulator
     jal newline

    # *** TEST 2 For accumulatortwo function  *** 

    # # Test accumulatortwo
     #la a0, FunctionTwo
     #jal print_string
     #la t1, accumulatortwo
     #mv a1, t1
     #jal test_accumulator_with_stack
     #jal newline

    # *** TEST 3 For accumulatorthree function  *** 

    ## Test accumulatorthree
     #la a0, FunctionThree
     #jal print_string
     #la t1, accumulatorthree
     #mv a1, t1
     #jal test_accumulator                        # you can use test_accumulator_with_stack also
     #jal newline

    # *** TEST 4 For accumulatortfour function  *** 

    # # Test accumulatorfour
    #la a0, FunctionFour
     #jal print_string
     #la t1, accumulatorfour
     #mv a1, t1
     #li t2, 3
     #jal test_accumulator
     #jal newline

    # *** TEST 5 For accumulatortfive function  *** 

    # Test accumulatorfive
   # la a0, FunctionFive
    #jal print_string
    #la t1, accumulatorfive
    #mv a1, t1
    #la a0, inputarray1
    #jalr a1
    #li t0, 0
    #bne a0, t0, fail
 

pass:
    la a0, TestPassed
    jal print_string
    j end
fail:
    la a0, TestFailed
    jal print_string
end:
    jal newline
    jal exit

test_accumulator:
    li s0,10            # any random value 
    addi sp, sp, -12
    sw ra, 8(sp)
    sw a1, 4(sp)
    sw s0, 0(sp)
    la a0, inputarray
    jalr a1

    li t0, 10           # loading 10 to t0 to check that s0 was preserved on stack before using or not
    bne t0,s0,fail

    li t0, 28
    beq a0, t0, pass
    j fail
end_test:
    lw s0, 0(sp)
    lw a1, 4(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    jr ra

test_accumulator_with_stack: # Test for the accumulatortwo func
    li s0, 40           # random value 
    li t3, 99
    addi sp, sp, -20
    sw ra, 16(sp)
    sw a1, 12(sp)
    sw s0, 8(sp)
    sw t3, 4(sp)

    la a0, inputarray
    jalr a1             # goes to the accumulatortwo func
    
    lw ra, 16(sp)
    lw a1, 12(sp)
    lw s0, 8(sp)
    lw t3, 4(sp)
    addi sp, sp, 20
    
    li t1, 40
    bne s0, t1, fail
    li t2, 99
    bne t3, t2, fail
    li t0, 28
    bne a0, t0, fail
    j pass

print_int:
    mv a1, a0
    li a0, 1
    ecall
    jr ra

print_string:
    mv a1, a0
    li a0, 4
    ecall
    jr ra

newline:
    li a0, 11
    ecall
exit:
    li a0, 10
    ecall
