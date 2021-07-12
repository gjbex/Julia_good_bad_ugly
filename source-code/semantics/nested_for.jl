#!/usr/bin/env julia

data = Array{Int}(undef, 2, 3)

for i in 1:size(data, 1), j in 1:size(data, 2)
    data[i, j] = (i - 1)*size(data, 2) + j
end

println(data)
