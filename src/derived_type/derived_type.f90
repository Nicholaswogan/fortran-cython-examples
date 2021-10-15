module derived_type
  implicit none
  private
  
  public :: Mytype
  
  integer, parameter :: real_kind =  kind(1.d0)
  
  type Mytype
    real(real_kind) :: a
    real(real_kind), allocatable :: arr(:)
  contains
    procedure :: add2a
    procedure :: sumarr
    procedure :: printarr
  end type
  
contains
  
  subroutine add2a(self, b)
    class(Mytype), intent(inout) :: self
    real(real_kind), intent(in) :: b
    self%a = self%a + b
  end subroutine
  
  subroutine printarr(self)
    class(Mytype), intent(in) :: self
    print*,self%arr
  end subroutine
  
  subroutine sumarr(self, result)
    class(Mytype), intent(in) :: self
    real(real_kind), intent(out) :: result
    result = sum(self%arr)
  end subroutine
    
end module