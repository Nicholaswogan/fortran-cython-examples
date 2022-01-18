# getters and setters

From `module_variable` and `dtype1`, looks like we get get and set all intrinsic types in modules and derived types with the following templates. Exception is characters. Still need to work on that

## Intrinsic module variable. Not a character. Not an array.

Fortran wrapper
```
  subroutine <module>_get_<variable>(var) bind(c)
    use <module>, only: a => <variable>
    <base_ftype>(<c_bindtype>), intent(out) :: var
    if (allocated(a)) then          ! IF ALLOCATBLE
      var = a                       ! indented IF ALLOCATBLE
    endif                           ! IF ALLOCATBLE
  end subroutine

  ! IF NOT PARAMETER, we make setter
  subroutine <module>_set_<variable>(var) bind(c)
    use <module>, only: a => <variable>
    <base_ftype>(<c_bindtype>), intent(in) :: var
    if (.not. allocated(a)) then             ! ]
      allocate(a)                            ! ] ONLY if allocatable
    endif                                    ! ]
    a = var
  end subroutine
```

##