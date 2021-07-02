#!/usr/bin/env julia

using ArgParse

function gcd(a::Int, b::Int)::Int
    while a != b
        if a > b
            a -= b
        else
            b -= a
        end
    end
    return a
end
    
function main()
    arg_parser = ArgParseSettings()
    arg_parser.description = "Compute the greatest common divisor of two integers"
    @add_arg_table arg_parser begin
        "a"
            arg_type = Int
            required = true
            help = "first integer"
        "b"
            arg_type = Int
            required = true
            help = "second integer"
    end
    options = parse_args(ARGS, arg_parser)

    println(gcd(options["a"], options["b"]))

    return 0
end

main()
