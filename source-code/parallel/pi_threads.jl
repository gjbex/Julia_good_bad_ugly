#!/usr/bin/env julia

function compute_pi(a::Float64, b::Float64, n::Int64)::Float64
    result = zeros(Threads.nthreads())
    delta = (b - a)/n
    Threads.@threads for i in 0:(n - 1)
        result[Threads.threadid()] += sqrt(1.0 - (a + i*delta)^2)
    end
    result *= 2.0*delta
    return sum(result)
end

function main()
    if length(ARGS) != 1
        error("expecting nr_points")
    end
    nr_threads = Threads.nthreads()
    println("running with $nr_threads threads")
    nr_points = parse(Int64, ARGS[1])
    println(compute_pi(-1.0, 1.0, nr_points))
end

main()
