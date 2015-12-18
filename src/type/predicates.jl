@inline nonzero{T<:AbstractFloat}(x::T) = (zero(T) != x)
@inline noninf{T<:AbstractFloat}(x::T)  = (!isinf(x))

# these do not require decoding to work correctly

issubnormal(a::Float65) = false
for op in (:sign, :signbit, :isinf, :isnan, :isfinite)
    @eval ($op)(a::Float65) = ($op)(a.fp)
end
