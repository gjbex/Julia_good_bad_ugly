#!/usr/bin/env julia

function fact(n::Int)::Int64
    n >= 0 || throw(DomainError(n, "argument must be positive"))
    result = 1
    for i in 2:n
        result *= i
    end
    return result
end

for n in 5:-1:-2
    try
        println("fact($n) = $(fact(n))")
    catch err
        if isa(err, DomainError)
            println("sorry, problem with $(err.val): $(err.msg)")
        else
            rethrow(err)
        end
    end
end
