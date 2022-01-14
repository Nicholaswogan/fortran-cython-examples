module simple_subroutine_wrapper
  use iso_c_binding
  implicit none  
contains
  subroutine mysub_wrapper(a1, a2) bind(c)
    use simple_subroutine, only: sub => mysub
    integer(c_int), intent(in) :: a1
    integer(c_int), intent(out) :: a2
    call sub(a1, a2)
  end subroutine

  subroutine returns_arr1_wrapper(ptr, arr_len, arr) bind(c)
    type(c_ptr), intent(in) :: ptr
    integer(c_int), intent(in) :: arr_len
    integer(c_int), intent(out) :: arr(arr_len)
    
    integer(c_int), pointer :: arr_ptr(:)
    
    call c_f_pointer(ptr, arr_ptr, [arr_len])
    
    arr = arr_ptr
    deallocate(arr_ptr)
  end subroutine
  
  subroutine returns_arr1_len_wrapper(arr_len, ptr) bind(c)
    use simple_subroutine, only: sub => returns_arr1
    integer(c_int), intent(out) :: arr_len
    type(c_ptr), intent(out) :: ptr
    
    integer(c_int), allocatable, target :: arr(:)
    integer(c_int), pointer :: arr_ptr(:)

    call sub(arr)
    arr_len = size(arr)
    allocate(arr_ptr(arr_len))
    arr_ptr = arr
    ptr = c_loc(arr_ptr)
    
  end subroutine
  
end module