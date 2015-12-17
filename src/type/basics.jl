# these do not require decoding to work correctly

issubnormal(a::Float65) = false
for op in (:sign, :signbit, :isinf, :isnan, :isfinite)
    @eval ($op)(a::Float65) = ($op)(a.fp)
end

typemin(::Type{Float65}) = typemin(Float64)
typemax(::Type{Float65}) = typemin(Float64)
typemin(x::Float65) = typemin(Float65)
typemax(x::Float65) = typemax(Float65)

realmin(::Type{Float65}) = Tiny
realmax(::Type{Float65}) = Huge
realmin(x::Float65) = realmin(Float65)
realmax(x::Float65) = realmax(Float65)

