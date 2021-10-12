module mytype_wrapper
  use iso_c_binding
  use myobjects, only: Mytype, real_kind, err_len
  implicit none
  
contains
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! allocator and destroyer !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  subroutine allocate_Mytype(ptr) bind(c)
    type(c_ptr), intent(out) :: ptr
    type(Mytype), pointer :: my
    allocate(my)
    ptr = c_loc(my)
  end subroutine
  
  subroutine destroy_Mytype(ptr) bind(c)
    type(c_ptr), intent(in) :: ptr
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
    deallocate(my)
  end subroutine
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! getter and setter for arr !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  subroutine set_a(ptr, a) bind(c)
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(in) :: a
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
    my%a = a
  end subroutine
  
  subroutine get_a(ptr, a) bind(c)
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(out) :: a
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
    a = my%a 
  end subroutine
  
  subroutine set_arr(ptr, arr_size, arr) bind(c)
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
  
  subroutine get_arr_size(ptr, arr_size, alloc) bind(c)
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
  
  subroutine get_arr(ptr, arr_size, arr) bind(c)
    type(c_ptr), intent(in) :: ptr
    integer(c_int), intent(in) :: arr_size
    real(c_double), intent(out) :: arr(arr_size)
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    arr = my%arr
  end subroutine
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! wrappers for subroutines  !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  subroutine add2a_wrapper(ptr, b) bind(c)
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(in) :: b
  
    type(mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    call my%add2a(b)
  end subroutine
  
  subroutine printarr_wrapper(ptr, err) bind(c)
    type(c_ptr), intent(in) :: ptr
    character(kind=c_char), intent(out) :: err(err_len+1)
    character(len=err_len) :: errf
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
    call my%printarr(errf)
    call copy_string_ftoc(errf,err)
  end subroutine
  
  subroutine sumarr_wrapper(ptr, result, err) bind(c)
    type(c_ptr), intent(in) :: ptr
    real(c_double), intent(out) :: result
    character(len=c_char), intent(out) :: err(err_len+1)
    character(len=err_len) :: errf
  
    type(Mytype), pointer :: my
    call c_f_pointer(ptr, my)
  
    call my%sumarr(result, errf)
    call copy_string_ftoc(errf,err)
  end subroutine
  
  !!!!!!!!!!!!!!!!!!
  !!! Utilities  !!!
  !!!!!!!!!!!!!!!!!!
  
  subroutine copy_string_ctof(stringc,stringf)
  ! utility function to convert c string to fortran string
  character(len=*), intent(out) :: stringf
  character(c_char), intent(in) :: stringc(:)
  integer j
  stringf = ''
  char_loop: do j=1,min(size(stringc),len(stringf))
     if (stringc(j)==c_null_char) exit char_loop
     stringf(j:j) = stringc(j)
  end do char_loop
end subroutine copy_string_ctof

subroutine copy_string_ftoc(stringf,stringc)
  ! utility function to convert c string to fortran string
  character(len=*), intent(in) :: stringf
  character(c_char), intent(out) :: stringc(:)
  integer j,n
  n = len_trim(stringf)   
  do j=1,n    
    stringc(j) = stringf(j:j)   
  end do
  stringc(n+1) = c_null_char
end subroutine copy_string_ftoc
  
end module