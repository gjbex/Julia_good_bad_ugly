#!/usr/bin/env julia

using Distributed

function compute_pi(a::Float64, b::Float64, n::Int64)::Float64
    result::Float64 = 0.0
    delta = (b - a)/n
    x::Float64 = a
    i::Int64 = 1
    while x < 1.0 && i <= n
        result += sqrt(1.0 - x^2)
        x += delta
        i += 1
    end
    result *= 2.0*delta
    println("($a, $b) -> $result, $n")
    return result
end

function main()
    if length(ARGS) != 2
        error("expecting nr_points and nr_workers as arguments")
    end
    nr_points = parse(Int64, ARGS[1])
    nr_workers = parse(Int, ARGS[2])
    if nr_workers == 0
        println(compute_pi(-1.0, 1.0, nr_points))
    else
        addprocs(nr_workers)
        @everywhere function compute_pi(a::Float64, b::Float64, n::Int64)::Float64
            result::Float64 = 0.0
            delta = (b - a)/n
            x::Float64 = a
            i::Int64 = 1
            while x < 1.0 && i <= n
                result += sqrt(1.0 - x^2)
                x += delta
                i += 1
            end
            result *= 2.0*delta
            println("($a, $b) -> $result, $n")
            return result
        end

        delta = 2.0/nr_workers
        result = @distributed (+) for i in 1:nr_workers
            @time compute_pi(-1.0 + (i - 1)*delta, -1.0 + i*delta, div(nr_points, nr_workers))
        end
        println(result)            
    end
end

main()
