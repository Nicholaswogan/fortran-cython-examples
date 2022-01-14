set(FORTRAN_MODULES simple_subroutine simple_function module_variable derived_type characters dtype1)

foreach (F_MODULE ${FORTRAN_MODULES})
  add_subdirectory(${F_MODULE})
endforeach()



set(module_name examples)

add_cython_target(_fortran_cython_examples _fortran_cython_examples.pyx)
add_library(_fortran_cython_examples MODULE ${_fortran_cython_examples})
python_extension_module(_fortran_cython_examples)

foreach (F_MODULE ${FORTRAN_MODULES})
  target_link_libraries(_fortran_cython_examples ${F_MODULE}_fortran)
endforeach()

target_include_directories(_fortran_cython_examples PUBLIC ${NumPy_INCLUDE_DIRS})

foreach (F_MODULE ${FORTRAN_MODULES})
  target_include_directories(_fortran_cython_examples PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/${F_MODULE})
endforeach()

if (SKBUILD)
  install(TARGETS _fortran_cython_examples LIBRARY DESTINATION fortran_cython_examples)
else()
  install(TARGETS _fortran_cython_examples DESTINATION ${CMAKE_SOURCE_DIR}/fortran_cython_examples/)
endif()