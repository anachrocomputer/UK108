
AS=m68k-linux-gnu-as
ASFLAGS=-M

LD=m68k-linux-gnu-ld
LDFLAGS=-T m68k.ld

OBJCOPY=m68k-linux-gnu-objcopy

test.hex: test.elf
	$(OBJCOPY) -j .vectors -j .text -j .data -O srec test.elf test.hex

test.elf: test.o m68k.ld
	$(LD) $(LDFLAGS) test.o -o test.elf -Map test.map

test.o: test.asm
	$(AS) $(ASFLAGS) test.asm -a=test.lst -o test.o
