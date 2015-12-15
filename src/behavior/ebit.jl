#=
     The most significand bit in the exponent bit field
         is freed from floating point valuation, that
         it may elucidate state or elaborate context.

In all IEEE-754 2008 conformant binary floating point representations, the exponent bit field
is adjacent to the sign bit at the most significant region of the floating point representation.
The most significant bit of the exponent is the second most significant bit in the representation.
This is the bit that is to be freed and made available as annotation, demarcation or connection.
Releasing this bit necessarily halves number of distinct exponents that may be stored and that
reduces the quantity of representable finite values by half.  The resulting, adjusted domain
for these stateful projections of Float64|32 values onto Float64|32 is given with the mapping.

    Most computing uses numerical values within 1e-153 .. 1e+153:  all remain available.

  nomenclature

    An e-bit carrying floating point value is an `augmented` float.
    An augmented float that has its e-bit clear (0b0) is 'situated'.
    An augmented float that has its e-bit set   (0b1) is 'enhanced'.

=#

import Base: sign_mask, exponent_mask, exponent_bias, significand_bits


#=
    The 'e-bit' is the most significant bit of the exponent in an IEEE754-2008 Std Binary float.
    These inline ops are used for direct access and immediate manipulation of the 'e-bit'.
=#

@inline ebit_mask{T<:AbstractFloat}(::Type{T}) =  (sign_mask(T) >> 1)
@inline ebit_filt{T<:AbstractFloat}(::Type{T}) = ~(ebit_mask(T))
@inline ebit_mask{T<:Unsigned}(x::T) = ebit_mask(reinterpret(AbstractFloat,T))
@inline ebit_filt{T<:Unsigned}(x::T) = ebit_mask(reinterpret(AbstractFloat,T))

@inline set_ebit{T<:AbstractFloat}(x::T) = reinterpret(T,(reinterpret(Unsigned,x) | ebit_mask(T)))
@inline clr_ebit{T<:AbstractFloat}(x::T) = reinterpret(T,(reinterpret(Unsigned,x) & ebit_filt(T)))
@inline tst_ebit{T<:AbstractFloat}(x::T) = zero(reinterpret(Unsigned,T)) != (reinterpret(Unsigned,x) & ebit_mask(T))



#=
   this is the exponent governance
=#
@inline exponent_filt{T<:AbstractFloat}(::Type{T})  = ~exponent_mask(T)

for m in (:sign_mask, :exponent_mask, :exponent_filt, :exponent_bias, :significand_bits)
          #  obtain masks within the context of an Unsigned type
    @eval ($m){T<:Unsigned}(::Type{T}) = ($m)(reinterpret(AbstractFloat,T))
end

# these serve utilizing raw, biased exponent values

@inline clear_exponent{T<:Unsigned}(x::T)     = (x & exponent_filt(T))
@inline isolate_exponent{T<:Unsigned}(x::T)   = (x & exponent_mask(T))
@inline get_exponent{T<:Unsigned}(x::T)       = (isolate_exponent(x) >> significand_bits(T))
@inline put_exponent{T<:Unsigned}(x::T, e::T) = (isolate_exponent(e << significand_bits(T)) | clear_exponent(x))

@inline get_exponent(x::Float)  = get_exponent(reinterpret(Unsigned,x))
@inline put_exponent(x::Float, e::Unsigned)= put_exponent(reinterpret(Unsigned,x),e)

#=
  nomenclature
    An e-bit enfolding floating point value is an 'augmented' float.
    An augmented float that has its e-bit clear (0b0) is 'situated'.
    An augmented float that has its e-bit set   (0b1) is 'enhanced'.
=#

# query state
enhanced{T<:AbstractFloat}(x::T) =  tst_ebit(x)  #      is this enhanced?
situated{T<:AbstractFloat}(x::T) = !tst_ebit(x)  #      is this situated?

# force state
 enhance!{T<:AbstractFloat}(x::T) =  set_ebit(x)  # this is now  enhanced!
 situate!{T<:AbstractFloat}(x::T) =  clr_ebit(x)  # this is now  situated!
 
#=
    Tiny if exponent(Float64) <= -509                         Huge if exponent(Float64) >= 510
    TinyAsValue == ldexp(0.5,-509)        <reciprocals>       HugeAsValue == ldexp(0.5,511)
                            1.19e-153     central range    8.38e+152
      ldexp(prevfloat(prevfloat(1.0)), -508) ...0.0... ldexp(nextfloat(0.5),509)
                                          <reciprocals>
=#

@inline isTiny{T<:AbstractFloat}(x::T) = (x <= AsTiny(T))
@inline isHuge{T<:AbstractFloat}(x::T) = (x <= AsHuge(T))


# huge/tiny gathers all finite values larger/smaller (or equal) itself
# huge, tiny before projective transform
Bias(::Type{Float64})   = 511                     # exponent_bias(Float64) >> 1
AsTiny(::Type{Float64}) = 1.1933345169920327e-153 # first inadmissible small magnitude
AsHuge(::Type{Float64}) = 8.379879956214127e152   # first inadmissible large magnitude
                                                  # 1/AsTiny == AsHuge, 1/AsHuge == AsTiny
Tiny(::Type{Float64})   = 2.983336292480083e-154  # collective value representing all smallest normal magnitudes
Huge(::Type{Float64})   = 3.35195198248565e+153   # collective value representing all largest  normal magnitudes
                                                  # 1/Tiny == Huge, 1/Huge == Tiny
# above, reinterpreted before projection
Bias(::Type{UInt64})   = 0x00000000000001ff
AsTiny(::Type{UInt64}) = 0x202ffffffffffffd
AsHuge(::Type{UInt64}) = 0x5fb0000000000002
Tiny(::Type{UInt64})   = 0x2010000000000000
Huge(::Type{UInt64})   = 0x5fd0000000000001

# above, after projection
AsTinyProjected(::Type{Float64}) = 1.7800590868057605e-307
AsHugeProjected(::Type{Float64}) = 0.12500000000000006
  TinyProjected(::Type{Float64}) = 4.450147717014403e-308
  HugeProjected(::Type{Float64}) = 0.5000000000000001
AsTinyProjected(::Type{UInt64})  = 0x003ffffffffffffd
AsHugeProjected(::Type{UInt64})  = 0x3fc0000000000002
  TinyProjected(::Type{UInt64})  = 0x0020000000000000
  HugeProjected(::Type{UInt64})  = 0x3fe0000000000001
