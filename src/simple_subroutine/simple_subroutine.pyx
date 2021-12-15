import numpy as __np
from numpy cimport ndarray 

cdef extern from "simple_subroutine.h":
  cdef void mysub_wrapper(int *a, int *b)
  cdef void returns_arr1_len_wrapper(int *arr_size, void *ptr)
  cdef void returns_arr1_wrapper(void *ptr, int *arr_len, int *arr)

cdef class __simple_subroutine:
  """module simple_subroutine
contains
  mysub()
end module"""
  def mysub(self, int a):
    """b = mysub(a)

Parameters
----------
a : int

Returns
-------
b : int
"""
    cdef int b
    mysub_wrapper(&a, &b)
    return b
    
  def returns_arr1(self):
    cdef int arr_len
    cdef void *ptr
    returns_arr1_len_wrapper(&arr_len, &ptr)
    cdef ndarray arr = __np.empty(arr_len, __np.int32)
    returns_arr1_wrapper(&ptr, &arr_len, <int *>arr.data)
    return arr
    
simple_subroutine = __simple_subroutine()
