module simple_functione_wrapper
  use iso_c_binding
  implicit none  
contains
  function myfunc_wrapper(a) result(b) bind(c)
    use simple_function, only: myfunc
    implicit none
    integer(c_int), intent(in) :: a
    integer(c_int) :: b
    b = myfunc(a)
  end function
end module