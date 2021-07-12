module Gcd

export my_gcd

"""
   my_gcd(a, b)

Compute the greatest common divisor of a and b

# Arguments
- `a::Integer`: first argument, not required in real life documentation
- `b::Integer`: second argument, not required in real life documentation

Both arguments should be strictly positive, otherwise a `DomaiunErr` exception will be thrown.

# Examples

```julia-repl
julia> my_gcd(12, 15)
3
julia> my_gcd(13, 11)
1
```
"""
function my_gcd(a::Integer, b::Integer)
    a < 1 && throw(DomainError(a, "argument should be strictly positive"))
    b < 1 && throw(DomainError(b, "argument should be strictly positive"))
    while a != b
        if a > b
            a -= b
        else
            b -= a
        end
    end
    return a
end

end # module
