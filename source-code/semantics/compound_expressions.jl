#!/usr/bin/env julia

x = begin
    a = 5
    b = 6
    a + b
end

println("x = $x, a = $a, b = $b")

x = begin
    a = 9
    b = -9
    a + b
end

println("x = $x, a = $a, b = $b")
