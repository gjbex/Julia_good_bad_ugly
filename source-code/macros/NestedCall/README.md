# NestedCall

An illustration of how to build an expression using Julia macros.  Note that this
particular macro is only intended to illustrate the concept.  In practice, it would
be better to implement this using a function rather than a macro.  The reasons are:

* to benefit from the macro, the nesting level has to be known at compile time,
  which limits its usefulness;
* the resulting AST is more difficult to optimize for the compiler, and can, at
  least for deep nesting levels, lead to a very deep AST that can cause stack
  overflows during compilation.


## What is it?

1. `src/NestedCall.jl`: a module containing the definition of the `@nest` macro.
1. `nested_calls.ipynb`: a Jupyter notebook illustrating how to use the macro.
1. `Project.toml`: the project file for the package.
