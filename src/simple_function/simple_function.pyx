cdef extern from "simple_function.h":
  cdef int myfunc_wrapper(int *a)

cdef class __simple_function:
  """module simple_function
contains
  myfunc()
end module"""
  def myfunc(self, int a):
    """b = myfunc(a)

Parameters
----------
a : int

Returns
-------
b : int
"""  
    return myfunc_wrapper(&a)
    
simple_function = __simple_function()