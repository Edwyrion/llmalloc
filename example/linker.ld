MEMORY {
    ROM (rx)   : ORIGIN = 0x08000000, LENGTH = 64K
    RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 16K
}

/* Define the stack size */
_stack_size = DEFINED(_stack_size) ? _stack_size : (2 * 1024);

__sram_start__ = ORIGIN(RAM);
__stack_end__ = ORIGIN(RAM) + LENGTH(RAM);
PROVIDE(_sstack = __stack_end__ - _stack_size);

SECTIONS {
    /* ISR and code section */
    .text :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector))
        *(.text .text*)
        . = ALIGN(4);
        __text_end__ = .;
    } > ROM

    /* Read-only data section */
    .rodata :
    {
        . = ALIGN(4);
        __rodata_start__ = .;
        *(.rodata .rodata*)
        . = ALIGN(4);
        __rodata_end__ = .;
    } > ROM

    /* Initialized data section */
    .data :
    {
        . = ALIGN(4);
        __data_start__ = .;
        *(.data .data*)
        . = ALIGN(4);
        __data_end__ = .;
    } > RAM AT> ROM

    /* Uninitialized data section */
    .bss :
    {
        . = ALIGN(4);
        __bss_start__ = .;
        *(COMMON)
        *(.bss .bss*)
        . = ALIGN(4);
        __bss_end__ = .;
    } > RAM

    /* Discard unused sections */
    /DISCARD/ : 
    {
        *(.note.*)
        *(.comment)
    }
}