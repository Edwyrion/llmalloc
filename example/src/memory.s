.file 0 "memory.s"

.syntax unified
.cpu cortex-m4
.arch armv7e-m
.fpu fpv4-sp-d16
.thumb

.section .isr_vector, "a", %progbits

@ Standard Cortex-M and STM32F302R8 specific interrupt vector table
.global vtable
vtable:
    .word __stack_end__
    .word Reset_Handler
    .word NMI_Handler
    .word HardFault_Handler
    .word MemManage_Handler
    .word BusFault_Handler
    .word UsageFault_Handler
    .fill 4, 4, 0
    .word SVC_Handler
    .fill 2, 4, 0
    .word PendSV_Handler
    .word SysTick_Handler
    .word WWDG_IRQHandler @ 0
    .word PVD_IRQHandler @ 1
    .word TAMP_STAMP_IRQHandler
    .word RTC_WKUP_IRQHandler
    .word FLASH_IRQHandler
    .word RCC_IRQHandler @ 5
    .word EXTI0_IRQHandler
    .word EXTI1_IRQHandler
    .word EXTI2_TS_IRQHandler 
    .word EXTI3_IRQHandler
    .word EXTI4_IRQHandler @ 10
    .word DMA1_Channel1_IRQHandler
    .word DMA1_Channel2_IRQHandler
    .word DMA1_Channel3_IRQHandler
    .word DMA1_Channel4_IRQHandler
    .word DMA1_Channel5_IRQHandler
    .word DMA1_Channel6_IRQHandler
    .word DMA1_Channel7_IRQHandler
    .word ADC1_2_IRQHandler @ 18
    .word CAN_TX_IRQHandler
    .word CAN_RX0_IRQHandler
    .word CAN_RX1_IRQHandler
    .word CAN_SCE_IRQHandler
    .word EXTI9_5_IRQHandler
    .word TIM1_BRK_TIM15_IRQHandler
    .word TIM1_UP_TIM16_IRQHandler
    .word TIM1_TRG_COM_TIM17_IRQHandler
    .word TIM1_CC_IRQHandler
    .word TIM2_IRQHandler @ 28
    .fill 2, 4, 0
    .word I2C1_EV_IRQHandler @ 31
    .word I2C1_ER_IRQHandler
    .word I2C2_EV_IRQHandler
    .word I2C2_ER_IRQHandler @ 34
    .fill 1, 4, 0
    .word SPI2_IRQHandler @ 36
    .word USART1_IRQHandler
    .word USART2_IRQHandler
    .word USART3_IRQHandler
    .word EXTI15_10_IRQHandler @ 40
    .word RTC_Alarm_IRQHandler
    .word USBWakeUp_IRQHandler @ 42
    .fill 8, 4, 0
    .word SPI3_IRQHandler @ 51
    .fill 2, 4, 0
    .word TIM6_DAC_IRQHandler @ 54
    .fill 9, 4, 0
    .word COMP2_IRQHandler
    .word COMP4_6_IRQHandler @ 65
    .fill 16, 4, 0
.size vtable, . - vtable

.section .weakdefs

@ Default interrupt handlers
.macro set_default_handler handler_name:req
    .weak \handler_name
    .thumb_set \handler_name, Default_Handler
.endm

@ Interrupt handlers that are not yet implemented default to the Default_Handler
set_default_handler NMI_Handler
set_default_handler HardFault_Handler
set_default_handler MemManage_Handler
set_default_handler BusFault_Handler
set_default_handler UsageFault_Handler
set_default_handler SVC_Handler
set_default_handler DebugMon_Handler
set_default_handler PendSV_Handler
set_default_handler SysTick_Handler
set_default_handler WWDG_IRQHandler
set_default_handler PVD_IRQHandler
set_default_handler TAMP_STAMP_IRQHandler
set_default_handler RTC_WKUP_IRQHandler
set_default_handler FLASH_IRQHandler
set_default_handler RCC_IRQHandler
set_default_handler EXTI0_IRQHandler
set_default_handler EXTI1_IRQHandler
set_default_handler EXTI2_TS_IRQHandler
set_default_handler EXTI3_IRQHandler
set_default_handler EXTI4_IRQHandler
set_default_handler DMA1_Channel1_IRQHandler
set_default_handler DMA1_Channel2_IRQHandler
set_default_handler DMA1_Channel3_IRQHandler
set_default_handler DMA1_Channel4_IRQHandler
set_default_handler DMA1_Channel5_IRQHandler
set_default_handler DMA1_Channel6_IRQHandler
set_default_handler DMA1_Channel7_IRQHandler
set_default_handler ADC1_2_IRQHandler
set_default_handler CAN_TX_IRQHandler
set_default_handler CAN_RX0_IRQHandler
set_default_handler CAN_RX1_IRQHandler
set_default_handler CAN_SCE_IRQHandler
set_default_handler EXTI9_5_IRQHandler
set_default_handler TIM1_BRK_TIM15_IRQHandler
set_default_handler TIM1_UP_TIM16_IRQHandler
set_default_handler TIM1_TRG_COM_TIM17_IRQHandler
set_default_handler TIM1_CC_IRQHandler
set_default_handler TIM2_IRQHandler
set_default_handler I2C1_EV_IRQHandler
set_default_handler I2C1_ER_IRQHandler
set_default_handler I2C2_EV_IRQHandler
set_default_handler I2C2_ER_IRQHandler
set_default_handler SPI2_IRQHandler
set_default_handler USART1_IRQHandler
set_default_handler USART2_IRQHandler
set_default_handler USART3_IRQHandler
set_default_handler EXTI15_10_IRQHandler
set_default_handler RTC_Alarm_IRQHandler
set_default_handler USBWakeUp_IRQHandler
set_default_handler SPI3_IRQHandler
set_default_handler TIM6_DAC_IRQHandler
set_default_handler COMP2_IRQHandler
set_default_handler COMP4_6_IRQHandler

@ STM32F302R8 peripherals

.section .peripherals

@ Set memory macro
.macro define_register  reg:req, val:req
    .global \reg
    .equ \reg, \val
.endm

@ TIM2 memory layout

define_register TIM2_CR1,        0x40000000
define_register TIM2_CR2,        0x40000004
define_register TIM2_SMCR,       0x40000008
define_register TIM2_DIER,       0x4000000C
define_register TIM2_SR,         0x40000010
define_register TIM2_EGR,        0x40000014
define_register TIM2_CCMR1,      0x40000018
define_register TIM2_CCMR2,      0x4000001C
define_register TIM2_CCER,       0x40000020
define_register TIM2_CNT,        0x40000024
define_register TIM2_PSC,        0x40000028
define_register TIM2_ARR,        0x4000002C
define_register TIM2_CCR1,       0x40000034
define_register TIM2_CCR2,       0x40000038
define_register TIM2_CCR3,       0x4000003C
define_register TIM2_CCR4,       0x40000040
define_register TIM2_DCR,        0x40000048
define_register TIM2_DMAR,       0x4000004C

@ TIM6 memory layout

define_register TIM6_CR1,        0x40001000
define_register TIM6_CR2,        0x40001004
define_register TIM6_DIER,       0x4000100C
define_register TIM6_SR,         0x40001010
define_register TIM6_EGR,        0x40001014
define_register TIM6_CNT,        0x40001024
define_register TIM6_PSC,        0x40001028
define_register TIM6_ARR,        0x4000102C

@ RTC memory layout

define_register RTC_TR,          0x40002800
define_register RTC_DR,          0x40002804
define_register RTC_CR,          0x40002808
define_register RTC_ISR,         0x4000280C
define_register RTC_PRER,        0x40002810
define_register RTC_WUTR,        0x40002814
define_register RTC_ALRMAR,      0x4000281C
define_register RTC_ALRMBR,      0x40002820
define_register RTC_WPR,         0x40002824
define_register RTC_SSR,         0x40002828
define_register RTC_SHIFTR,      0x4000282C
define_register RTC_TSTR,        0x40002830
define_register RTC_TSDR,        0x40002834
define_register RTC_TSSSR,       0x40002838
define_register RTC_CALR,        0x4000283C
define_register RTC_TAFCR,       0x40002840
define_register RTC_ALRMASSR,    0x40002844
define_register RTC_ALRMBSSR,    0x40002848
define_register RTC_BKP0R,       0x40002850
define_register RTC_BKP1R,       0x40002854
define_register RTC_BKP2R,       0x40002858
define_register RTC_BKP3R,       0x4000285C
define_register RTC_BKP4R,       0x40002860
define_register RTC_BKP5R,       0x40002864
define_register RTC_BKP6R,       0x40002868
define_register RTC_BKP7R,       0x4000286C
define_register RTC_BKP8R,       0x40002870
define_register RTC_BKP9R,       0x40002874
define_register RTC_BKP10R,      0x40002878
define_register RTC_BKP11R,      0x4000287C
define_register RTC_BKP12R,      0x40002880
define_register RTC_BKP13R,      0x40002884
define_register RTC_BKP14R,      0x40002888
define_register RTC_BKP15R,      0x4000288C

@ WWDT memory layout

define_register WWDG_CR,         0x40002C00
define_register WWDG_CFR,        0x40002C04
define_register WWDG_SR,         0x40002C08

@ IWDG memory layout

define_register IWDG_KR,         0x40003000
define_register IWDG_PR,         0x40003004
define_register IWDG_RLR,        0x40003008
define_register IWDG_SR,         0x4000300C

@ USART2 memory layout

define_register USART2_CR1,      0x40004400
define_register USART2_CR2,      0x40004404
define_register USART2_CR3,      0x40004408
define_register USART2_BRR,      0x4000440C
define_register USART2_GTPR,     0x40004410
define_register USART2_RTOR,     0x40004414
define_register USART2_RQR,      0x40004418
define_register USART2_ISR,      0x4000441C
define_register USART2_ICR,      0x40004420
define_register USART2_RDR,      0x40004424
define_register USART2_TDR,      0x40004428

@ USART3 memory layout

define_register USART3_CR1,      0x40004800
define_register USART3_CR2,      0x40004804
define_register USART3_CR3,      0x40004808
define_register USART3_BRR,      0x4000480C
define_register USART3_GTPR,     0x40004810
define_register USART3_RTOR,     0x40004814
define_register USART3_RQR,      0x40004818
define_register USART3_ISR,      0x4000481C
define_register USART3_ICR,      0x40004820
define_register USART3_RDR,      0x40004824
define_register USART3_TDR,      0x40004828

@ I2C1 memory layout

define_register I2C1_CR1,        0x40005400
define_register I2C1_CR2,        0x40005404
define_register I2C1_OAR1,       0x40005408
define_register I2C1_OAR2,       0x4000540C
define_register I2C1_TIMINGR,    0x40005410
define_register I2C1_TIMEOUTR,   0x40005414
define_register I2C1_ISR,        0x40005418
define_register I2C1_ICR,        0x4000541C
define_register I2C1_PECR,       0x40005420
define_register I2C1_RXDR,       0x40005424
define_register I2C1_TXDR,       0x40005428

@ I2C2 memory layout

define_register I2C2_CR1,        0x40005800
define_register I2C2_CR2,        0x40005804
define_register I2C2_OAR1,       0x40005808
define_register I2C2_OAR2,       0x4000580C
define_register I2C2_TIMINGR,    0x40005810
define_register I2C2_TIMEOUTR,   0x40005814
define_register I2C2_ISR,        0x40005818
define_register I2C2_ICR,        0x4000581C
define_register I2C2_PECR,       0x40005820
define_register I2C2_RXDR,       0x40005824
define_register I2C2_TXDR,       0x40005828

@ PWR memory layout

define_register PWR_CR,          0x40007000
define_register PWR_CSR,         0x40007004

@ DAC1 memory layout

define_register DAC1_CR,         0x40007400
define_register DAC1_SWTRIGR,    0x40007404
define_register DAC1_DHR12R1,    0x40007408
define_register DAC1_DHR12L1,    0x4000740C
define_register DAC1_DHR8R1,     0x40007410
define_register DAC1_DHR12R2,    0x40007414
define_register DAC1_DHR12L2,    0x40007418
define_register DAC1_DHR8R2,     0x4000741C
define_register DAC1_DHR12RD,    0x40007420
define_register DAC1_DHR12LD,    0x40007424
define_register DAC1_DHR8RD,     0x40007428
define_register DAC1_DOR1,       0x4000742C
define_register DAC1_DOR2,       0x40007430
define_register DAC1_SR,         0x40007434

@ I2C3 memory layout

define_register I2C3_CR1,        0x40007800
define_register I2C3_CR2,        0x40007804
define_register I2C3_OAR1,       0x40007808
define_register I2C3_OAR2,       0x4000780C
define_register I2C3_TIMINGR,    0x40007810
define_register I2C3_TIMEOUTR,   0x40007814
define_register I2C3_ISR,        0x40007818
define_register I2C3_ICR,        0x4000781C
define_register I2C3_PECR,       0x40007820
define_register I2C3_RXDR,       0x40007824
define_register I2C3_TXDR,       0x40007828

@ SYSCFG memory layout

define_register SYSCFG_CFGR1,    0x40010000
define_register SYSCFG_EXTICR1,  0x40010008
define_register SYSCFG_EXTICR2,  0x4001000C
define_register SYSCFG_EXTICR3,  0x40010010
define_register SYSCFG_EXTICR4,  0x40010014
define_register SYSCFG_CFGR2,    0x40010018

@ COMP memory layout

define_register COMP1_CSR,       0x4001001C
define_register COMP2_CSR,       0x40010020
define_register COMP3_CSR,       0x40010024
define_register COMP4_CSR,       0x40010028
define_register COMP5_CSR,       0x4001002C
define_register COMP6_CSR,       0x40010030

@ OPAMP memory layout

define_register OPAMP1_CSR,      0x40010038
define_register OPAMP2_CSR,      0x4001003C
define_register OPAMP3_CSR,      0x40010040
define_register OPAMP4_CSR,      0x40010044

@ EXTI memory layout

define_register EXTI_IMR1,       0x40010400
define_register EXTI_EMR1,       0x40010404
define_register EXTI_RTSR1,      0x40010408
define_register EXTI_FTSR1,      0x4001040C
define_register EXTI_SWIER1,     0x40010410
define_register EXTI_PR1,        0x40010414
define_register EXTI_IMR2,       0x40010480
define_register EXTI_EMR2,       0x40010484
define_register EXTI_RTSR2,      0x40010488
define_register EXTI_FTSR2,      0x4001048C
define_register EXTI_SWIER2,     0x40010490
define_register EXTI_PR2,        0x40010494


@ TIM1 memory layout

define_register TIM1_CR1,        0x40012C00
define_register TIM1_CR2,        0x40012C04
define_register TIM1_SMCR,       0x40012C08
define_register TIM1_DIER,       0x40012C0C
define_register TIM1_SR,         0x40012C10
define_register TIM1_EGR,        0x40012C14
define_register TIM1_CCMR1,      0x40012C18
define_register TIM1_CCMR2,      0x40012C1C
define_register TIM1_CCER,       0x40012C20
define_register TIM1_CNT,        0x40012C24
define_register TIM1_PSC,        0x40012C28
define_register TIM1_ARR,        0x40012C2C
define_register TIM1_RCR,        0x40012C30
define_register TIM1_CCR1,       0x40012C34
define_register TIM1_CCR2,       0x40012C38
define_register TIM1_CCR3,       0x40012C3C
define_register TIM1_CCR4,       0x40012C40
define_register TIM1_BDTR,       0x40012C44
define_register TIM1_DCR,        0x40012C48
define_register TIM1_DMAR,       0x40012C4C
define_register TIM1_AF1,        0x40012C60
define_register TIM1_AF2,        0x40012C64

@ USART1 memory layout

define_register USART1_CR1,      0x40013800
define_register USART1_CR2,      0x40013804
define_register USART1_CR3,      0x40013808
define_register USART1_BRR,      0x4001380C
define_register USART1_GTPR,     0x40013810
define_register USART1_RTOR,     0x40013814
define_register USART1_RQR,      0x40013818
define_register USART1_ISR,      0x4001381C
define_register USART1_ICR,      0x40013820
define_register USART1_RDR,      0x40013824
define_register USART1_TDR,      0x40013828

@ TIM15 memory layout

define_register TIM15_CR1,       0x40014000
define_register TIM15_CR2,       0x40014004
define_register TIM15_DIER,      0x4001400C
define_register TIM15_SR,        0x40014010
define_register TIM15_EGR,       0x40014014
define_register TIM15_CCMR1,     0x40014018
define_register TIM15_CCER,      0x40014020
define_register TIM15_CNT,       0x40014024
define_register TIM15_PSC,       0x40014028
define_register TIM15_ARR,       0x4001402C
define_register TIM15_RCR,       0x40014030
define_register TIM15_CCR1,      0x40014034
define_register TIM15_CCR2,      0x40014038
define_register TIM15_BDTR,      0x40014044
define_register TIM15_DCR,       0x40014048
define_register TIM15_DMAR,      0x4001404C

@ TIM16 memory layout

define_register TIM16_CR1,       0x40014400
define_register TIM16_CR2,       0x40014404
define_register TIM16_DIER,      0x4001440C
define_register TIM16_SR,        0x40014410
define_register TIM16_EGR,       0x40014414
define_register TIM16_CCMR1,     0x40014418
define_register TIM16_CCER,      0x40014420
define_register TIM16_CNT,       0x40014424
define_register TIM16_PSC,       0x40014428
define_register TIM16_ARR,       0x4001442C
define_register TIM16_RCR,       0x40014430
define_register TIM16_CCR1,      0x40014434
define_register TIM16_BDTR,      0x40014444
define_register TIM16_DCR,       0x40014448
define_register TIM16_DMAR,      0x4001444C

@ TIM17 memory layout

define_register TIM17_CR1,       0x40014800
define_register TIM17_CR2,       0x40014804
define_register TIM17_DIER,      0x4001480C
define_register TIM17_SR,        0x40014810
define_register TIM17_EGR,       0x40014814
define_register TIM17_CCMR1,     0x40014818
define_register TIM17_CCER,      0x40014820
define_register TIM17_CNT,       0x40014824
define_register TIM17_PSC,       0x40014828
define_register TIM17_ARR,       0x4001482C
define_register TIM17_RCR,       0x40014830
define_register TIM17_CCR1,      0x40014834
define_register TIM17_BDTR,      0x40014844
define_register TIM17_DCR,       0x40014848
define_register TIM17_DMAR,      0x4001484C

@ DMA memory layout

define_register DMA1_ISR,         0x40020000
define_register DMA1_IFCR,        0x40020004

define_register DMA1_CCR1,        0x40020008
define_register DMA1_CCR2,        0x4002001C
define_register DMA1_CCR3,        0x40020030
define_register DMA1_CCR4,        0x40020044
define_register DMA1_CCR5,        0x40020058
define_register DMA1_CCR6,        0x4002006C
define_register DMA1_CCR7,        0x40020080

define_register DMA1_CNDTR1,      0x4002000C
define_register DMA1_CNDTR2,      0x40020020
define_register DMA1_CNDTR3,      0x40020034
define_register DMA1_CNDTR4,      0x40020048
define_register DMA1_CNDTR5,      0x4002005C
define_register DMA1_CNDTR6,      0x40020070
define_register DMA1_CNDTR7,      0x40020084

define_register DMA1_CPAR1,       0x40020010
define_register DMA1_CPAR2,       0x40020024
define_register DMA1_CPAR3,       0x40020038
define_register DMA1_CPAR4,       0x4002004C
define_register DMA1_CPAR5,       0x40020060
define_register DMA1_CPAR6,       0x40020074
define_register DMA1_CPAR7,       0x40020088

define_register DMA1_CMAR1,       0x40020014
define_register DMA1_CMAR2,       0x40020028
define_register DMA1_CMAR3,       0x4002003C
define_register DMA1_CMAR4,       0x40020050
define_register DMA1_CMAR5,       0x40020064
define_register DMA1_CMAR6,       0x40020078
define_register DMA1_CMAR7,       0x4002008C

@ RCC memory layout

define_register RCC_CR,          0x40021000
define_register RCC_CFGR,        0x40021004
define_register RCC_CIR,         0x40021008
define_register RCC_APB2RSTR,    0x4002100C
define_register RCC_APB1RSTR,    0x40021010
define_register RCC_AHBENR,      0x40021014
define_register RCC_APB2ENR,     0x40021018
define_register RCC_APB1ENR,     0x4002101C
define_register RCC_BDCR,        0x40021020
define_register RCC_CSR,         0x40021024
define_register RCC_AHBRSTR,     0x40021028
define_register RCC_CFGR2,       0x4002102C
define_register RCC_CFGR3,       0x40021030

@ CRC memory layout

define_register CRC_DR,          0x40023000
define_register CRC_IDR,         0x40023004
define_register CRC_CR,          0x40023008

@ TSC memory layout

define_register TSC_CR,          0x40024000
define_register TSC_IER,         0x40024004
define_register TSC_ICR,         0x40024008
define_register TSC_ISR,         0x4002400C
define_register TSC_IOHCR,       0x40024010
define_register TSC_IOASCR,      0x40024018
define_register TSC_IOSCR,       0x40024020
define_register TSC_IOCCR,       0x40024028
define_register TSC_IOGCSR,      0x40024030
define_register TSC_IOG1CR,      0x40024034
define_register TSC_IOG2CR,      0x40024038
define_register TSC_IOG3CR,      0x4002403C
define_register TSC_IOG4CR,      0x40024040
define_register TSC_IOG5CR,      0x40024044
define_register TSC_IOG6CR,      0x40024048
define_register TSC_IOG7CR,      0x4002404C
define_register TSC_IOG8CR,      0x40024050

@ GPIOA memory layout

define_register GPIOA_MODER,     0x48000000
define_register GPIOA_OTYPER,    0x48000004
define_register GPIOA_OSPEEDR,   0x48000008
define_register GPIOA_PUPDR,     0x4800000C
define_register GPIOA_IDR,       0x48000010
define_register GPIOA_ODR,       0x48000014
define_register GPIOA_BSRR,      0x48000018
define_register GPIOA_LCKR,      0x4800001C
define_register GPIOA_AFRL,      0x48000020
define_register GPIOA_AFRH,      0x48000024

@ GPIOB memory layout

define_register GPIOB_MODER,     0x48000400
define_register GPIOB_OTYPER,    0x48000404
define_register GPIOB_OSPEEDR,   0x48000408
define_register GPIOB_PUPDR,     0x4800040C
define_register GPIOB_IDR,       0x48000410
define_register GPIOB_ODR,       0x48000414
define_register GPIOB_BSRR,      0x48000418
define_register GPIOB_LCKR,      0x4800041C
define_register GPIOB_AFRL,      0x48000420
define_register GPIOB_AFRH,      0x48000424

@ GPIOC memory layout

define_register GPIOC_MODER,     0x48000800
define_register GPIOC_OTYPER,    0x48000804
define_register GPIOC_OSPEEDR,   0x48000808
define_register GPIOC_PUPDR,     0x4800080C
define_register GPIOC_IDR,       0x48000810
define_register GPIOC_ODR,       0x48000814
define_register GPIOC_BSRR,      0x48000818
define_register GPIOC_LCKR,      0x4800081C
define_register GPIOC_AFRL,      0x48000820
define_register GPIOC_AFRH,      0x48000824

@ GPIOD memory layout

define_register GPIOD_MODER,     0x48000C00
define_register GPIOD_OTYPER,    0x48000C04
define_register GPIOD_OSPEEDR,   0x48000C08
define_register GPIOD_PUPDR,     0x48000C0C
define_register GPIOD_IDR,       0x48000C10
define_register GPIOD_ODR,       0x48000C14
define_register GPIOD_BSRR,      0x48000C18
define_register GPIOD_LCKR,      0x48000C1C
define_register GPIOD_AFRL,      0x48000C20
define_register GPIOD_AFRH,      0x48000C24

@ GPIOF memory layout

define_register GPIOF_MODER,     0x48001400
define_register GPIOF_OTYPER,    0x48001404
define_register GPIOF_OSPEEDR,   0x48001408
define_register GPIOF_PUPDR,     0x4800140C
define_register GPIOF_IDR,       0x48001410
define_register GPIOF_ODR,       0x48001414
define_register GPIOF_BSRR,      0x48001418
define_register GPIOF_LCKR,      0x4800141C
define_register GPIOF_AFRL,      0x48001420
define_register GPIOF_AFRH,      0x48001424

@ SPI2 memory layout

define_register SPI2_CR1,        0x40003800
define_register SPI2_CR2,        0x40003804
define_register SPI2_SR,         0x40003808
define_register SPI2_DR,         0x4000380C
define_register SPI2_CRCPR,      0x40003810
define_register SPI2_RXCRCR,     0x40003814
define_register SPI2_TXCRCR,     0x40003818

@ ADC1 memory layout

define_register ADC1_ISR,        0x50000000
define_register ADC1_IER,        0x50000004
define_register ADC1_CR,         0x50000008
define_register ADC1_CFGR,       0x5000000C
define_register ADC1_SMPR1,      0x50000014
define_register ADC1_SMPR2,      0x50000018
define_register ADC1_TR1,        0x50000020
define_register ADC1_TR2,        0x50000024
define_register ADC1_TR3,        0x50000028
define_register ADC1_SQR1,       0x50000030
define_register ADC1_SQR2,       0x50000034
define_register ADC1_SQR3,       0x50000038
define_register ADC1_SQR4,       0x5000003C
define_register ADC1_DR,         0x50000040
define_register ADC1_JSQR,       0x5000004C
define_register ADC1_OFR1,       0x50000060
define_register ADC1_OFR2,       0x50000064
define_register ADC1_OFR3,       0x50000068
define_register ADC1_OFR4,       0x5000006C
define_register ADC1_JDR1,       0x50000080
define_register ADC1_JDR2,       0x50000084
define_register ADC1_JDR3,       0x50000088
define_register ADC1_JDR4,       0x5000008C
define_register ADC1_AWD2CR,     0x500000A0
define_register ADC1_AWD3CR,     0x500000A4
define_register ADC1_DIFSEL,     0x500000B0
define_register ADC1_CALFACT,    0x500000B4

@ ADC common memory layout
define_register ADC12_CSR,       0x50000300
define_register ADC12_CCR,       0x50000308
define_register ADC12_CDR,       0x5000030C

@ NVIC special memory layout

define_register NVIC_ISER0,      0xE000E100
define_register NVIC_ISER1,      0xE000E104
define_register NVIC_ISER2,      0xE000E108
define_register NVIC_ISER3,      0xE000E10C
define_register NVIC_ISER4,      0xE000E110
define_register NVIC_ISER5,      0xE000E114
define_register NVIC_ISER6,      0xE000E118
define_register NVIC_ISER7,      0xE000E11C
define_register NVIC_ICER0,      0xE000E180
define_register NVIC_ICER1,      0xE000E184
define_register NVIC_ICER2,      0xE000E188
define_register NVIC_ICER3,      0xE000E18C
define_register NVIC_ICER4,      0xE000E190
define_register NVIC_ICER5,      0xE000E194
define_register NVIC_ICER6,      0xE000E198
define_register NVIC_ICER7,      0xE000E19C
define_register NVIC_ISPR0,      0xE000E200
define_register NVIC_ISPR1,      0xE000E204
define_register NVIC_ISPR2,      0xE000E208
define_register NVIC_ISPR3,      0xE000E20C
define_register NVIC_ISPR4,      0xE000E210
define_register NVIC_ISPR5,      0xE000E214
define_register NVIC_ISPR6,      0xE000E218
define_register NVIC_ISPR7,      0xE000E21C
define_register NVIC_ICPR0,      0xE000E280
define_register NVIC_ICPR1,      0xE000E284
define_register NVIC_ICPR2,      0xE000E288
define_register NVIC_ICPR3,      0xE000E28C
define_register NVIC_ICPR4,      0xE000E290
define_register NVIC_ICPR5,      0xE000E294
define_register NVIC_ICPR6,      0xE000E298
define_register NVIC_ICPR7,      0xE000E29C
define_register NVIC_IABR0,      0xE000E300
define_register NVIC_IABR1,      0xE000E304
define_register NVIC_IABR2,      0xE000E308
define_register NVIC_IABR3,      0xE000E30C
define_register NVIC_IABR4,      0xE000E310
define_register NVIC_IABR5,      0xE000E314
define_register NVIC_IABR6,      0xE000E318
define_register NVIC_IABR7,      0xE000E31C
define_register NVIC_IPR0,       0xE000E400
define_register NVIC_IPR1,       0xE000E404
define_register NVIC_IPR2,       0xE000E408
define_register NVIC_IPR3,       0xE000E40C
define_register NVIC_IPR4,       0xE000E410
define_register NVIC_IPR5,       0xE000E414
define_register NVIC_IPR6,       0xE000E418
define_register NVIC_IPR7,       0xE000E41C
define_register NVIC_IPR8,       0xE000E420
define_register NVIC_IPR9,       0xE000E424
define_register NVIC_IPR10,      0xE000E428
define_register NVIC_IPR11,      0xE000E42C
define_register NVIC_IPR12,      0xE000E430
define_register NVIC_IPR13,      0xE000E434
define_register NVIC_IPR14,      0xE000E438
define_register NVIC_IPR15,      0xE000E43C
define_register NVIC_IPR16,      0xE000E440
define_register NVIC_IPR17,      0xE000E444
define_register NVIC_IPR18,      0xE000E448
define_register NVIC_IPR19,      0xE000E44C
define_register NVIC_IPR20,      0xE000E450
define_register NVIC_IPR21,      0xE000E454
define_register NVIC_IPR22,      0xE000E458
define_register NVIC_IPR23,      0xE000E45C
define_register NVIC_IPR24,      0xE000E460
define_register NVIC_IPR25,      0xE000E464
define_register NVIC_IPR26,      0xE000E468
define_register NVIC_IPR27,      0xE000E46C
define_register NVIC_IPR28,      0xE000E470
define_register NVIC_IPR29,      0xE000E474
define_register NVIC_IPR30,      0xE000E478
define_register NVIC_IPR31,      0xE000E47C
define_register NVIC_IPR32,      0xE000E480
define_register NVIC_IPR33,      0xE000E484
define_register NVIC_IPR34,      0xE000E488
define_register NVIC_IPR35,      0xE000E48C
define_register NVIC_IPR36,      0xE000E490
define_register NVIC_IPR37,      0xE000E494
define_register NVIC_IPR38,      0xE000E498
define_register NVIC_IPR39,      0xE000E49C
define_register NVIC_IPR40,      0xE000E4A0
define_register NVIC_IPR41,      0xE000E4A4
define_register NVIC_IPR42,      0xE000E4A8
define_register NVIC_IPR43,      0xE000E4AC
define_register NVIC_IPR44,      0xE000E4B0
define_register NVIC_IPR45,      0xE000E4B4
define_register NVIC_IPR46,      0xE000E4B8
define_register NVIC_IPR47,      0xE000E4BC
define_register NVIC_IPR48,      0xE000E4C0
define_register NVIC_IPR49,      0xE000E4C4
define_register NVIC_IPR50,      0xE000E4C8
define_register NVIC_IPR51,      0xE000E4CC
define_register NVIC_IPR52,      0xE000E4D0
define_register NVIC_IPR53,      0xE000E4D4
define_register NVIC_IPR54,      0xE000E4D8
define_register NVIC_IPR55,      0xE000E4DC
define_register NVIC_IPR56,      0xE000E4E0
define_register NVIC_IPR57,      0xE000E4E4
define_register NVIC_IPR58,      0xE000E4E8
define_register NVIC_IPR59,      0xE000E4EC
define_register NVIC_STIR,       0xE000EE00

@ SysTick special memory layout

define_register SYST_CSR,        0xE000E010
define_register SYST_RVR,        0xE000E014
define_register SYST_CVR,        0xE000E018
define_register SYST_CALIB,      0xE000E01C

@ Floating point unit memory layout

define_register FPU_CPACR,       0xE000ED88
define_register FPU_FPCCR,       0xE000EF34
define_register FPU_FPCAR,       0xE000EF38
define_register FPU_FPDSCR,      0xE000EF3C
define_register FPU_MVFR0,       0xE000EF40
define_register FPU_MVFR1,       0xE000EF44
define_register FPU_MVFR2,       0xE000EF48

.end
