set(module_name simple_subroutine)
add_library(${module_name}_fortran ${module_name}.f90 ${module_name}_wrapper.f90)