module module_variable_wrapper
  use iso_c_binding
  implicit none
  
contains
  
  !!!!!!!!!!!!!!!!!
  !!! variables !!!
  !!!!!!!!!!!!!!!!!
  
  ! integer :: a1
  subroutine module_variable_get_a1(var) bind(c)
    use module_variable, only: a => a1
    integer(c_int32_t), intent(out) :: var
    var = a
  end subroutine
  
  subroutine module_variable_set_a1(var) bind(c)
    use module_variable, only: a => a1
    integer(c_int32_t), intent(in) :: var
    a = var
  end subroutine
  
  ! integer, parameter :: a2 = 3
  subroutine module_variable_get_a2(var) bind(c)
    use module_variable, only: a => a2
    integer(c_int32_t), intent(out) :: var
    var = a
  end subroutine
  
  ! integer, allocatable :: a3
  subroutine module_variable_get_a3(var) bind(c)
    use module_variable, only: a => a3
    integer(c_int32_t), intent(out) :: var
    if (allocated(a)) then
      var = a
    endif
  end subroutine
  
  subroutine module_variable_set_a3(var) bind(c)
    use module_variable, only: a => a3
    integer(c_int32_t), intent(in) :: var
    if (.not. allocated(a)) then
      allocate(a)
    endif
    a = var
  end subroutine
  
  ! We can wrap any intrinsic type with the
  ! following template
  
  ! subroutine <module>_get_<variable>(var) bind(c)
  !   use <module>, only: a => <variable>
  !   <base_ftype>(<c_bindtype>), intent(out) :: var
  !   if (allocated(a)) then          ! IF ALLOCATBLE
  !     var = a                       ! indented IF ALLOCATBLE
  !   endif                           ! IF ALLOCATBLE
  ! end subroutine
  ! 
  ! IF NOT PARAMETER, we make setter
  ! subroutine <module>_set_<variable>(var) bind(c)
  !   use <module>, only: a => <variable>
  !   <base_ftype>(<c_bindtype>), intent(in) :: var
  !   if (.not. allocated(a)) then             ! ]
  !     allocate(a)                            ! ] ONLY if allocatable
  !   endif                                    ! ]
  !   a = var
  ! end subroutine

  !!!!!!!!!!!!!!
  !!! arrays !!!
  !!!!!!!!!!!!!!
  
  ! integer :: arr1(8)
  subroutine module_variable_get_arr1(var) bind(c)
    use module_variable, only: a => arr1
    integer(c_int32_t), intent(out) :: var(8)
    var = a
  end subroutine
  
  subroutine module_variable_set_arr1(var) bind(c)
    use module_variable, only: a => arr1
    integer(c_int32_t), intent(in) :: var(8)
    a = var
  end subroutine
  
  ! integer, parameter :: arr2(3) = [1,2,3]
  subroutine module_variable_get_arr2(var) bind(c)
    use module_variable, only: a => arr2
    integer(c_int32_t), intent(out) :: var(3)
    var = a
  end subroutine
  
  ! fixed-sized arrays have the following template
  !
  ! subroutine <module>_get_<variable>(var) bind(c)
  !   use <module>, only: a => <variable>
  !   <base_ftype>(<c_bindtype>), intent(out) :: var(<dimensions>)
  !   var = a
  ! end subroutine
  ! 
  ! subroutine <module>_set_<variable>(var) bind(c)
  !   use <module>, only: a => <variable>
  !   <base_ftype>(<c_bindtype>), intent(in) :: var(<dimensions>)
  !   a = var
  ! end subroutine
  
  ! integer, allocatable :: arr3(:)
  subroutine module_variable_get_arr3_size(dim1) bind(c)
    use module_variable, only: a => arr3
    integer(c_int32_t), intent(out) :: dim1
    if (allocated(a)) then
      dim1 = size(a,1)
    else
      dim1 = 0
    endif
  end subroutine
  
  subroutine module_variable_get_arr3(dim1, var) bind(c)
    use module_variable, only: a => arr3
    integer(c_int32_t), intent(in) :: dim1
    integer(c_int32_t), intent(out) :: var(dim1)
    if (allocated(a)) then
      var = a
    endif
  end subroutine
  
  subroutine module_variable_set_arr3(dim1, var) bind(c)
    use module_variable, only: a => arr3
    integer(c_int32_t), intent(in) :: dim1
    integer(c_int32_t), intent(in) :: var(dim1)
    if (allocated(a)) deallocate(a)
    allocate(a(dim1))
    a = var
  end subroutine
  
  ! allocatable arrays have the above unique template
  
  ! integer, real
  ! any kind
  ! allocatable, parameter, default
  ! 0-dimension or n-dimension
  !
  ! Fit into the above 3 templates 
  
  
  
  ! work in progress...
  
  !!!!!!!!!!!!!!!!!!
  !!! characters !!!
  !!!!!!!!!!!!!!!!!!
  
  subroutine module_variable_get_str1(var) bind(c)
    use module_variable, only: a => str1
    character(kind=c_char), intent(out) :: var(20+1)
    call copy_string_ftoc(a, var)
  end subroutine
  
  subroutine module_variable_set_str1(len1, var) bind(c)
    use module_variable, only: a => str1
    integer(c_int32_t), intent(in) :: len1
    character(kind=c_char), intent(in) :: var(len1+1)
    call copy_string_ctof(var, a)
  end subroutine
  
  subroutine module_variable_get_str2_len(len1) bind(c)
    use module_variable, only: a => str2
    integer(c_int32_t), intent(out) :: len1
    if (allocated(a)) then
      len1 = len(a)
    else
      len1 = 0
    endif
  end subroutine
  
  subroutine module_variable_get_str2(len1, var) bind(c)
    use module_variable, only: a => str2
    integer(c_int32_t), intent(in) :: len1
    character(kind=c_char), intent(out) :: var(len1+1)
    if (allocated(a)) then
      call copy_string_ftoc(a, var)
    endif
  end subroutine
  
  subroutine module_variable_set_str2(len1, var) bind(c)
    use module_variable, only: a => str2
    integer(c_int32_t), intent(in) :: len1
    character(kind=c_char), intent(in) :: var(len1+1)
    if (allocated(a)) deallocate(a)
    allocate(character(len1) :: a)
    call copy_string_ctof(var, a)
  end subroutine
  
  subroutine module_variable_get_str4_size(dim1) bind(c)
    use module_variable, only: str4
    integer(c_int32_t), intent(out) :: dim1
    if (allocated(str4)) then
      dim1 = size(str4,1)
    else
      dim1 = 0
    endif
  end subroutine
  
  subroutine module_variable_get_str4(len1, dim1, var) bind(c)
    use module_variable, only: str4
    integer(c_int32_t), intent(in) :: len1
    integer(c_int32_t), intent(in) :: dim1
    character(kind=c_char), intent(out) :: var(len1*dim1+1)
    integer :: k, i1, i2
    
    if (allocated(str4)) then
      do i2 = 1,dim1
        do i1 = 1,len1
          k = (i2-1)*len1+i1
          var(k) = str4(i2)(i1:i1)
        enddo
      enddo
    endif
  end subroutine
  
  subroutine module_variable_set_str4(len1, dim1, var) bind(c)
    use module_variable, only: str4
    integer(c_int32_t), intent(in) :: len1
    integer(c_int32_t), intent(in) :: dim1
    character(kind=c_char), intent(in) :: var(len1*dim1)
    integer :: k, i1, i
    
    if (allocated(str4)) deallocate(str4)
    allocate(str4(dim1))
    str4 = ""
    do i1 = 1,dim1
      k = (i1-1)*len1+1
      call copy_string_ctof(var(k:k+len1), str4(i1)(1:len1))
    enddo
    
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