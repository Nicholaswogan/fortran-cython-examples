module simple_subroutine
  implicit none
contains
  subroutine mysub(a, b)
    integer, intent(in) :: a
    integer, intent(out) :: b
    b = a + 1
  end subroutine
  
  ! this seems hard to wrap. best idea is to call it two times
  ! one to get dimension and another time to get the array.
  subroutine returns_arr1(arr)
    integer, allocatable, intent(out) :: arr(:)
    allocate(arr(10))
    arr = 12
  end subroutine
  
  subroutine returns_arr2(arr)
    integer, intent(out) :: arr(:)
    arr = 14
  end subroutine
end module