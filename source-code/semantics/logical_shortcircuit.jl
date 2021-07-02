#!/usr/bin/env julia

function fact(n::Int)::Int
    n >= 0 || error("fact argument must be positive")
    n <= 1 && return 1
    return n*fact(n - 1)
end

for n in 5:-1:-1
    print("fact($n) = ")
    println(fact(n))
end
