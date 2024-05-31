#include <errno.h>
#include <sys/stat.h>
#include <sys/times.h>

#undef errno
extern int errno;

int close (int file) {
    return -1;
}

char *__env[1] = { 0 };
char **environ = __env;

int execve (const char *name, char *const argv[], char *const env[]) {
    errno = ENOMEM;
    return -1;
}

int fork (void) {
    errno = EAGAIN;
    return -1;
}

int fstat (int file, struct stat *st) {
    st->st_mode = S_IFCHR;
    return 0;
}

int getpid (void) {
    return 1;
}

int isatty (int file) {
    return 1;
}

int kill (int pid, int sig) {
    errno = EINVAL;
    return -1;
}

int link (char *old, char *new) {
    errno = EMLINK;
    return -1;
}

int lseek (int file, int ptr, int dir) {
    return 0;
}

int open (const char *name, int flags, int mode) {
    return -1;
}

int read (int file, char *ptr, int len) {
    return 0;
}

caddr_t sbrk (ptrdiff_t incr) {

    extern char __bss_end__;
    extern char _sstack;

    static char *heap_end;

    // If the heap pointer hasn't been initialized, set it to the start of the heap.
    if (heap_end == NULL) {
        // Start of the heap, defined by the linker.
        heap_end = &__bss_end__;
    }

    // Return the current heap pointer if the requested increment is 0.
    if (incr == 0) {
        return (caddr_t) heap_end;
    }

    char *prev_heap_end = heap_end;

    // Increment the heap pointer by the requested amount.
    ptrdiff_t heap_used = heap_end - &__bss_end__;
    ptrdiff_t heap_memory = &_sstack - &__bss_end__;

    if (heap_used + incr > heap_memory) {
        errno = ENOMEM;
        return (caddr_t) -1;
    }

    heap_end += incr;

    return (caddr_t) prev_heap_end;
}

int stat (const char *file, struct stat *st) {
    st->st_mode = S_IFCHR;
    return 0;
}

clock_t times (struct tms *buf) {
    return -1;
}

int unlink (char *name) {
    errno = ENOENT;
    return -1;
}

int wait (int *status) {
    errno = ECHILD;
    return -1;
}

int write (int file, char *ptr, int len) {
    return len;
}

// Reentrant versions of the standard C library functions

void _exit(int status) {
    while(1) {}
}

int _close(int file) {
    return close(file);
}

int _lseek(int file, int ptr, int dir) {
    return lseek(file, ptr, dir);
}

int _read(int file, char *ptr, int len) {
    return read(file, ptr, len);
}

int _write(int file, char *ptr, int len) {
    return write(file, ptr, len);
}

caddr_t _sbrk(int incr) {
    return sbrk(incr);
}

int _fstat(int file, struct stat *st) {
    return fstat(file, st);
}

int _isatty(int file) {
    return isatty(file);
}

int _kill(int pid, int sig) {
    return kill(pid, sig);
}

int _getpid(void) {
    return getpid();
}

int _link(char *old, char *new) {
    return link(old, new);
}

int _unlink(char *name) {
    return unlink(name);
}

int _wait(int *status) {
    return wait(status);
}

int _execve(const char *name, char *const argv[], char *const env[]) {
    return execve(name, argv, env);
}

int _fork(void) {
    return fork();
}

int _open(const char *name, int flags, int mode) {
    return open(name, flags, mode);
}

int _stat(const char *file, struct stat *st) {
    return stat(file, st);
}

int _times(struct tms *buf) {
    return times(buf);
}