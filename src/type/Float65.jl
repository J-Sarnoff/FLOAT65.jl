
type Float65 <: Real
   fp::Float64
   
   Float65(fp::Float64) = new(project(fp))
end

convert(::Type{Float64}, x::Float65) = reflect(x.fp)
convert(::Type{Float65}, x::Float64) = Float65(project(x))
for T in (:Float32, :Float16, :Int64, :Int32, :Int16, :Bool, :Real)
    @eval convert(::Type{Float65}, x::$T) = Float65(convert(Float64,x))
end

promote_rule(::Type{Float64}, ::Type{Float65}) = Float65
for T in (:Float64, :Float32, :Float16, :Int64, :Int32, Int16, :Bool, :Real)
   @eval promote_rule(::Type{Float65}, ::Type{$T}) = Float65
end   

show(io::IO, x::Float65) = show(io, convert(Float64,x))

@inline setstate(x::Float65) = set_ebit(x.fp)
@inline clearstate(x::Float65) = clr_ebit(x.fp)
@inline getstate(x::Float65) = tst_ebit(x.fp)
@inline setstate(x::Float65, s::Bool) = (s ? set_ebit(x.fp) : clr_ebit(x.fp))

clearstate(x::Float64) = Float65(x)
setstate(x::Float64) = setstate(Float65(x))
setstate(x::Float64,s::Bool) = setstate(Float65(x),s)
getstate(x::Float64) = false
