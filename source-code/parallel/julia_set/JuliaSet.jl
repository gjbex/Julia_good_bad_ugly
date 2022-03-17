module JuliaSet

using Distributed
using SharedArrays

function julia_iterate(z, c)
    n::UInt8 = 0
    while n < 255 && abs(z) < 2.0
        z = z^2 + c
        n += 1
    end
    return n
end

function make_tile(z, δ, n)
    z_real = real(z):δ:(real(z) + (n - 1)*δ)
    z_real = z_real' .* ones(n)
    z_imag = imag(z):δ:(imag(z) + (n - 1)*δ)
    z_imag = z_imag' .* ones(n)
    return z_real' + 1.0im*z_imag
end

function compute_tile(z, δ, n, c)
    tile = make_tile(z, δ, n)
    return julia_iterate.(tile, c)
end

function make_domain(z, nr_tiles)
    if nr_tiles > 1
        δ = 2.0*real(z)/nr_tiles
        return make_tile(-z, δ, nr_tiles)
    else
        domain = Array{ComplexF64}(undef, 1, 1)
        domain[1, 1] = -z
        return domain
    end
end

function julia_compute_domain(z, c, n, nr_tiles)
    tile_size = n ÷ nr_tiles
    δ = 2.0*real(z)/n
    result = SharedArray{UInt8}(n, n)
    executed_on = SharedArray{Int}(nr_tiles, nr_tiles)
    domain = make_domain(z, nr_tiles)
    for i in 1:nr_tiles
        i_min = 1 + (i - 1)*tile_size
        i_range = i_min:(i_min + tile_size - 1)
        @sync @distributed for j in 1:nr_tiles
            j_min = 1 + (j - 1)*tile_size
            j_range = j_min:(j_min + tile_size - 1)
            result[i_range, j_range] = compute_tile(domain[i, j], δ, tile_size, c)
            executed_on[i, j] = myid()
        end
    end
    return result, executed_on
end

end
