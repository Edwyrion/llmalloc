# Custom malloc implementation in C

This repository consists of a custom malloc implementation using best-fit strategy for memory blocks represented by the doubly-linked lists called ```llmalloc()``` and its corresponding free function ```llfree()```. An example of usage for embedded enviroment is provided using STM32F302x chip set including minimal custom implementation of ```sbrk()``` systemcall required by the standard library (and the ```llmalloc()``` function call).

## Example
```C
int main() {
  void *a = llmalloc(200);

  llfree(a);

  void *b = llmalloc(sizeof(char));
  void *c = llmalloc(sizeof(char));
  void *d = llmalloc(sizeof(char));
  
  llfree(b);
  llfree(d);
  llfree(c);
  
  void *e = llmalloc(201);
  llfree(e);

  return 0;
}
```
Upon compiling the previous code with the x86-64 gcc 14.1 compiler and examining the ```brk``` pointer and memory allocated by the ```llmalloc()``` we can for example see the following behaviour:
```C
Current brk [0x2325000]
-------------------------------------------------
void* a [0x2325020]
[Address 0x2325000, Allocated 200, Flags 0]
Current brk [0x23250e8]
-------------------------------------------------
Freeing block [0x2325000]
[Address 0x2325000, Allocated 200, Flags 1]
Current brk [0x23250e8]
-------------------------------------------------
void* b [0x2325020]
void* c [0x2325048]
void* d [0x2325070]
[Address 0x2325000, Allocated 8, Flags 0]
[Address 0x2325028, Allocated 8, Flags 0]
[Address 0x2325050, Allocated 8, Flags 0]
[Address 0x2325078, Allocated 80, Flags 1]
Current brk [0x23250e8]
-------------------------------------------------
Freeing block [0x2325000]
[Address 0x2325000, Allocated 8, Flags 1]
[Address 0x2325028, Allocated 8, Flags 0]
[Address 0x2325050, Allocated 8, Flags 0]
[Address 0x2325078, Allocated 80, Flags 1]
Current brk [0x23250e8]
-------------------------------------------------
Freeing block [0x2325050]
Merging R[0x2325050] with [0x2325078]
[Address 0x2325000, Allocated 8, Flags 1]
[Address 0x2325028, Allocated 8, Flags 0]
[Address 0x2325050, Allocated 120, Flags 1]
Current brk [0x23250e8]
-------------------------------------------------
Freeing block [0x2325028]
Merging R[0x2325028] with [0x2325050]
Merging L[0x2325000] with [0x2325028]
[Address 0x2325000, Allocated 200, Flags 1]
Current brk [0x23250e8]
-------------------------------------------------
void* e [0x23250fc]
[Address 0x2325000, Allocated 200, Flags 1]
[Address 0x23250e8, Allocated 208, Flags 0]
Current brk [0x23251d8]
-------------------------------------------------
```
