module dtype1
  implicit none
  private
  
  public :: mytype
  
  type :: mytype
    integer :: a1
    integer, allocatable :: arr3(:)
  end type
  
  ! Purpose of this simple type is to consider how to implement
  ! getters and setters for cython wrappers.
  
  ! looks like they are almost identical to getters and setters for 
  ! fortran modules, except a pointer is passed around.
    
end module