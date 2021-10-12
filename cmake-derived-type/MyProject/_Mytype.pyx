import numpy as np
from numpy cimport ndarray 

# cdef extern from "mymod.h":
cdef extern void allocate_mytype(void *ptr)
cdef extern void destroy_mytype(void *ptr)

cdef extern void set_a(void *ptr, double *a)
cdef extern void get_a(void *ptr, double *a)
cdef extern void set_arr(void *ptr, int *arr_size, double *arr)
cdef extern void get_arr_size(void *ptr, int *arr_size, bint *alloc)
cdef extern void get_arr(void *ptr, int *arrs_size, double *arr)

cdef extern void add2a_wrapper(void *ptr, double *b) 
cdef extern void printarr_wrapper(void *ptr, char *err) 
cdef extern void sumarr_wrapper(void *ptr, double *result, char *err)

cdef extern void allocate_myothertype(void *ptr, void *my_ptr)
cdef extern void destroy_myothertype(void *ptr)

cdef class Mytype:
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
      get_a(&self._ptr, &a)
      return a
    def __set__(self,double a):
      set_a(&self._ptr, &a)
        
  property arr:
    def __get__(self):
      cdef int arr_size
      cdef bint alloc
      get_arr_size(&self._ptr, &arr_size, &alloc)
      cdef ndarray arr = np.empty(arr_size, np.double)
      if alloc:
        get_arr(&self._ptr, &arr_size, <double *>arr.data)
      return arr
    
    def __set__(self, ndarray arr):
        arr = arr.astype(np.double)
        cdef int arr_size = len(arr)
        set_arr(&self._ptr, &arr_size, <double *>arr.data)
        
  def add2a(self, double b):
    add2a_wrapper(&self._ptr, &b)
    
  def printarr(self):
    cdef char err[1024+1]
    printarr_wrapper(&self._ptr, err)
    if len(err.strip()) > 0:
      raise Exception(err.decode("utf-8").strip())
      
  def sumarr(self):
    cdef char err[1024+1]
    cdef double result
    sumarr_wrapper(&self._ptr, &result, err)
    if len(err.strip()) > 0:
      raise Exception(err.decode("utf-8").strip())
    return result
      
cdef class Myothertype:
  cdef void *_ptr
  cdef void *_my_ptr
  
  def __cinit__(self):
    allocate_myothertype(&self._ptr, &self._my_ptr)
    
  def __dealloc__(self):
    destroy_myothertype(&self._ptr)
    self._ptr = NULL
    self._my_ptr = NULL
    
  property my:
    def __get__(self):
      my = Mytype(alloc = False)
      my._ptr = self._my_ptr
      return my
      
      