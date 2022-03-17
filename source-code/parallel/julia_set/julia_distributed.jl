#!/usr/bin/env julia

using ArgParse
using DelimitedFiles
using Distributed

# ensure that all processes load the JuliaSet package
@everywhere using JuliaSet: julia_compute_domain

function main()

    # handle command line arguments
    arg_parser = ArgParseSettings()
    arg_parser.description = "Compute the Julia set"
    @add_arg_table arg_parser begin
        "--nr_points", "-n"
            arg_type = Int
            required = true
            help = "number of points"

        "--nr_domains", "-d"
            arg_type = Int
            required = true
            help = "number of domains"

        "--file", "-f"
            arg_type = String
            required = false
            help = "file name to save result"

        "--verbose", "-v"
            action = :store_true
            help = "print verbose output"
    end
    options = parse_args(ARGS, arg_parser)

    if options["verbose"]
        println(stderr, "running with $(nworkers()) workers")
    end

    z0 = -1.8 - 1.8im
    C = 0.4 + 0.6im

    # compute Julia set
    @time result, exec_procs = julia_compute_domain(
        z0, C, options["nr_points"], options["nr_domains"]
    )

    # show distribution of domains over workers
    if options["verbose"]
        writedlm(stderr, exec_procs)
    end

    # write result to either file or standard output
    if haskey(options, "file")
        open(options["file"], "w") do file
            writedlm(file, result)
        end
    else
        writedlm(stdout, result)
    end

end

main()
