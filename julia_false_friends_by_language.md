# Julia false friends by programming background

This note highlights common stumbling blocks for researchers learning Julia
after using C, C++, Fortran, Python, R, or MATLAB. The goal is not to compare
languages in general, but to point out places where familiar habits can lead to
incorrect, inefficient, or unnecessarily complicated Julia.

The examples assume ordinary Julia for scientific and technical computing:
prefer clear functions, concrete data structures, multiple dispatch, standard
arrays, package environments, tests, and profiling before reaching for advanced
metaprogramming or low-level optimization.

## General Julia habits that help everyone

- Julia is dynamic at the language level, but performance often depends on
  type-stable functions and concrete data representation.
- Put performance-sensitive code inside functions. Global-scope exploratory
  code is convenient, but globals can make code slower and harder to reason
  about.
- Use multiple dispatch as a design tool. Prefer clear methods on meaningful
  types over large `if`/`else` blocks that inspect type manually.
- Julia arrays are one-based by default and use column-major storage.
- Assignment binds a name to a value; it does not copy arrays or mutable
  objects. Use `copy` or `deepcopy` deliberately when an independent object is
  needed.
- Mutating functions conventionally end in `!`, such as `sort!` or `push!`.
  The `!` is a warning by convention, not a different kind of function.
- `Vector{Float64}` is concrete and efficient. `Vector{Real}` and
  `Vector{Any}` are flexible but often slower because elements may have
  different concrete types.
- Broadcasting with `.` is explicit: `f.(x)`, `a .+ b`, and `x .= y` have
  different meanings from `f(x)`, `a + b`, and `x = y`.
- Package environments matter. Use `Project.toml` and `Manifest.toml` for
  reproducible training examples, notebooks, and scripts.
- Julia compiles methods just in time. The first call to a function can include
  compilation time, so distinguish first-run latency from steady-state runtime.

## From C

C programmers often recognize Julia's explicit loops, scalar arithmetic, and
ability to call low-level libraries. The false friend is assuming that Julia is
a scripting wrapper around C-style memory and types.

### False friends

- **Manual memory management**: Julia uses garbage collection. You usually do
  not allocate and free memory explicitly, although allocation patterns still
  matter for performance.
- **Pointers as ordinary data structures**: Julia can work with pointers for
  interoperability, but ordinary Julia code should use arrays, structs, and
  references to values rather than pointer-heavy designs.
- **Zero-based indexing**: C arrays are zero-based; standard Julia arrays are
  one-based. Use `eachindex`, `axes`, and `begin`/`end` when code should be
  robust to array indexing conventions.
- **Row-major layout**: C arrays are commonly row-major; Julia arrays are
  column-major. Loop order and interoperability with C libraries need care.
- **Struct layout assumptions**: Julia `struct` definitions model data, but
  their memory layout and mutability rules are not the same as C structs unless
  you deliberately design for C interoperability.
- **Macros for constants and small utilities**: Prefer functions, `const`
  bindings, generated data, and dispatch before writing macros.
- **Integer overflow expectations**: Julia machine integers have fixed widths
  and can overflow. Use checked arithmetic or wider numeric types when overflow
  matters.
- **Compile-time type thinking everywhere**: Julia specializes methods at
  runtime. You can write generic functions first, then inspect type stability
  and allocations where performance matters.

### Practical advice

Write clear Julia functions first. Use `@code_warntype`, `@time`,
`BenchmarkTools`, and profiling to find real performance issues before
rewriting code in a low-level style.

## From C++

C++ programmers often bring good instincts about value semantics, RAII,
templates, generic programming, and performance. The main surprise is that
Julia achieves generic behavior and specialization through dynamic multiple
dispatch rather than headers, templates, overload resolution, and compile-time
ownership rules.

### False friends

- **Classes with methods inside them**: Julia separates data definitions from
  functions. Methods belong to generic functions and dispatch on argument
  types, not to classes.
- **Inheritance for code reuse**: Julia's abstract types help organize dispatch,
  but concrete types cannot subtype concrete types. Prefer composition and
  generic functions over deep class hierarchies.
- **Templates as the model for generics**: Parametric types and methods provide
  generic programming, but Julia specializes methods just in time based on
  concrete argument types.
- **Function overloading intuition**: Julia methods with the same function name
  are normal and central, but dispatch is dynamic and can involve all arguments,
  not only a receiver object.
- **`const` as object immutability**: `const` in Julia applies to bindings,
  especially globals; it does not make a mutable object immutable. Immutable
  data is expressed with `struct` fields that cannot be reassigned.
- **RAII for resource management**: Julia has finalizers, but deterministic
  destruction is not the normal cleanup model. Use `open(...) do io ... end`,
  `try`/`finally`, and explicit close patterns for external resources.
- **Move semantics and ownership**: Julia names refer to values; assignment does
  not move or copy in the C++ sense. Mutability, aliasing, and copying must be
  handled explicitly.
- **Header/source separation**: Julia code is organized with modules, files,
  packages, and environments, not header declarations and separate compilation.
- **Operator overloading everywhere**: Julia lets you define methods for
  operators, but clear named functions are often better for domain-specific
  behavior unless the mathematical meaning is obvious.
- **Assuming generic containers are cheap**: `Vector{Any}` or abstractly typed
  fields can destroy type information and lead to dynamic dispatch in inner
  loops. Prefer concrete element and field types in performance-sensitive code.
- **Benchmarking compiled-style**: The first Julia call may include compilation.
  Use `BenchmarkTools.@btime` and avoid measuring setup or global-variable
  effects accidentally.

### Practical advice

Think in terms of functions plus dispatch, not objects owning methods. Design
small concrete types for data, write generic functions over them, and check
type stability only where it matters.

## From Fortran

Fortran programmers often find Julia's array orientation and numerical syntax
familiar. The false friends are mostly around performance assumptions, mutation,
and the fact that Julia is interactive and dynamically compiled.

### False friends

- **Array indexing and layout feel familiar but not identical**: Julia is
  one-based and column-major like Fortran, but array views, slices, and
  broadcasting have Julia-specific semantics.
- **Slicing as always cheap**: Ordinary slicing often copies. Use `@views`,
  `view`, or explicit loops when avoiding copies matters.
- **Whole-array operations as always allocation-free**: Expressions such as
  `a = b .+ c` allocate a new array. Use `a .= b .+ c` or explicit loops when
  updating existing storage.
- **Pass-by-reference assumptions**: Julia uses pass-by-sharing. Mutating a
  passed mutable object changes the caller-visible object, but rebinding the
  argument name inside a function does not.
- **Declarations as performance guarantees**: Type annotations can document
  intent and constrain APIs, but they do not automatically make code faster.
  Type-stable functions and concrete containers matter more.
- **Module expectations**: Julia modules organize namespaces and package code,
  but they are not Fortran modules. Package environments and precompilation are
  separate concepts.
- **Static compilation workflow**: Julia is usually run through a JIT-compiled,
  package-managed workflow rather than the traditional edit-compile-link cycle.
- **Assuming BLAS-like behavior for every array expression**: Julia uses BLAS
  for suitable linear algebra operations, but broadcasted scalar operations,
  custom array types, and generic loops have their own performance behavior.

### Practical advice

Use Julia's array syntax, but be deliberate about copies and views. For kernels,
write functions, benchmark them after compilation, and inspect allocations when
performance matters.

## From Python

Python programmers often expect dynamic behavior, notebooks, and a large
scientific ecosystem. Julia feels familiar in interactive use, but its
performance model is different.

### False friends

- **Lists versus arrays**: Python lists are flexible containers of references.
  Julia `Vector{T}` is a typed, contiguous array when `T` is concrete. Avoid
  accidentally building `Vector{Any}` for numerical work.
- **Zero-based indexing**: Python sequences are zero-based; Julia arrays are
  one-based.
- **Assignment and copying**: Like Python, assignment binds a name to an
  existing object. Mutating an array through one name is visible through other
  names bound to the same array.
- **Vectorization as the only fast style**: In Python, vectorization often means
  "move work into NumPy". In Julia, explicit loops can be fast when written in
  type-stable functions.
- **Duck typing without specialization concerns**: Generic Julia functions are
  natural, but unstable return types and abstract containers can harm
  performance.
- **Broadcasting syntax**: Python/NumPy broadcasting is implicit in many array
  expressions. Julia broadcasting is explicit with dots.
- **Package environments**: Julia environments are closer to project-local
  dependency specifications than a single global Python environment. Activate
  the right project before running training code.
- **Timing in notebooks**: The first run can include compilation. Rerun cells or
  use `BenchmarkTools` for meaningful timing.
- **Exceptions for ordinary control flow**: Julia has exceptions, but
  performance-sensitive code should avoid exception-driven inner loops.

### Practical advice

Do not translate NumPy habits mechanically. In Julia, clear scalar functions,
loops, broadcasting, and multiple dispatch can all be idiomatic; choose based on
clarity and measured performance.

## From R

R programmers often come from vectorized data analysis, statistical modeling,
and interactive workflows. Julia is also interactive, but it is more explicit
about mutation, dispatch, and package environments.

### False friends

- **Vectorization as the only idiom**: Julia supports vectorized and broadcasted
  code, but explicit loops can be clear and fast.
- **One-based indexing**: R and Julia are both one-based, but Julia ranges,
  slicing, views, and broadcasting have their own rules.
- **Recycling rules**: R may recycle shorter vectors. Julia generally does not
  use R-style recycling; shape mismatches are errors unless a broadcasting rule
  applies.
- **Missing values**: Julia has `missing`, but code must account for
  `Union{Missing, T}` and use functions such as `skipmissing`, `coalesce`, or
  package-specific missing-data support.
- **Copy-on-modify intuition**: Julia arrays are mutable and assignment does not
  copy. Use `copy` when independent storage is required.
- **Data frames as core language**: Julia's `DataFrames.jl` is a package, not a
  standard-language object. It is powerful, but numerical kernels may be better
  expressed with arrays or structs.
- **Formula interfaces everywhere**: Some Julia packages support statistical
  formulas, but many scientific APIs use functions, structs, and dispatch.
- **Type annotations as declarations like in static languages**: Julia can infer
  types in many cases. Annotate when it clarifies an API or enforces a contract,
  not as a reflex.

### Practical advice

Be explicit about mutation and missing values. Use data frames for tabular
analysis, but move performance-critical transformations into type-stable
functions over arrays or concrete data structures when needed.

## From MATLAB

MATLAB programmers often find Julia's numerical syntax approachable. The false
friends are subtle: Julia is not a MATLAB clone, and dot syntax, assignment,
packages, and performance have different rules.

### False friends

- **Matrix-first thinking everywhere**: Julia has excellent arrays, but it is a
  general-purpose language with structs, multiple dispatch, packages, and
  command-line workflows.
- **One-based indexing means all indexing habits transfer**: Julia is one-based,
  but ranges, Cartesian indexing, views, and custom array axes can differ from
  MATLAB expectations.
- **Element-wise operations**: MATLAB uses `.*`, `./`, and `.^`; Julia uses
  dotted calls and operators such as `.*`, `./`, `.^`, and `f.(x)`.
- **Implicit expansion assumptions**: Julia broadcasting is explicit and
  powerful, but the syntax and fusion behavior differ from MATLAB.
- **Slicing as a view**: MATLAB slicing creates arrays with MATLAB-specific copy
  behavior. Julia slicing often copies unless you use views.
- **Growing arrays interactively**: Julia lets you grow arrays, but repeated
  allocation in loops is still costly. Use preallocation or `push!` with
  suitable containers.
- **Scripts with shared workspace state**: Julia supports scripts and notebooks,
  but robust code should be organized into functions, modules, and packages.
- **Plotting as built-in core functionality**: Julia plotting is package-based.
  Choose and document the plotting package used by the project.

### Practical advice

Translate mathematical intent rather than MATLAB syntax. Pay special attention
to dotted operations, views versus copies, and whether code belongs in a
notebook cell, a function, or a package module.

## Cross-language traps in scientific Julia

### Numeric types and precision

- Be explicit about `Float32`, `Float64`, integer widths, and literals when
  precision or interoperability matters.
- `1 / 2` returns a floating-point value in Julia, while `div(1, 2)` or `1 ÷ 2`
  performs integer division.
- Machine integers can overflow. Use checked arithmetic, `BigInt`, or a wider
  type when overflow changes correctness.
- Floating-point equality is usually the wrong test for computed values; use
  tolerances appropriate to the problem.
- Mixed numeric types may promote automatically, but promotion rules are not a
  substitute for designing the numeric representation deliberately.

### Types, dispatch, and performance

- Abstract argument types are usually fine; abstract container element types and
  abstract struct fields are often performance problems.
- Type annotations do not automatically make Julia code faster. Type stability
  and concrete data layout matter more.
- Avoid changing the type of a variable inside a hot loop.
- Use `@code_warntype`, `@time`, `@allocated`, profiling, and
  `BenchmarkTools.@btime` to inspect performance rather than guessing.
- Separate setup, compilation, and steady-state timing when benchmarking.

### Mutation, copying, and views

- Assignment does not copy arrays.
- Mutating functions conventionally end in `!`.
- Slices often copy; use `view` or `@views` where a non-copying view is intended.
- Broadcasting with `.=` updates existing storage and can avoid temporary
  arrays.
- Aliasing can surprise you when two names refer to the same mutable object.

### Libraries and interoperability

- Julia's package ecosystem is central to scientific work. Record the active
  environment with `Project.toml` and `Manifest.toml`.
- Interoperability with C, Fortran, Python, R, MATLAB, or C++ can be valuable,
  but data layout, ownership, mutability, and calling conventions must be
  handled carefully.
- For HPC code, understand whether the project uses threads, distributed
  workers, MPI, GPUs, BLAS, or external compiled libraries before choosing the
  Julia abstraction.

## Summary table

| Background | Most likely false friend | Julia habit to develop |
| --- | --- | --- |
| C | Treating Julia as high-level C syntax | Write clear functions, use arrays and structs, and optimize from measurements |
| C++ | Translating classes, templates, RAII, and ownership directly | Design with functions, multiple dispatch, concrete types, and explicit cleanup patterns |
| Fortran | Assuming all array behavior and performance expectations transfer | Watch copies, views, broadcast allocation, and package workflow |
| Python | Expecting NumPy-style vectorization and global-environment habits | Use type-stable functions, explicit broadcasting, and project environments |
| R | Expecting R-style recycling, copy-on-modify, and data-frame-first semantics | Make mutation, missing values, and data representation explicit |
| MATLAB | Expecting MATLAB syntax and workspace habits | Use dotted operations, views, functions, modules, and packages deliberately |

## Teaching tip

When participants ask "what is the Julia equivalent of this feature?", first
identify whether they mean syntax, semantics, performance behavior, or workflow.
The best Julia answer is often not a direct translation, but a design that makes
data representation, dispatch, mutation, array layout, and package context
explicit.
