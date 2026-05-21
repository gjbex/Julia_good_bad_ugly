The Julia programming language has gained quite some popularity
over the last couple of years.  What are its strong points, its
weak points?  Is it an elegant language to work with?  Should
you learn it, use it?

This training tries to give you some insights into the language
and how it compares to other similar programming languagues such
as MATLAB and Python so that you can answer these questions for
yourself.


## Learning outcomes

When you complete this training you will

  * write Julia expressions;
  * know how to write functions;
  * know the control flow statements;
  * know the data types that Julia supports;
  * learn how to design your code;
  * know how to do file I/O;
  * know how to organize and document your code;
  * learn about the Julia ecosystem;
  * learn about parallel programming with Julia.


## Schedule

Total duration: 4 hours.

  | Subject                                     | Duration |
  |---------------------------------------------|----------|
  | introduction and motivation                 |  5 min.  |
  | expressions                                 | 15 min.  |
  | functions and methods                       | 30 min.  |
  | control flow                                | 20 min.  |
  | coffee break                                | 10 min.  |
  | data types                                  | 60 min.  |
  | coffee break                                | 10 min.  |
  | I/O                                         | 10 min.  |
  | code organization                           | 15 min.  |
  | Julia ecosystem                             | 30 min.  |
  | wrap up                                     | 10 min.  |


## Training materials

Slides are available in the
 [GitHub repository](https://github.com/gjbex/Julia_good_bad_ugly),
as well as example code.


## Target audience

This training is for you if you want to learn some Julia to see whether
it would work for you.


## Prerequisites

You will need experience programming in some programming language such as Python,
MATLAB, R or C/C++/Fortran.  This is not a training that teaches you how to
program.

If you plan to do Julia programming in a Linux or HPC environment you should
be familiar with these as well.

More concretely, participants should already be comfortable with the following:

* variables, expressions, control flow, and writing functions in some other
  programming language;
* basic data structures such as arrays/lists, maps/dictionaries, or sets;
* reading short programs and understanding how data flows through them;
* basic problem decomposition into helper functions or modules;
* running scripts or notebooks at a basic level;
* compiling or running programs from the command line at a basic level;
* working in a shell environment well enough to edit files, run commands, and
  inspect output.

You do not need prior experience with Julia itself, multiple dispatch, Julia's
type system, modules, packages, macros, or parallel programming in Julia. Those
are part of the training itself.


### Quick self-assessment

If you can do most of the tasks below in some programming language, you are
likely ready for this training.

* write a function that computes the average of a list of numbers;
* loop over a collection and compute a derived result such as a sum or count;
* use `if`/`else` or a `switch`-like construct to classify values into cases;
* split a program into a few helper functions or files;
* read data from a text file and print a simple summary;
* run a script or notebook cell and inspect the result;
* read a short program and explain what it does;
* make a small change to an existing program and run it again.

If several of these items still feel difficult, the training will probably move
too fast. In that case, it is better to first take a short introductory
programming course.


### Software and access requirements

To follow hands-on, you need a computer with Julia installed. Some examples use
Jupyter notebooks through `IJulia`, so a working Jupyter environment is useful
as well.

The repository contains a Julia `Project.toml` and `Manifest.toml` for the
Julia package environment, and an `environment.yml` file for creating the
Python/Jupyter environment used for notebooks.

For examples that compare Julia with compiled languages or visualize generated
data, you may also need the standard development tools available in your Linux
or HPC environment.

See the repository's `SETUP.md` file for installation and verification
commands.


## Level

* Introductory: 40 %
* Intermediate: 40 %
* Advanced: 20 %


## Trainer(s)

  * Geert Jan Bex ([geertjan.bex@uhasselt.be](mailto:geertjan.bex@uhasselt.be))
