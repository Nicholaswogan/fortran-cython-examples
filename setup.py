from skbuild import setup

setup(
    name="fortran_cython_examples",
    version="0.1",
    description="a description",
    author='Nicholas Wogan',
    license="MIT",
    packages=['fortran_cython_examples'],
    install_requires=['cython','numpy'],
    cmake_args=['-DSKBUILD=ON']
)
