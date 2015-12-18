@inline isnotzero{T<:AbstractFloat}(x::T) = (zero(T) != x)
@inline isnotinf{T<:AbstractFloat}(x::T)  = (!isinf(x))
@inline isnormal{T<:AbstractFloat}(x::T)  = (!isnan(x) & !isinf(x) & !issubnormal(x))

# these do not require decoding to work correctly

issubnormal(a::Float65) = false
for op in (:sign, :signbit, :isinf, :isnan, :isfinite, :isinteger)
    @eval ($op)(a::Float65) = ($op)(a.fp)
end
