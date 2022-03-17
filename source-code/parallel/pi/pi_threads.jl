#!/usr/bin/env julia

using ArgParse

function compute_pi(a::Float64, b::Float64, n::Int64)::Float64
    result = zeros(Threads.nthreads())
    delta = (b - a)/n
    Threads.@threads for i in 0:(n - 1)
        result[Threads.threadid()] += sqrt(1.0 - (a + i*delta)^2)
    end
    return 2.0*delta*sum(result)
end

function main()
    arg_parser = ArgParseSettings()
    arg_parser.description = "Compute pi using a quadrature method on multiple threads"
    @add_arg_table arg_parser begin
        "n"
            help = "number of point for the quadrature method"
            arg_type = Int64
            required = true
    end
    options = parse_args(ARGS, arg_parser)
    nr_threads = Threads.nthreads()
    println("running with $nr_threads threads")
    nr_points = options["n"]
    println(compute_pi(-1.0, 1.0, nr_points))
end

main()
