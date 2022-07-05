# include "asm_regnames.h"

.data

text_greeting:  .asciiz "This program calculates the fiboacci sequence for a given positive integer. "
text_input:     .asciiz "Insert integer: "
text_result:    .asciiz "The calculated fibonacci value for the given integer is: "

.text
.globl entry

# DONE | fibonacci rekursiv

fibonacci:

    addi    t0,         $0,     2
    blt     a0,         t0,     basecase    # wenn a < 2

# Rekursions Spaß

    addiu   sp,         sp,     -12         # move stackpointer for saving words
    sw      ra,         0(sp)               # return address
    sw      s0,         4(sp)
    sw      s1,         8(sp)

    move    s0,         a0
    addi    a0,         s0,     -1          # t1 = fibonacci(a0 - 1)
    jal     fibonacci
    move    s1,         v0

    addi    a0,         s0,     -2          # t2 = fibonacci(a0 - 2)
    jal     fibonacci

    add     v0,         s1,     v0          # v0 = t1 + t2

    lw      s1,         8(sp)
    lw      s0,         4(sp)
    lw      ra,         0(sp)
    addiu   sp,         sp,     12

    jr      ra

basecase:
    move    v0,         a0
    jr      ra                              # jump back to where we came from


entry:
    lui     $4, %hi(text_greeting)
    ori     $4, %lo(text_greeting)
    jal     writestring
    lui     $4, %hi(text_input)
    ori     $4, %lo(text_input)
    jal     writestring
    jal     readdec                         # methodenaufruf zum einlesen der ersten zahl
    move    a0,         v0                  # zahl wird in das register reingeschrieben

    jal     fibonacci


    lui     $4, %hi(text_result)
    ori     $4, %lo(text_result)
    jal     writestring
    move    a0,         v0
    jal     writedec

