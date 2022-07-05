# include "asm_regnames.h"

.data

text_1:         .asciiz "Insert first decimal: "
text_2:         .asciiz "Insert second decimal: "
text_result:    .asciiz "Result is: "

.text
.globl entry

# Excercise: euklides algorithm (gcd)
# Calculate the greatest common divider of the integers x and y
# Input: Integer x, Integer y
# Result: z = gcd(x,y)

#

#    Bsp Ausführung: Aufruf (10, 8)
#
#    1) s0 = 10, s1 = 8
#    2) beq s1 0 : false
#    3) bgt s0 s1 (10, 8): true -> sprung auf loopif
#    4) subu s0 s0 s1 : subu s0 = (s0 - s1) = s0 = (10 -8)
#    5) s0 = 2, s1 = 8
#    6) jump loop
#    7) beq s1 $0 done : false
#    8) bgt s0 s1 loopfif : bgt 2 8 loopif : false 
#    9) subu s1 s1 s0 : subu s1 = (s1 - s0) => s1 = (8 - 2) = 6
#    10) s0 = 2, s1 = 6
#    11) jump loop
#    12) beq s1 $0 done : false
#    13) ...


entry:  
        lui     $4, %hi(text_1)
        ori     $4, %lo(text_1)
        jal     writestring
        jal     readdec             # Read first decimal from cmd line
        move    s0, v0              # Move entered decimal from v0 to s0
        lui     $4, %hi(text_2)
        ori     $4, %lo(text_2)
        jal     writestring
        jal     readdec             # Read second decimal from cmd line
        move    s1, v0              # Move entered decimal from v0 to s1
main:   beq     s1, $0, end         # Branch if equal: branch/jump to end if register s1 equals $0 (= 0)
        bgt     s0, s1, sub         # Branch if greater than: branch/jump to sub if s0 is greater than s1, else continue
        subu    s1, s1, s0          # Subtract unsigned: Save the result of the subtraction (s1 - s0) into s1
        j       main                # Jump: Jump back into main loop
sub:    subu    s0, s0, s1          # Subtract unsigned: Save the result of the calculation (s0 - s1) into s0
        j       main                # Jump back into main loop
end:    lui     $4, %hi(text_result)
        ori     $4, %lo(text_result)
        jal     writestring
        move    a0, s0              # Move: move s0 into a0
        jal     writedec            # Write decimal inside a0 to cmd line