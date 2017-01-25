; test --- try to figure out the MRI 68k assembler syntax

INITSTACK       equ     $ffffff
VDU             equ     $00D000

                section .vectors,,D
                name    vectors
                ttl     Vectors

                dc.l    INITSTACK         ; Initial stack pointer
                dc.l    RESET
;               ds.l    $100-2
                dcb.l   $100-2,$ffffff

;               chip    68000

                section .text,,C
                ttl     Program text

RESET           nop   
                move.b  #42,d0
                move.l  #42,d1
                jsr     clrscrn
                bsr     clrscrn
                halt

                section .data,,D
                
                dc.b    'Hello, world',0
                dc.b    'FART'

                align   2
                
                section .text,,C

clrscrn         move.l  #VDU,a0
                move.w  #VDU,a0
                lea     VDU,a0
                move.w  #$200,d0
clr1            move.w  #$2020,(a0)+
                dbeq    d0,clr1
                rts

                end
