# UK108

Software to run on a 68008 chip, adapted to fit a Compukit UK101.

The UK101 is a 6502-based machine first seen in 1979 as a series of
articles in _Practical Electronics_ magazine.

## The Freerun EPROM

The file 'test.asm' is for use with a freerun rig comprising a 68008
chip and an EPROM.
With no RAM or I/O, we can't do much.
But we can observe the bus signals and timing using an oscilloscope
and/or a logic analyser.
The code in this file is intended to explore instruction timing when
the /DTACK signal of the 68008 is grounded.

## The 68008 Adapter

TBD
