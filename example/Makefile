# Variables
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy


CFLAGS = -mcpu=cortex-m4 -mthumb -O0 -Ilib --specs=nano.specs
CFLAGS += -ffunction-sections -fdata-sections -g3

# make thumb conditions implicit
ASFLAGS = -mcpu=cortex-m4 -mthumb -mimplicit-it=thumb 
LDFLAGS = -T linker.ld -lc

# Source files
C_SOURCES = $(wildcard src/*.c)
ASM_SOURCES = $(wildcard src/*.s)

# Object files
C_OBJECTS = $(C_SOURCES:.c=.o)
ASM_OBJECTS = $(ASM_SOURCES:.s=.o)
OBJECTS = $(C_OBJECTS) $(ASM_OBJECTS)

# Output file
OUTPUT = output.elf

# Default target
all: $(OUTPUT) clean

# Link
$(OUTPUT): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

# Compile C sources
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Assemble
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# Clean
clean:
	rm -f $(OBJECTS)