SECTIONS { 
  .vectors 0x00000000 : { *(.vectors) }
  .text : { *(.text) }
  .data : { *(.data) } 
  .bss :  { *(.bss)  *(COMMON) } 
}
