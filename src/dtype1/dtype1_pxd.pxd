
from libc.stdint cimport int8_t, int16_t, int32_t, int64_t
cdef extern from "dtype1_wrapper.h":
  cdef void dtype1_alloc_mytype(void *ptr);
  cdef void dtype1_dealloc_mytype(void *ptr);

  cdef void dtype1_mytype_get_a1(void *ptr, int32_t *var);
  cdef void dtype1_mytype_set_a1(void *ptr, int32_t *var);

  cdef void dtype1_mytype_get_arr3_size(void *ptr, int32_t *dim1);
  cdef void dtype1_mytype_get_arr3(void *ptr, int32_t *dim1, int32_t *var);
  cdef void dtype1_mytype_set_arr3(void *ptr, int32_t *dim1, int32_t *var);


      