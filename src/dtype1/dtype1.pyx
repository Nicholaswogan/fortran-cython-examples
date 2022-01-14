from numpy cimport import_array, ndarray, int8_t, int16_t, int32_t, int64_t
import numpy as np
cimport dtype1_pxd

cdef class __dtype1:
  property mytype:
    def __get__(self):
      return __dtype1_mytype

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

dtype1 = __dtype1()    

      