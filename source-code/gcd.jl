#!/usr/bin/env julia

function main()
    if length(ARGS) != 2
        error("two arguments expected")
    end
    a = parse(Int, ARGS[1])
    b = parse(Int, ARGS[2])

    while a != b
        if a > b
            a -= b
        else
            b -= a
        end
    end

    println(a)
    return 0
end

main()
