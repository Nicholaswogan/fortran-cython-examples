module myobjects
  implicit none
  
  private
  public :: Mytype, Myothertype, err_len, real_kind
  
  integer, parameter :: real_kind =  kind(1.d0)
  integer, parameter :: err_len =  1024
  
  type Mytype
    real(real_kind) :: a
    real(real_kind), allocatable :: arr(:)
  contains
    procedure :: add2a
    procedure :: sumarr
    procedure :: printarr
  end type
  
  type Myothertype
    type(Mytype) :: my
  end type
  
contains
  
  subroutine add2a(self, b)
    class(Mytype), intent(inout) :: self
    real(real_kind), intent(in) :: b
    self%a = self%a + b
  end subroutine
  
  subroutine printarr(self, err)
    class(Mytype), intent(in) :: self
    character(len=err_len), intent(out) :: err
    err = ""
    if (.not.allocated(self%arr)) then
      err = 'arr not allocated'
      return
    end if
    print*,self%arr
  end subroutine
  
  subroutine sumarr(self, result, err)
    class(Mytype), intent(in) :: self
    real(real_kind), intent(out) :: result
    character(len=err_len), intent(out) :: err
    err = ""
    if (.not.allocated(self%arr)) then
      err = 'arr not allocated'
      return
    endif    
    result = sum(self%arr)
  end subroutine
    
end module