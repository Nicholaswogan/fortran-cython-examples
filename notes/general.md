# general notes

Fortran features that seem not wrap-able:

- Parameterized derived types. The type of attributes is not known at compile time. So C-interface is really hard.
- Pointers. They are sort-of possible to wrap if they are never allocated. But allocating will lead to leaks.
- `type(c_ptr)`