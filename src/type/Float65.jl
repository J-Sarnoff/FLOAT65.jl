import Base:convert, promote_rule, show

immutable Float65 <: Real
   fp::Float64
   
   Float65(fp::Float64) = new(project(fp))
end

convert(::Type{Float64}, x::Float65) = reflect(x.fp)
convert(::Type{Float65}, x::Float64) = Float65(project(x))

promote_rule(::Type{Float64}, ::Type{Float65}) = Float65

show(io::IO, x::Float65) = show(io, convert(Float64,x.fp))

