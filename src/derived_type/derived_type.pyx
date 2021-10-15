import numpy as __np
from numpy cimport ndarray 

cdef extern from "derived_type.h":
  cdef extern void allocate_mytype(void *ptr)
  cdef extern void destroy_mytype(void *ptr)

  cdef extern void mytype_set_a(void *ptr, double *a)
  cdef extern void mytype_get_a(void *ptr, double *a)
  cdef extern void mytype_set_arr(void *ptr, int *arr_size, double *arr)
  cdef extern void mytype_get_arr_size(void *ptr, int *arr_size, bint *alloc)
  cdef extern void mytype_get_arr(void *ptr, int *arrs_size, double *arr)

  cdef extern void mytype_add2a_wrapper(void *ptr, double *b) 
  cdef extern void mytype_printarr_wrapper(void *ptr) 
  cdef extern void mytype_sumarr_wrapper(void *ptr, double *result)

cdef class __mytype:
  """type(mytype)
  real(c_double) :: a
  real(c_double), allocatable :: arr(:)
contains
  procedure :: add2a
  procedure :: sumarr
  procedure :: printarr
end type"""
  cdef void *_ptr
  cdef bint _destroy
  
  def __cinit__(self, bint alloc = True):
    if alloc:
      allocate_mytype(&self._ptr)
      self._destroy = True
    else:
      self._destroy = False
    
  def __dealloc__(self):
    if self._destroy:
      destroy_mytype(&self._ptr)
      self._ptr = NULL

  property a:
    def __get__(self):
      cdef double a
      mytype_get_a(&self._ptr, &a)
      return a
    def __set__(self,double a):
      mytype_set_a(&self._ptr, &a)
        
  property arr:
    def __get__(self):
      cdef int arr_size
      cdef bint alloc
      mytype_get_arr_size(&self._ptr, &arr_size, &alloc)
      cdef ndarray arr = __np.empty(arr_size, __np.double)
      if alloc:
        mytype_get_arr(&self._ptr, &arr_size, <double *>arr.data)
      return arr
    
    def __set__(self, ndarray arr):
        arr = arr.astype(__np.double)
        cdef int arr_size = len(arr)
        mytype_set_arr(&self._ptr, &arr_size, <double *>arr.data)
        
  def add2a(self, double b):
    """add2a(self, b)

Parameters
----------
b : float

Returns
-------
None
"""
    mytype_add2a_wrapper(&self._ptr, &b)
    
  def printarr(self):
    """printarr(self)

Parameters
----------
None

Returns
-------
None
"""
    mytype_printarr_wrapper(&self._ptr)
      
  def sumarr(self):
    """sumarr(self)

Parameters
----------
None

Returns
-------
None
"""
    cdef double result
    mytype_sumarr_wrapper(&self._ptr, &result)
    return result
  
cdef class __derived_type: 
  """module module_variable
  type mytype
end module"""
  property mytype:
    def __get__(self):
      return __mytype
          
derived_type = __derived_type()    

      