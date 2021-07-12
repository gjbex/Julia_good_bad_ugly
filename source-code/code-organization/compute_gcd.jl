#!/usr/bin/env julia

using Gcd

for a = 1:5, b = 1:2:15
    println("gcd($a, $b) = $(my_gcd(a, b))")
end
