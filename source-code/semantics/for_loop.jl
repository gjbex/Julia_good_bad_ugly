#!/usr/bin/env julia

function fact(n::Int)::Int64
    result = 1
    for i in 2:n
        result *= i
    end
    return result
end

for n in 0:5
    println("fact($n) = $(fact(n))")
end
