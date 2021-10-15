set(module_name characters)
add_library(${module_name}_fortran ${module_name}.f90 ${module_name}_wrapper.f90)