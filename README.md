# Julia: the good, the bad and the ugly

This repository contains Julia code and notebooks and is intended to get
familiar with the language.


## What is it?

1. `julia,_good_back_ugly.pptx`: Powerpoint presentation highlighting features
   of the Julia programming language.
1. `source-code`: Julia source code and notebooks.
1. `LICENSE`: license information for the material in this repository.
1. `CONTRIBUTING.md`: how to contirubte to this repository.


## How to?

To start a Julia notebook
```bash
$ julia
julia> using IJulia
julia> notebook()
```

If the `IJulia` package is not yet installed, you can do that using
```bash
$ julia
julia> using Pkg
julia> Pkg.add("IJulia")
```
