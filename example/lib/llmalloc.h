#ifndef LLMALLOC_H_
#define LLMALLOC_H_

    // --- Standard Includes --- //

    #include <stddef.h>
    #include <unistd.h>
    #include <errno.h>

    // --- Macros --- //

    /// @brief Aligns a given size to the next multiple of sizeof(void *).
    #define ALIGNMENT (sizeof(void *) - 1)
    #define ALIGN(size) (((size) + ALIGNMENT) & ~ALIGNMENT)

    /// @brief Extracts the flag (0 for allocated, 1 for free) and value from a memory block.
    #define FLAG(x) (x->allocated & 0x1)
    #define VALUE(x) (x->allocated & ~0x3)

    // --- Structs --- //

    /// @brief Memory block struct to keep track of allocated memory.
    struct memory_block {
        unsigned int allocated; // Least significant bit is the flag, the rest is the size of the block.
        void* data; // Pointer to the start of the data segment, returned by llmalloc.
        struct memory_block* next; // Pointer to the next memory block.
        struct memory_block* prev; // Pointer to the previous memory block.
        char end[0]; // End of the struct.
    };

    // --- Function Prototypes --- //

    /// @brief System call to request more memory from the system.
    /// @param incr Number of bytes to request from the system.
    /// @return Pointer to the previous end of the data segment.
    extern void* sbrk (ptrdiff_t incr);

    /// @brief Allocates a block of memory of a given size.
    /// @param size Size of the memory block to allocate.
    /// @return Pointer to the allocated memory block.
    void* llmalloc (unsigned int size);

    /// @brief Frees a previously allocated memory block with llmalloc.
    /// @param ptr Pointer to the memory block to free given by llmalloc.
    /// @warning Calling this function with a pointer not allocated by llmalloc results in undefined behavior.
    void llfree (void* ptr);

#endif // LLMALLOC_H_