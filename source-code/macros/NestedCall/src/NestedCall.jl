module NestedCall

"""
    @nest n f(x)

Expand `f(x)` into `f(f(...f(x)))` applied `n` times.
Only unary calls are supported. If `n == 0`, returns `x`.
"""
macro nest(n, call)
    # n must be an integer literal at macro-expansion time
    isa(n, Integer) || error("@nest: first argument must be an integer literal")
    isa(call, Expr) && call.head === :call || error("@nest: second argument must be a call like f(x)")
    length(call.args) == 2 || error("@nest: only unary calls supported (one argument)")

    n < 0 && error("@nest: n must be ≥ 0")

    # f and x
    f = call.args[1]
    x = call.args[2]

    # n == 0 → just x
    n == 0 && return esc(x)

    # Build f(f(...f(x))) as an Expr
    result = Expr(:call, f, x)
    for _ in 2:n
        result = Expr(:call, f, result)
    end
    return esc(result)
end

end # module
