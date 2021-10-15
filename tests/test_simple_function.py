import numpy as np

try:
    from fortran_cython_examples import simple_function
except:
    import sys
    import os
    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    sys.path.append(os.path.dirname(SCRIPT_DIR))
    from fortran_cython_examples import simple_function

def test():
    assert simple_function.myfunc(1) == 2

    assert simple_function.myfunc(1.0) == 2

    assert simple_function.myfunc(np.array(1)) == 2

    try:
        simple_function.myfunc(np.array([1,2,3]))
    except TypeError as e:
        assert str(e) == "only size-1 arrays can be converted to Python scalars"