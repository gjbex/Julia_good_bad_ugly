# Code organization

How to organize Julia code.

## What is it?

1. `MyFunctions.jl`: module defining a few functions.
1. `compute.jl`: Julia script using the module.


## Remark

If you want to use a module in the directory of the script you are running,
don't forget to add the current working directory to the `JULIA_LOAD_PATH`
environment variable.

```bash
$ export JULIA_LOAD_PATH=".:$JULIA_LOAD_PATH"
```
