module module_variable_wrapper
  use iso_c_binding
  implicit none
contains
  
  subroutine get_a(a_copy) bind(c)
    use module_variable, only: a
    integer(c_int), intent(out) :: a_copy
    a_copy = a
  end subroutine
  
  subroutine set_a(new_a) bind(c)
    use module_variable, only: a
    integer(c_int), intent(in) :: new_a
    a = new_a
  end subroutine
end module