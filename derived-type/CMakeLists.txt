cmake_minimum_required(VERSION 3.5.0)
project(hello_cython LANGUAGES C Fortran)

option(SKBUILD "Should be ON of being build by skbuild, 
and OFF of being build by regular cmake" OFF)

if (NOT SKBUILD)
  set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/../cmake/")
endif()

find_package(PythonExtensions REQUIRED)
find_package(NumPy REQUIRED)
find_package(Cython REQUIRED)

add_library(myobjects src/myobjects.f90)

add_library(myobjects_wrapper MyProject/mytype_wrapper.f90 MyProject/myothertype_wrapper.f90)
target_link_libraries(myobjects_wrapper myobjects)

add_subdirectory(MyProject)

add_cython_target(_Mytype MyProject/_Mytype.pyx)
add_library(_Mytype MODULE ${_Mytype})
python_extension_module(_Mytype)
target_link_libraries(_Mytype myobjects_wrapper myobjects)
target_include_directories(_Mytype PUBLIC ${NumPy_INCLUDE_DIRS})

if (SKBUILD)
  install(TARGETS _Mytype LIBRARY DESTINATION MyProject)
else()
  install(TARGETS _Mytype DESTINATION ${CMAKE_CURRENT_SOURCE_DIR}/MyProject/)
endif()