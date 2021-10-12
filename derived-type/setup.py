from skbuild import setup

setup(
    name="MyProject",
    version="0.1",
    description="a description.",
    author='Nicholas Wogan',
    license="MIT",
    packages=['MyProject'],
    install_requires=['cython','numpy'],
    cmake_args=['-DSKBUILD=ON']
)
