module myothertype_wrapper
  use iso_c_binding
  use myobjects, only: myothertype, mytype
  implicit none
  
contains
  
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  !!! allocator and destroyer !!!
  !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  
  subroutine allocate_myothertype(ptr, my_ptr) bind(c)
    type(c_ptr), intent(out) :: ptr
    type(c_ptr), intent(out) :: my_ptr
    
    type(myothertype), pointer :: myother
    
    allocate(myother)
    ptr = c_loc(myother)
    my_ptr = c_loc(myother%my)
  end subroutine
  
  subroutine destroy_myothertype(ptr) bind(c)
    type(c_ptr), intent(in) :: ptr
    type(myothertype), pointer :: myother
    call c_f_pointer(ptr, myother)
    
    deallocate(myother)
  end subroutine
  
end module