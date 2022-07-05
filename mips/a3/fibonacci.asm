.data
msg1:			.asciiz "Enter value n: "
msg2:			.asciiz "Calculated value: "
msg_error:   	.asciiz "Error"

.text

.globl main

main:
    la      $a0,        msg1                    # print
    li      $v0,        4
    syscall 

    li      $v0,        5                       # read in value and store in a0
    syscall 
    move    $a0,        $v0

    ble     $v0,        $zero,      error       # goto error if number<0

    jal     fib                                 # methodenaufruf

    la      $a0,        msg2                    # print
    li      $v0,        4
    syscall 

    move    $a0,        $v1                     # return result
    li      $v0,        1
    syscall 

    j       exit                                # exit program

fib:
    move    $t0,        $zero                   # init prevprevnum
    move    $t1,        $zero                   # init prevnum
    li      $t2,        1                       # init curr
    move    $t3,        $v0                     # init nthnum
    li      $t4,        1                       # i=1


forloop:
    beq     $t4,        $t3,        exitloop    # vergleichen, ob wir noch in die schleife gehen wollen

    move    $t0,        $t1                     # prevnum = prevprevnum
    move    $t1,        $t2                     # prev = curr
    add     $t2,        $t1,        $t0         # add

    addi    $t4,        $t4,        1           # i++, addi wegen konstanter 1, add addiert nur register

    j       forloop


exitloop:
    move    $v1,        $t2                     # store result in v1
    jr      $ra

error:
    li      $v0,        4
    la      $a0,        msg_error
    syscall 

exit:
    li      $v0,        10                      # exit
    syscall 


