# include "asm_regnames.h"

.data

text:   .asciiz "This program takes two decimals and adds them together."
text_1: .asciiz "Insert first decimal: "
text_2: .asciiz "Insert second decimal: "
result: .asciiz "Result is: "


.text
.globl entry

# Excercise: Calculate the sum of the decimals x, y
# Input: Decimal x, Decimal y
# Output: Result (x + y)



entry:  lui     $4, %hi(text)           # 
        ori     $4, %lo(text)           #
        jal     writestring             # Output of text text
        lui     $4, %hi(text_1)         #
        ori     $4, %lo(text_1)         #
        jal     writestring             # Output of text text_1
        jal     readdec                 # call of precedure to read decimal
        move    s0,         v0          # move decimal from input registry v0 into registry s0
        lui     $4, %hi(text_2)         #
        ori     $4, %lo(text_2)         #
        jal     writestring             # output of text text_2
        jal     readdec                 # call of precedure to read decimal
        move    s1,         v0          # move decimal from input registry v0 into registry s1
        lui     $4, %hi(result)         #
        ori     $4, %lo(result)         #
        jal     writestring             # output of text result
        add     a0,         s0, s1      # add the two decimals inside s0 and s1 and save the result into a0
        jal     writedec                # call to precedure to write the decimal inside a0 to the command line