module MyFunctions

export fact

function fact(n::Integer)
    if n < 0
        throw(DomainError(n, "fact argument must be positive"))
    else
        result = 1
        for i in 2:n
            result *= i
        end
        return result
    end
end

end
