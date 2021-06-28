#!/usr/bin/env julia

using ArgParse

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
    a = options["a"]
    b = options["b"]

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
