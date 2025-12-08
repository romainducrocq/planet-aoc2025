#include <stdlib.h>

// planet doesn't have function pointers
// so we wrap qsort with an extern function
// that is implemented in the caller program
// TODO: write a quicksort algo in comlib

static int qsort_fptr(const void* a, const void* b) {
    extern int qsort_compare(const void* a, const void* b);
    return qsort_compare(a, b);
}

void qsort_f(void* base, unsigned long nmemb, unsigned long size) { qsort(base, nmemb, size, qsort_fptr); }
