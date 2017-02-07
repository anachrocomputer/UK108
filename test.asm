; test --- test EPROM for free-running 68008 chip              2017-01-24
; Copyright (c) 2017 John Honniball

                name    test.asm

INITSTACK       equ     $ffffffff
EMPTYVEC        equ     $ffffffff

VDU             equ     $00D000

                section .vectors,,D
                ttl     Vectors

STACKVEC        dc.l    INITSTACK         ; Initial stack pointer
RESETVEC        dc.l    RESET
BUSERRVEC       dc.l    BUSERR
ADDRERRVEC      dc.l    ADDRERR
ILLEGALVEC      dc.l    ILLEGAL
                dcb.l   $100-5,EMPTYVEC

                section .text,,C
                ttl     Program text

RESET           nop                       ; Entry point at reset
                move.l  #42,d0            ; Initialise all the data registers
                move.l  d0,d1
                move.l  d1,d2
                move.l  d2,d3
                move.l  d3,d4
                move.l  d4,d5
                move.l  d5,d6
                move.l  d6,d7
                
                move.l  d7,a0             ; Cross over into the address registers

                move.l  a0,a1             ; And initialise all of them too
                move.l  a1,a2
                move.l  a2,a3
                move.l  a3,a4
                move.l  a4,a5
                move.l  a5,a6

                jmp     RESET.l           ; Loop back so that the analog
                                          ; oscilloscope can see the bus cycles

                jsr     clrscrn.w         ; JSR with 16-bit address
                jsr     clrscrn.l         ; JSR with 32-bit address
                bsr     clrscrn
                
                halt
                reset
                nop
                stop    #$2000
                rte
                rts
                trapv
                rtr
                
                swap    d0
                swap    d1
                swap    d2
                swap    d3
                exg     d0,d1
                exg     d1,d2
                exg     d2,d3
                exg     d3,d4
                exg     a0,d2

                section .data,,D
                
                dc.b    'Hello, world',0
                dc.b    'FART'
                ds.l    16

                align   2
                
                section .text,,C

initvectab      move.w  #255,d0           ; Loop counter
                move.l  #BUSERR,d1        ; D1 contains vector address
                move    #0,a0             ; A0->vector table
L001            move.l  d1,(a0)+
                dbra    d0,L001
                
clrscrn         move.l  #VDU,a0           ; Three different ways to do same thing
                move.w  #VDU,a0
                lea     VDU,a0
                move.l  #$20202020,d1     ; Four ASCII spaces
                move.w  #$ff,d0           ; Loop counter for 1k bytes
clr1            move.l  d1,(a0)+     
                dbra    d0,clr1
                rts

BUSERR          rte                       ; Ignore Bus Error for now
ADDRERR         rte                       ; Ignore Address Error for now
ILLEGAL         rte                       ; Ignore Illegal Instruction for now

                end
