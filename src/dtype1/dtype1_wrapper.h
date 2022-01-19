#include <stdint.h>

void dtype1_alloc_mytype(void *ptr);
void dtype1_dealloc_mytype(void *ptr);
void dtype1_alloc_myothertype(void *ptr);
void dtype1_dealloc_myothertype(void *ptr);

void dtype1_mytype_get_a1(void *ptr, int32_t *var);
void dtype1_mytype_set_a1(void *ptr, int32_t *var);

void dtype1_mytype_get_arr3_size(void *ptr, int32_t *dim1);
void dtype1_mytype_get_arr3(void *ptr, int32_t *dim1, int32_t *var);
void dtype1_mytype_set_arr3(void *ptr, int32_t *dim1, int32_t *var);

void dtype1_mytype_my_get(void *ptr, void *ptr1);
void dtype1_mytype_my_set(void *ptr, void *ptr1);

void dtype1_mytype_my1_get(void *ptr, void **ptr1);
void dtype1_mytype_my1_set(void *ptr, void **ptr1);

void dtype1_myothertype_get_a1(void *ptr, int32_t *var);
void dtype1_myothertype_set_a1(void *ptr, int32_t *var);

