set(module_name dtype1)
add_library(${module_name}_fortran ${module_name}.f90 ${module_name}_wrapper.f90)