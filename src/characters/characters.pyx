from numpy cimport ndarray 
from libc.stdlib cimport malloc
from libc.stdlib cimport free

cdef extern from "characters.h":
  cdef void characters_get_str1(char *str1_copy);
  cdef void characters_set_str1(char *str1_copy, int *str1_len);
  
  cdef void characters_get_str2(char *str2_copy, int *str2_len);
  cdef void characters_get_str2_len(int *str2_len);
  cdef void characters_set_str2(char *new_str2, int *str2_len)
  
cdef class __characters: 
  """module characters
  character(len=20) :: str1
  character(len=:), allocatable :: str2
end module"""
  property str1:
    def __get__(self):
      cdef char str1_copy[20+1]
      characters_get_str1(str1_copy)
      return str1_copy
    def __set__(self, char* new_str1):
      cdef int str1_len = len(new_str1)
      characters_set_str1(new_str1, &str1_len)

  property str2:
    def __get__(self):
      cdef int str2_len
      characters_get_str2_len(&str2_len)
      cdef char* str2_copy = <char *> malloc((str2_len + 1) * sizeof(char))
      characters_get_str2(str2_copy, &str2_len)
      cdef bytes py_string
      py_string = str2_copy
      if str2_copy:
        free(str2_copy)
      return py_string
    def __set__(self, char* new_str2):
      cdef int str2_len = len(new_str2)
      characters_set_str2(new_str2, &str2_len)
      
      
      
characters = __characters()
