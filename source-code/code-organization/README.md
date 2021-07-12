# Code organization

How to organize Julia code.

## What is it?

1. `MyFunctions.jl`: module defining a few functions.
1. `compute_fact.jl`: Julia script using the module.
1. `run_compute_fact.sh`: Bash script illustrating how to run a Juiia script
   that uses a local module.
1. `Gcd`: Julia package with a single module.
1. `compute_gcd.jl`: Julia script using the `my_gcd` function in the `Gcd` package.
1. `run_compute_gcd.sh`: Bash script illustrating how to run a Juiia script
   that uses a local package.
1. `documentation.ipynb`: Jupyter notebook illustrating Julia function documentation.
   The documented function is in the `Gcd` module.


## Remark

If you want to use a module in the directory of the script you are running,
don't forget to add the current working directory to the `JULIA_LOAD_PATH`
environment variable.

```bash
$ export JULIA_LOAD_PATH=".:$JULIA_LOAD_PATH"
```
