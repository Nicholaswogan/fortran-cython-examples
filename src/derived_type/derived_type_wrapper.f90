module derived_type_wrapper
  use iso_c_binding
  implicit none
  
contains
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! allocator and destroyer !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  subroutine allocate_Mytype(ptr) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(out) :: ptr
    type(Mytype), pointer :: my
    allocate(my)
    ptr = c_loc(my)
  end subroutine
  
  subroutine destroy_Mytype(ptr) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
    deallocate(my)
  end subroutine
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! getters and setters !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  subroutine mytype_set_a(ptr, var) bind(c)
    use derived_type, only: dtype => Mytype
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(in) :: var
    type(dtype), pointer :: t
    call c_f_pointer(ptr, t)
    t%a = var
  end subroutine
  
  subroutine mytype_get_a(ptr, a) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(out) :: a
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
    a = my%a 
  end subroutine
  
  subroutine mytype_set_arr(ptr, arr_size, arr) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int), intent(in) :: arr_size
    real(c_double), intent(in) :: arr(arr_size)
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    if (allocated(my%arr)) then
      deallocate(my%arr)
    endif
    allocate(my%arr(arr_size))
    my%arr = arr
  end subroutine
  
  subroutine mytype_get_arr_size(ptr, arr_size, alloc) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int), intent(out) :: arr_size
    logical(c_bool), intent(out) :: alloc
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    if (allocated(my%arr)) then
      arr_size = size(my%arr)
      alloc = .true.
    else
      arr_size = 0
      alloc = .false.
    endif
  
  end subroutine
  
  subroutine mytype_get_arr(ptr, arr_size, arr) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int), intent(in) :: arr_size
    real(c_double), intent(out) :: arr(arr_size)
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    arr = my%arr
  end subroutine
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! subroutine wrappers  !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  subroutine mytype_add2a_wrapper(ptr, b) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(in) :: b
  
    type(mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    call my%add2a(b)
  end subroutine
  
  subroutine mytype_printarr_wrapper(ptr) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
    call my%printarr()
  end subroutine
  
  subroutine mytype_sumarr_wrapper(ptr, result) bind(c)
    use derived_type, only: Mytype
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(out) :: result
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    call my%sumarr(result)
  end subroutine
  
end module