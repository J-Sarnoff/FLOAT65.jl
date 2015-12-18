#=
        Float65
=#

type Float65 <: Real
   fp::Float64
   
   Float65(fp::Float64) = new(project(fp))
end

convert(::Type{Float64}, x::Float65) = reflect(x.fp)
convert(::Type{Float65}, x::Float64) = Float65(x)
for T in (:Float32, :Float16, :Int64, :Int32, :Int16, :Bool, :Real)
    @eval convert(::Type{Float65}, x::$T) = Float65(convert(Float64,x))
end

promote_rule(::Type{Float64}, ::Type{Float65}) = Float65
for T in (:Float64, :Float32, :Float16, :Int64, :Int32, Int16, :Bool, :Real)
   @eval promote_rule(::Type{Float65}, ::Type{$T}) = Float65
end   


@inline getstate(x::Float65) = tst_ebit(x.fp)

function clearstate(x::Float65)
   x.fp = clr_ebit(x.fp)
   x
end

function setstate(x::Float65)
   x.fp = set_ebit(x.fp)
   x
end
setstate(x::Float65, s::Bool) = (s ? setstate(x) : x)

clearstate(x::Float64) = convert(Float65,x)
setstate(x::Float64) = setstate(convert(Float65,x))
setstate(x::Float64,s::Bool) = setstate(convert(Float65,x),s)
getstate(x::Float64) = false

@vectorize_1arg Real Float65

@vectorize_1arg Float65 getstate
@vectorize_1arg Float65 setstate
@vectorize_1arg Float65 clearstate


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
#=
                                     subobject classifiers
   leaf types of shared abstraction
=#
#=
immutable SituatedFloat  <: MetastableFloat
    fp::Float64
end
immutable StatefulFloat  <: MetastableFloat
    fp::Float64
end

convert{F<:MetastableFloat}(::Type{F}, x::SituatedFloat) = x.fp
convert{F<:Float64}(::Type{F}, x::StatefulFloat) = x.fp
=#
