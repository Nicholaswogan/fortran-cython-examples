module dtype1_wrapper
  use iso_c_binding
  implicit none
  
contains
  
  subroutine dtype1_alloc_mytype(ptr) bind(c)
    use dtype1, only: dtype => mytype
    type(c_ptr), intent(out) :: ptr
    type(dtype), pointer :: t
    allocate(t)
    ptr = c_loc(t)
  end subroutine
  
  subroutine dtype1_dealloc_mytype(ptr) bind(c)
    use dtype1, only: dtype => mytype
    type(c_ptr), intent(in) :: ptr
    type(dtype), pointer :: t
    call c_f_pointer(ptr, t)
    deallocate(t)
  end subroutine

  subroutine dtype1_mytype_get_a1(ptr, var) bind(c)
    use dtype1, only: dtype => mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int32_t), intent(out) :: var
    type(dtype), pointer :: t
    call c_f_pointer(ptr, t)
    var = t%a1
  end subroutine
  
  subroutine dtype1_mytype_set_a1(ptr, var) bind(c)
    use dtype1, only: dtype => mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int32_t), intent(in) :: var
    type(dtype), pointer :: t
    call c_f_pointer(ptr, t)
    t%a1 = var
  end subroutine
  
  subroutine dtype1_mytype_get_arr3_size(ptr, dim1) bind(c)
    use dtype1, only: dtype => mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int32_t), intent(out) :: dim1
    type(dtype), pointer :: t
    call c_f_pointer(ptr, t)
    if (allocated(t%arr3)) then
      dim1 = size(t%arr3,1)
    else
      dim1 = 0
    endif
  end subroutine
  
  subroutine dtype1_mytype_get_arr3(ptr, dim1, var) bind(c)
    use dtype1, only: dtype => mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int32_t), intent(in) :: dim1
    integer(c_int32_t), intent(out) :: var(dim1)
    type(dtype), pointer :: t
    call c_f_pointer(ptr, t)
    if (allocated(t%arr3)) then
      var = t%arr3
    endif
  end subroutine
  
  subroutine dtype1_mytype_set_arr3(ptr, dim1, var) bind(c)
    use dtype1, only: dtype => mytype
    type(c_ptr), intent(in) :: ptr
    integer(c_int32_t), intent(in) :: dim1
    integer(c_int32_t), intent(in) :: var(dim1)
    type(dtype), pointer :: t
    call c_f_pointer(ptr, t)
    if (allocated(t%arr3)) deallocate(t%arr3)
    allocate(t%arr3(dim1))
    t%arr3 = var
  end subroutine
  
end module