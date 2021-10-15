module simple_subroutine_wrapper
  use iso_c_binding
  implicit none  
contains
  subroutine mysub_wrapper(a, b) bind(c)
    use simple_subroutine, only: mysub
    implicit none
    integer(c_int), intent(in) :: a
    integer(c_int), intent(out) :: b
    call mysub(a, b)
  end subroutine
  
  subroutine returns_arr1_wrapper(arr_len, arr) bind(c)
    use simple_subroutine, only: returns_arr1
    integer(c_int), intent(in) :: arr_len
    integer(c_int), intent(out) :: arr(arr_len)
    integer(c_int), allocatable, target :: arr_copy(:)
    call returns_arr1(arr_copy)
    arr = arr_copy
  end subroutine
  
  subroutine returns_arr1_len_wrapper(arr_len) bind(c)
    use simple_subroutine, only: returns_arr1
    integer(c_int), intent(out) :: arr_len
    integer(c_int), allocatable :: arr(:)
    call returns_arr1(arr)
    arr_len = size(arr)
  end subroutine
  
end module