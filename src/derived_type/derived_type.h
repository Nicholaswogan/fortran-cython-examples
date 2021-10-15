#include <stdbool.h>
void allocate_mytype(void *ptr);
void destroy_mytype(void *ptr);

void mytype_set_a(void *ptr, double *a);
void mytype_get_a(void *ptr, double *a);
void mytype_set_arr(void *ptr, int *arr_size, double *arr);
void mytype_get_arr_size(void *ptr, int *arr_size, bool *alloc);
void mytype_et_arr(void *ptr, int *arrs_size, double *arr);

void mytype_add2a_wrapper(void *ptr, double *b) ;
void mytype_printarr_wrapper(void *ptr) ;
void mytype_sumarr_wrapper(void *ptr, double *result);