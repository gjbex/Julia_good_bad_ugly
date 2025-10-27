# Macros

Julia supports the use of macros for expression transformation or generation.
It is a powerful metaprogramming tool that allows you to manipulate code as
data.


## What is it?

1. `NestedCall`: a macro that nests a function call a given number of times, e.g.,
   `@nest 2 sin(1.0)` becomes `sin(sin(1.0))`.
