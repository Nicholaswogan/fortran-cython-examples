module module_variable
  implicit none
  public
  
  ! ignore if private
  ! read-only if protected or parameter
  ! read-write otherwise
  
  integer :: a1
  integer, parameter :: a2 = 3
  integer, allocatable :: a3
  
  integer :: arr1(8)
  integer, parameter :: arr2(3) = [1,2,3]
  integer, allocatable :: arr3(:)
  
  type :: mytype
    integer :: a1
  end type
  
  ! characters. Work in progress
  
  character(len=20) :: str1
  character(len=:), allocatable :: str2
  
  character(len=20) :: str3(3)
  character(len=20), allocatable :: str4(:)

  
  ! to be investigated:
  character(len=20), parameter :: str1_2 = "Hello2" 
  character(len=*), parameter :: str1_3 = "Hello3"
  character(len=*), parameter :: str5(3) = ["hi",'hi','hi']
  
end module