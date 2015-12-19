#=
        Float65
=#

type Float65 <: Real
   fp::Float64
   
   Float65(fp::Float64) = new(project(fp))
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
#    dispatch narrowing
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
