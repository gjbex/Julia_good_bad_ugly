# Julia set

Code to compute the Julia set, implementations in Julia and Fortran.


## What is it?

1. `julia_set_mod.f90`: Fortran module containing the core algorithm.
1. `julia_set_omp_mod.f90`: Fortran module containing the core algorithm, OpenMP
   implementation.
1. `julia_set_omp.f90`: Fortran application to compute the Julia set, OpenMP
   implementation.
1. `CMakeLists.txt`: CMake file to build the Fortran applications.
1. `show_julia_set.py`: Python script to visualize the results.
1. `JuliaSet.jl`: Julia module implementing the Julia set computation algorithm.
1. `julia_distributed.ipynb`: Jupyter notebook illustrating running distributed
   code from a notebook.
