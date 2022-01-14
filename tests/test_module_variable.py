import numpy as np

try:
    from fortran_cython_examples import module_variable
except:
    import sys
    import os
    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    sys.path.append(os.path.dirname(SCRIPT_DIR))
    from fortran_cython_examples import module_variable

def test():
    module_variable.a1 = 1
    assert module_variable.a1 == 1