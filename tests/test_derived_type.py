import numpy as np

try:
    from fortran_cython_examples import derived_type
except:
    import sys
    import os
    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    sys.path.append(os.path.dirname(SCRIPT_DIR))
    from fortran_cython_examples import derived_type

mytype = derived_type.mytype

def test():
    my = mytype()

    my.a = 2.0
    assert my.a  == 2.0

    my.add2a(100.0)
    assert my.a  == 102.0

    my.arr = np.array([1,2,3])
    assert np.all(my.arr == np.array([1,2,3]))
    assert my.sumarr() == 6.0


    my1 = mytype()

    my1.a = 1
    my.a = 2

    assert my1.a != my.a
