# This file was automatically generated by the LFortran compiler.
# Editing by hand is discouraged.

from libc.stdint cimport int8_t, int16_t, int32_t, int64_t
cdef extern from "module_variable_wrapper.h":
  cdef void module_variable_get_a1(int32_t *var)
  cdef void module_variable_set_a1(int32_t *var)
  
  cdef void module_variable_get_a2(int32_t *var)
  
  cdef void module_variable_get_a3(int32_t *var)
  cdef void module_variable_set_a3(int32_t *var)
  
  cdef void module_variable_get_arr1(int32_t *var)
  cdef void module_variable_set_arr1(int32_t *var)

  cdef void module_variable_get_arr2(int32_t *var)

  cdef void module_variable_get_arr3_size(int64_t *d)
  cdef void module_variable_get_arr3(int64_t *d, int32_t *var)
  cdef void module_variable_set_arr3(int64_t *d, int32_t *var)

  cdef void module_variable_get_str1(char *var)
  cdef void module_variable_set_str1(int32_t *len1, char *var)

  cdef void module_variable_get_str2_len(int32_t *len1)
  cdef void module_variable_get_str2(int32_t *len1, char *var)
  cdef void module_variable_set_str2(int32_t *len1, char *var)
  
  cdef void module_variable_get_str4_size(int32_t *dim1)
  cdef void module_variable_get_str4(int32_t *len1, int32_t *dim1, char *var)
  cdef void module_variable_set_str4(int32_t *len1, int32_t *dim1, char *var)