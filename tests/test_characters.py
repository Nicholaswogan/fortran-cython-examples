import numpy as np

try:
    from fortran_cython_examples import characters
except:
    import sys
    import os
    SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
    sys.path.append(os.path.dirname(SCRIPT_DIR))
    from fortran_cython_examples import characters

def test():
    characters.str1 = b'hello1'
    assert characters.str1 == b'hello1'
    
    characters.str2 = b'hello2'
    assert characters.str2 == b'hello2'