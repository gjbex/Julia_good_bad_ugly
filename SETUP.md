# Environment Setup

This document describes how to set up the software environment for the
training material. It assumes that you have access to a Linux-style terminal
and are comfortable running shell commands.

The setup has three parts:

- Julia, preferably installed and managed with `juliaup`.
- Julia packages, restored from `Project.toml` and `Manifest.toml`.
- Jupyter support for the notebook examples, using the Python environment in
  `environment.yml` and the Julia `IJulia` package.

Some performance and parallel examples also compare Julia with Fortran code.
Those examples require extra compiler and build tools, but they are not needed
for the basic Julia examples.


## Julia Toolchain With `juliaup`

The recommended way to install Julia is `juliaup`, the Julia version manager.
Use the platform-specific installation instructions from the official Julia
installation page:

<https://julialang.org/install/>

After installation, check that Julia is available:

```bash
julia --version
```

Check the installed Julia channels with:

```bash
juliaup status
```

For this training, the current stable Julia release is appropriate. If you need
to update Julia later, use:

```bash
juliaup update
```

If you already have Julia installed without `juliaup`, that is also fine as
long as `julia` is available on your `PATH`.


## Julia Package Environment

The repository contains a Julia package environment in `Project.toml` and
`Manifest.toml`. From the repository root, instantiate it with:

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

You can inspect the active environment with:

```bash
julia --project=. -e 'using Pkg; Pkg.status()'
```


## Checking A Julia Example

After installing Julia, verify the setup with a small script:

```bash
julia source-code/hello_world.jl
```

You should see:

```text
hello world!
```

To run commands inside the repository environment, use `--project=.` from the
repository root:

```bash
julia --project=.
```

Inside the Julia REPL, you can load packages from the training environment:

```julia
using Pkg
Pkg.status()
```


## Python And Jupyter Environment With `mamba`

The notebook examples use Jupyter. The required Python packages for JupyterLab
are listed in the top-level `environment.yml` file.

Install `mamba` through Miniforge if it is not already available. Then create
the environment from the repository root:

```bash
mamba env create -f environment.yml
```

The environment name is defined in the file:

```yaml
name: julia
```

Activate it with:

```bash
mamba activate julia
```

Check that Jupyter is available:

```bash
jupyter lab --version
```


## IJulia

`IJulia` connects Julia to Jupyter notebooks. Install it from Julia with:

```bash
julia -e 'using Pkg; Pkg.add("IJulia")'
```

Recent Julia versions may offer to install `IJulia` automatically the first
time you try to use it.

To start a notebook session from Julia:

```bash
julia --project=.
```

Then run:

```julia
using IJulia
notebook()
```

Alternatively, after activating the `mamba` environment, start JupyterLab from
the shell:

```bash
jupyter lab
```


## Optional Compiled-Language Examples

Some examples under `source-code/performance` and `source-code/parallel`
compare Julia implementations with Fortran implementations. To build those
examples, you may need:

- a Fortran compiler such as `gfortran`;
- CMake;
- standard build tools for your Linux distribution or HPC environment.

These tools are only needed for the comparison examples. They are not required
for the introductory Julia scripts and notebooks.


## Updating The Environments

If the Julia `Project.toml` or `Manifest.toml` changes later, restore the Julia
environment again with:

```bash
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```

If `environment.yml` changes later, update the Python/Jupyter environment with:

```bash
mamba env update -f environment.yml --prune
```


## Useful References

- Julia installation: <https://julialang.org/install/>
- juliaup: <https://github.com/JuliaLang/juliaup>
- Julia package manager: <https://pkgdocs.julialang.org/>
- IJulia: <https://julialang.github.io/IJulia.jl/stable/>
- JupyterLab: <https://jupyterlab.readthedocs.io/>
- Miniforge releases: <https://github.com/conda-forge/miniforge/releases>
