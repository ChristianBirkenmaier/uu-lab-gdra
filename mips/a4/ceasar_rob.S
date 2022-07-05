# include "asm_regnames.h"
.text
.globl entry

# DONE | Caesar Verschlüsselung

# AsciiWerte: A:65  Z:90  a:97  z:122

# caesar helper
wenn:
    li      t0,             65                      # Ascii code für A     # if( 'A' <= c AND c <= 'Z' then a0 ist übergebenes Zeichen
    blt     a0,             t0,     wenn_sonst
    li      t0,             90                      # Ascii code für Z
    bgt     a0,             t0,     wenn_sonst

    addi    a0,             a0,     -65             # c -= 'a'
    add     a0,             a0,     s0              # c + d
    li      t1,             26                      # c %= 26
    div     a0,             t1
    mfhi    a0                                      # hi-Feld vom Ergebnis auslesen; -> ist der Modulo der Division
    addi    a0,             a0,     65              # c += 'a'

    j       sonst

# Kleinbuchstaben
wenn_sonst:
    li      t0,             97                      # a
    blt     a0,             t0,     sonst
    li      t0,             122                     # z
    bgt     a0,             t0,     sonst

    addi    a0,             a0,     -97             # c -= 'a'
    add     a0,             a0,     s0              # c + d
    li      t1,             26
    div     a0,             t1
    mfhi    a0
    addi    a0,             a0,     97

    j       sonst

# Sonderzeichen #,?...
sonst:
    move    v0,             a0                      # ergebnis im Ergebnis-Register v0 speichern
    jr      ra                                      # rückgabe von der Funktion


schleife:
    lb      a0,             0(s2)                   # load word; nächstes Zeichen des Strings in a0 speichern
    beq     a0,             zero,   schleife_end    # schauen ob wir am Ende des Strings angekommen sind

    move    s3,             ra                      # zwischenspeichern der ReturnAdress
    jal     wenn                                    # Aufrufen des Schleifeninhalts
    move    ra,             s3

    sb      v0,             0(s2)                   # verschobenes Zeichen über altes Zeichen in Stack speichern

    addi    s2,             s2,     1               # eine Stelle im String weitergehen
    j       schleife                                # schleife wieder aufrufen

schleife_end:
    jr      ra


entry:

    move    $4,             sp                      # reading the string into the stack
    jal     readline                                # schreibt an den Anfang vom Stack (an die stelle von sp)

    li      s0,             1                       # festlegen der Konstante d

caesar_loop:

    move    s2,             sp                      # moving pointer in the stack

    jal     schleife

    addi    s0,             s0,     1               # increment s0

    li      t0,             7
    blt     s0,             t0,     caesar_loop

    li      s0,             -2
    move    s2,             sp
    jal     schleife
    li      s0,             13
    move    s2,             sp
    jal     schleife
    li      s0,             13
    move    s2,             sp
    jal     schleife

# printing the string
    move    $4,             sp
    jal     writestring
