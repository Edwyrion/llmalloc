.file "irqhandlers.s"

.syntax unified
.cpu cortex-m4
.arch armv7e-m
.fpu fpv4-sp-d16
.thumb

.section .text.interrupts, "ax", %progbits

.global Reset_Handler
.global HardFault_Handler

.global Default_Handler

.thumb_func
.type Reset_Handler, %function
@ reset entry point
Reset_Handler:

    @ set stack pointer to the end of RAM
    ldr sp, =__stack_end__

    @ get addresses of RAM memory
    ldr r0, =__sram_start__
    ldr r1, =__stack_end__
    mov r2, #0

    @ clear RAM (optional)
    sram_loop:
        cmp     r0, r1
        strlt   r2, [r0], #4
        blt     sram_loop

    @ Fill stack memory with predefined pattern
    ldr r0, =_sstack
    mvn r2, #0x0

    stack_loop:
        cmp     r0, r1
        strlt   r2, [r0], #4
        blt     stack_loop

    @ get address of .data section in FLASH
    ldr r0, =__text_end__
    ldr r1, =__data_start__
    ldr r2, =__data_end__

    @ copy .data section from FLASH to RAM
    data_loop:
        cmp     r1, r2
        ldrlt   r3, [r0], #4
        strlt   r3, [r1], #4
        blt     data_loop

    @ get address of .bss section in RAM
    mov r0, #0
    ldr r1, =__bss_start__
    ldr r2, =__bss_end__

    @ zero .bss section
    bss_loop:
        cmp     r1, r2
        strlt   r0, [r1], #4
        blt     bss_loop

    @ call main entry point of the program
    bl main

    @ infinite loop, should never reach this point
    b .

.size Reset_Handler, . - Reset_Handler

.type HardFault_Handler, %function
HardFault_Handler:

    @ Get the appropriate stack pointer, depending on the current mode
    tst lr, #4
    mrseq r0, MSP
    mrsne r0, PSP

    @ Get the location of the stack frame
    ldr r1, [r0, #24]

    bkpt #0
.size HardFault_Handler, . - HardFault_Handler

.type Default_Handler, %function
@ default interrupt handler
Default_Handler:
    b Default_Handler
.size Default_Handler, . - Default_Handler

.end
