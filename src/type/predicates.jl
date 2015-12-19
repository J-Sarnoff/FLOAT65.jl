@inline iszero{T<:AbstractFloat}(x::T)       = (zero(T) == x)
@inline isnotzero{T<:AbstractFloat}(x::T)    = (zero(T) != x)
@inline isnormal{T<:AbstractFloat}(x::T)     = !(isinf(x) | isnan(x) | issubnormal(x))
@inline isnotinf{T<:AbstractFloat}(x::T)     = (!isinf(x))
@inline isnotfinite{T<:AbstractFloat}(x::T)  = (isinf(x) | isnan(x)) 

# these do not require decoding to work correctly

issubnormal(a::Float65) = false
for op in (:sign, :signbit, :isinf, :isnan, :isfinite, :isinteger)
    @eval ($op)(a::Float65) = ($op)(a.fp)
end
