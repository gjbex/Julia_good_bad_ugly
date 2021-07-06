module Points

export PointStyle, Is2DPoint, Is3DPoint, get_x, get_y, get_z, distance

abstract type PointStyle end
struct Is2DPoint <: PointStyle end
struct Is3DPoint <: PointStyle end
struct IsNotPoint <: PointStyle end

PointStyle(::Type) = IsNotPoint()

# x accessors
"get x-coordinate of a type with the PointStyle trait"
get_x(p::T) where {T} = get_x(PointStyle(T), p)
get_x(::Union{Is2DPoint, Is3DPoint}, p) = p.x
get_x(::IsNotPoint, p) = throw(MethodError(get_x, p))

set_x(p::T, val::Real) where {T} = set_x(PointStyle(T), p, val)
set_x(::Union{Is2DPoint, Is3DPoint}, p, val) = begin p.x = val; end
set_x(::IsNotPoint, p, val) = throw(MethodError(set_x, [p, val]))

# y accessors
get_y(p::T) where {T} = get_y(PointStyle(T), p)
get_y(::Union{Is2DPoint, Is3DPoint}, p) = p.y
get_y(::IsNotPoint, p) = throw(MethodError(get_y, p))

set_y(p::T, val::Real) where {T} = set_y(PointStyle(T), p, val)
set_y(::Union{Is2DPoint, Is3DPoint}, p, val) = begin p.y = val; end
set_y(::IsNotPoint, p, val) = throw(MethodError(set_y, [p, val]))

# z accessors
get_z(p::T) where {T} = get_z(PointStyle(T), p)
get_z(::Is3DPoint, p) = p.z
get_z(::IsNotPoint, p) = throw(MethodError(get_z, p))

set_z(p::T, val::Real) where {T} = set_z(PointStyle(T), p, val)
set_z(::Is3DPoint, p, val) = begin p.z = val; end
set_z(::IsNotPoint, p, val) = throw(MethodError(set_z, [p, val]))

# distance function
distance(p1::T, p2::T) where {T} = distance(PointStyle(T), p1, p2)
distance(::Is2DPoint, p1, p2) = begin
    x1 = get_x(p1); y1 = get_y(p1)
    x2 = get_x(p2); y2 = get_y(p2)
    return sqrt((x1 - x2)^2 + (y1 - y2)^2)
end
distance(::Is3DPoint, p1, p2) = begin
    x1 = get_x(p1); y1 = get_y(p1); z1 = get_z(p1)
    x2 = get_x(p2); y2 = get_y(p2); z2 = get_z(p2)
    return sqrt((x1 - x2)^2 + (y1 - y2)^2 + (z1 - z2)^2)
end
distance(::IsNotPoint, p1, p2) = throw(MethodError(distance, [p1, p2]))

end
