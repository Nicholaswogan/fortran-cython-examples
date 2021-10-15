module characters_wrapper
  use iso_c_binding
  implicit none
contains
  
  subroutine characters_get_str1(str1_copy) bind(c)
    use characters, only: str1
    character(len=c_char), intent(out) :: str1_copy(20+1)
    call copy_string_ftoc(str1, str1_copy)
  end subroutine
  
  subroutine characters_set_str1(new_str1, str1_len) bind(c)
    use characters, only: str1
    character(len=c_char), intent(in) :: new_str1(str1_len+1)
    integer(c_int), intent(in) :: str1_len
    call copy_string_ctof(new_str1, str1)
  end subroutine
  
  subroutine characters_get_str2(str2_copy, str2_len) bind(c)
    use characters, only: str2
    character(len=c_char), intent(out) :: str2_copy(str2_len+1)
    integer(c_int), intent(in) :: str2_len
    call copy_string_ftoc(str2, str2_copy)
  end subroutine
  
  subroutine characters_get_str2_len(str2_len) bind(c)
    use characters, only: str2
    integer(c_int), intent(out) :: str2_len
    str2_len = len(str2)
  end subroutine
  
  subroutine characters_set_str2(new_str2, str2_len) bind(c)
    use characters, only: str2
    character(len=c_char), intent(in) :: new_str2(str2_len+1)
    integer(c_int), intent(in) :: str2_len
    if (allocated(str2)) deallocate(str2)
    allocate(character(str2_len) :: str2)
    call copy_string_ctof(new_str2, str2)
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