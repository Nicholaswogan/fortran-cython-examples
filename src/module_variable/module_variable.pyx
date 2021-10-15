cdef extern from "module_variable.h":
  cdef void get_a(int *a)
  cdef void set_a(int *a)
  
cdef class __module_variable: 
  """module module_variable
  integer :: a
end module"""
  property a:
    def __get__(self):
      cdef int a
      get_a(&a)
      return a
    def __set__(self, int a):
      set_a(&a)
      
module_variable = __module_variable()
