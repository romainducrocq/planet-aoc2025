#include <stdlib.h>

#ifdef IMPL_BSEARCH
static int bsearch_fptr(const void* a, const void* b) {
    extern int bsearch_compare(const void* a, const void* b);
    return bsearch_compare(a, b);
}

void* bsearch_f(const void* key, const void* base, unsigned long nmemb, unsigned long size) {
    return bsearch(key, base, nmemb, size, bsearch_fptr);
}
#endif

#ifdef IMPL_QSORT
static int qsort_fptr(const void* a, const void* b) {
    extern int qsort_compare(const void* a, const void* b);
    return qsort_compare(a, b);
}

void qsort_f(void* base, unsigned long nmemb, unsigned long size) { qsort(base, nmemb, size, qsort_fptr); }
#endif
