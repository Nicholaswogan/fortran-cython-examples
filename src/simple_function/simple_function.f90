module simple_function
  implicit none
contains
  function myfunc(a) result(b)
    integer, intent(in) :: a
    integer :: b
    b = a + 1
  end function
end module