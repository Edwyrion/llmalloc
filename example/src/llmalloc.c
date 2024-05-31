#include "llmalloc.h"

void* llmalloc (unsigned int size) {

    void* brk = sbrk(0);
    static struct memory_block *heap_head;

    // Align brk pointer to the next multiple of sizeof(void *)
    uintptr_t misalignment = (uintptr_t) brk & (sizeof(void *) - 1);

    if (misalignment) {
        if (sbrk(sizeof(void *) - misalignment) == (void *) -1) {
            errno = ENOMEM;
            return NULL;
        }
        brk = sbrk(0);
    }

    const unsigned int aligned_size = ALIGN(size);
    const unsigned int memory_request = aligned_size + sizeof(struct memory_block);

    struct memory_block *block = heap_head;
    struct memory_block *prev_block = NULL;

    // First best-fit
    while (block != NULL) {
        if (VALUE(block) >= aligned_size && FLAG(block)) {
            break;
        }
        prev_block = block;
        block = block->next;
    } 

    // If there are no free blocks
    if (block == NULL) {
        // Check if there is enough space to allocate a new block
        if (sbrk(memory_request) == (void*) -1) {
            errno = ENOMEM;
            return NULL;
        }

        // Assign the heap head to the newly allocated memory
        struct memory_block *new_block = brk;

        // Fill out the heap head struct
        new_block->allocated = aligned_size;
        new_block->data = new_block + 1;
        new_block->next = NULL;
        new_block->prev = prev_block;

        if (heap_head == NULL) {
            heap_head = new_block;
            return new_block->data;
        }

        prev_block->next = new_block;

        return new_block->data;
    }

    // Check if we can split the free block
    if (VALUE(block) > aligned_size + sizeof(struct memory_block)) {

        void *split_ptr = block->end + aligned_size;
        struct memory_block *split_block = split_ptr;

        split_block->allocated = VALUE(block) - aligned_size - sizeof(struct memory_block);
        split_block->allocated |= 1;

        // Assign the data pointer to the correct location
        split_block->data = (char*) block->data + aligned_size + sizeof(struct memory_block);

        // Link the new memory block
        split_block->prev = block;
        split_block->next = block->next;

        // Update the amount of allocated memory in the original block
        block->allocated = aligned_size;

        // Link the original memory block
        block->next = split_block;
        if (block->next) {
           block->next->prev = split_block;
        }
    }

    // Mark the block as allocated
    block->allocated &= ~1;

    return block->data;
}

void llfree (void* ptr) {
    // Get the block pointer from the data pointer provided by llmalloc call
    void *block_ptr = (char *) ptr - sizeof(struct memory_block);
    struct memory_block *block = block_ptr;

    struct memory_block *prev_block = block;
    struct memory_block *current_block = block->next;

    // To the right
    while (current_block != NULL && FLAG(current_block)) {
        prev_block->allocated += VALUE(current_block) + sizeof(struct memory_block);
        prev_block->next = current_block->next;

        if(current_block->next) {
            current_block->next->prev = prev_block;
        }

        prev_block = current_block;
        current_block = current_block->next;
    }

    // To the left
    prev_block = block;
    current_block = block->prev;

    while (current_block != NULL && FLAG(current_block)) {

        current_block->allocated += VALUE(prev_block) + sizeof(struct memory_block);
        current_block->next = prev_block->next;

        if(prev_block->next) {
            prev_block->next->prev = current_block;
        }

        prev_block = current_block;
        current_block = current_block->prev;
    }

    // Mark the block as free
    block->allocated |= 1;
}