#!/usr/bin/env julia

using MyFunctions: fact

for n in 0:5
    println("fact($n) = $(fact(n))")
end
