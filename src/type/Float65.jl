
immutable Float65 <: Real
   fp::Float64
end

convert(::Type{Float64}, x::Float65) = reflect(x.fp)
convert(::Type{Float65}, x::Float64) = Float65(project(x))

promote_rule(::Type{Float64}, ::Type{Float65}) = Float65

show(io::IO, x::Float65) = show(io, covert(Float64,x.fp))

