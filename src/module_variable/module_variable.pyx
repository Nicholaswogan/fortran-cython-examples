
from numpy cimport import_array, ndarray, int8_t, int16_t, int32_t, int64_t
import numpy as np
cimport module_variable_pxd

#################
### utilities ###
#################
cdef pystring2cstring(str pystring):
  # add a null c char, and convert to byes
  cdef bytes cstring = (pystring+'\0').encode('utf-8')
  return cstring

  
cdef class __module_variable: 
  
  property a1:
    def __get__(self):
      cdef int32_t var
      module_variable_pxd.module_variable_get_a1(&var)
      return var
    def __set__(self, int32_t var):
      module_variable_pxd.module_variable_set_a1(&var)
      
  property a2:
    def __get__(self):
      cdef int32_t var
      module_variable_pxd.module_variable_get_a2(&var)
      return var
      
  property a3:
    def __get__(self):
      cdef int32_t var
      module_variable_pxd.module_variable_get_a3(&var)
      return var
    def __set__(self, int32_t var):
      module_variable_pxd.module_variable_set_a3(&var)
            
# template is
#
#  property <variable>:
#    def __get__(self):
#      cdef <cython_type> var
#      <pdx_file>.<getter_name>(&var)
#      return var
#    def __set__(self, <cython_type> var):
#      <pdx_file>.<setter_name>(&var)
      
  property arr1:
    def __get__(self):
      cdef ndarray var = np.empty((8,), np.int32)
      module_variable_pxd.module_variable_get_arr1(<int32_t *>var.data)
      return var
    def __set__(self, ndarray[int32_t, ndim=1] var):
      cdef int32_t dim1 = var.shape[0]
      shape = (dim1,)
      if (8,) != shape:
        raise ValueError("arr1 must have shape (8,), but got "+str(shape))
      module_variable_pxd.module_variable_set_arr1(<int32_t *>var.data)
      
  property arr2:
    def __get__(self):
      cdef ndarray var = np.empty((3,), np.int32)
      module_variable_pxd.module_variable_get_arr2(<int32_t *>var.data)
      return var
      
  property arr3:
    def __get__(self):
      cdef int32_t dim1
      module_variable_pxd.module_variable_get_arr3_size(&dim1)
      cdef ndarray var = np.empty((dim1,), np.int32)
      module_variable_pxd.module_variable_get_arr3(&dim1, <int32_t *>var.data)
      return var
    def __set__(self, ndarray[int32_t, ndim=1] var):
      cdef int32_t dim1 = var.shape[0]
      module_variable_pxd.module_variable_set_arr3(&dim1, <int32_t *>var.data)
      
  property str1:
    def __get__(self):
      cdef char var[20+1]
      module_variable_pxd.module_variable_get_str1(var)
      return var.decode('utf-8')
    def __set__(self, str var):
      cdef int32_t len1 = len(var)
      cdef bytes var_b = pystring2cstring(var)
      cdef char *var_c = var_b
      module_variable_pxd.module_variable_set_str1(&len1, var_c)
      
  property str2:
    def __get__(self):
      cdef int32_t len1
      module_variable_pxd.module_variable_get_str2_len(&len1)
      cdef ndarray var = np.zeros((),dtype=np.dtype(('S', len1)),order='F')
      module_variable_pxd.module_variable_get_str2(&len1, <char *>var.data)
      return var.item().decode()
    def __set__(self, str var):
      cdef int32_t len1 = len(var)
      cdef bytes var_b = pystring2cstring(var)
      cdef char *var_c = var_b
      module_variable_pxd.module_variable_set_str2(&len1, var_c)
      
      
  property str4:
    def __get__(self):
      cdef int32_t dim1
      cdef int32_t len1 = 20;
      module_variable_pxd.module_variable_get_str4_size(&dim1)
      cdef ndarray var = np.empty((dim1),dtype=np.dtype(('S', len1)),order='F')
      module_variable_pxd.module_variable_get_str4(&len1, &dim1, <char *> var.data)
      return var
    def __set__(self, ndarray var1):
      if var1.dtype != np.dtype(('S', 20)):
        raise ValueError("str4 must be type")
      
      # print(var)
      cdef int32_t dim1 = var1.shape[0]
      cdef int32_t len1 = 20;
      # cdef ndarray var1 = np.empty((dim1),dtype=np.dtype(('S', len1)),order='F')
      # var1[0] = "{:20}".format("hello")
      # var1[1] = "{:20}".format("nias")
      module_variable_pxd.module_variable_set_str4(&len1, &dim1, <char *> var1.data)
      
    
      
module_variable = __module_variable()







