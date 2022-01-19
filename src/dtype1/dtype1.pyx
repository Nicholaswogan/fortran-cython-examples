from libc.stdlib cimport malloc, free
from numpy cimport import_array, ndarray, int8_t, int16_t, int32_t, int64_t
import numpy as np
cimport dtype1_pxd

cdef class __dtype1:
  property mytype:
    def __get__(self):
      return __dtype1_mytype
  property myothertype:
    def __get__(self):
      return __dtype1_myothertype

cdef class __dtype1_mytype:
  cdef void *_ptr
  cdef bint _destroy
  
  def __cinit__(self, bint alloc = True):
    if alloc:
      dtype1_pxd.dtype1_alloc_mytype(&self._ptr)
      self._destroy = True
    else:
      self._destroy = False
    
  def __dealloc__(self):
    if self._destroy:
      dtype1_pxd.dtype1_dealloc_mytype(&self._ptr)

  property a1:
    def __get__(self):
      cdef int32_t var
      dtype1_pxd.dtype1_mytype_get_a1(&self._ptr, &var)
      return var
    def __set__(self,int32_t var):
      dtype1_pxd.dtype1_mytype_set_a1(&self._ptr, &var)
        
  property arr3:
    def __get__(self):
      cdef int32_t dim1
      dtype1_pxd.dtype1_mytype_get_arr3_size(&self._ptr, &dim1)
      cdef ndarray var = np.empty((dim1,), np.int32)
      dtype1_pxd.dtype1_mytype_get_arr3(&self._ptr, &dim1, <int32_t *>var.data)
      return var
    def __set__(self, ndarray[int32_t, ndim=1] var):
      cdef int32_t dim1 = var.shape[0]
      dtype1_pxd.dtype1_mytype_set_arr3(&self._ptr, &dim1, <int32_t *>var.data)
    
  property my:
    def __get__(self):
      cdef void *ptr1;
      dtype1_pxd.dtype1_mytype_my_get(&self._ptr, &ptr1)
      var = __dtype1_myothertype(alloc=False)
      var._ptr = ptr1;
      return var
    def __set__(self, __dtype1_myothertype t1):
      dtype1_pxd.dtype1_mytype_my_set(&self._ptr, &t1._ptr)
      
  property my1:
    def __get__(self):
      cdef void **ptr1 = <void **> malloc(3 * sizeof(void *))
      if not ptr1:
        raise Exception("malloc failed!")
      dtype1_pxd.dtype1_mytype_my1_get(&self._ptr, ptr1)
      cdef ndarray var1 = np.empty((3,), dtype = object, order='F')
      for i in range(3):
        t1 = __dtype1_myothertype(alloc=False)
        t1._ptr = ptr1[i]
        var1[i] = t1
      free(ptr1)
      cdef ndarray var = np.reshape(var1, (3), order="F")
      return var
    def __set__(self, ndarray[object, ndim=1] var_in):
      cdef ndarray var = np.asfortranarray(var_in)
      cdef ndarray var1 = np.reshape(var,(3),order="F")
      cdef ndarray d = np.empty((var.ndim,), np.int64)
      for i in range(var.ndim):
        d[i] = var.shape[i]
      if (3,) != tuple(d):
        raise ValueError("my1 has wrong shape")
      for i in range(3):
        if type(var1[i]) != __dtype1_myothertype:
          raise ValueError("my1 has wrong type!")
      cdef void **ptr1 = <void **> malloc(3 * sizeof(void *))
      if not ptr1:
        raise Exception("malloc failed!")
      cdef __dtype1_myothertype tmp
      for i in range(3):
        tmp = var1[i]
        ptr1[i] = tmp._ptr
      dtype1_pxd.dtype1_mytype_my1_set(&self._ptr, ptr1)
      free(ptr1)
      
      
cdef class __dtype1_myothertype:
  cdef void *_ptr
  cdef bint _destroy
  
  def __cinit__(self, bint alloc = True):
    if alloc:
      dtype1_pxd.dtype1_alloc_myothertype(&self._ptr)
      self._destroy = True
    else:
      self._destroy = False
    
  def __dealloc__(self):
    if self._destroy:
      dtype1_pxd.dtype1_dealloc_myothertype(&self._ptr)
      
  property a1:
    def __get__(self):
      cdef int32_t var
      dtype1_pxd.dtype1_mytype_get_a1(&self._ptr, &var)
      return var
    def __set__(self,int32_t var):
      dtype1_pxd.dtype1_mytype_set_a1(&self._ptr, &var)


dtype1 = __dtype1()    

      