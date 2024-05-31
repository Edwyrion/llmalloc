
#include "llmalloc.h"

int main (void) {

    void* a = llmalloc(10);
    void* b = llmalloc(20);
    void* c = llmalloc(30);

    llfree(a);
    llfree(c);
    llfree(b);

    void* d = llmalloc(50);
    void* e = llmalloc(10);

    while (1) {}

    return 0;    
}