 
#=
    Tiny if exponent(Float64) <= -509                         Huge if exponent(Float64) >= 510
    TinyAsValue == ldexp(0.5,-509)        <reciprocals>       HugeAsValue == ldexp(0.5,511)
                            1.19e-153     central range    8.38e+152
      ldexp(prevfloat(prevfloat(1.0)), -508) ...0.0... ldexp(nextfloat(0.5),509)
                                          <reciprocals>
=#

@inline isTiny{T<:AbstractFloat}(x::T) = (x <= AsTiny(T)) & (x != zero(T))
@inline isHuge{T<:AbstractFloat}(x::T) = (x >= AsHuge(T)) & (x != (T)(Inf))
@inline isTinyProjected{T<:AbstractFloat}(x::T) = (x <= AsTinyProjected(T)) & (x != zero(T))
@inline isHugeProjected{T<:AbstractFloat}(x::T) = (x >= AsHugeProjected(T)) & (x != (T)(Inf))


# huge/tiny gathers all finite values larger/smaller (or equal) itself
# huge, tiny before projective transform
Bias(::Type{Float64})   = 511                     # exponent_bias(Float64) >> 1
AsTiny(::Type{Float64}) = 1.1933345169920327e-153 # first inadmissible small magnitude
AsHuge(::Type{Float64}) = 8.379879956214127e152   # first inadmissible large magnitude
                                                  # 1/AsTiny == AsHuge, 1/AsHuge == AsTiny
Tiny(::Type{Float64})   = 2.983336292480083e-154  # collective value representing all smallest normal magnitudes
Huge(::Type{Float64})   = 3.3519519824856493e153  # collective value representing all largest  normal magnitudes
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
  HugeProjected(::Type{Float64}) = 0.5000000000000000
AsTinyProjected(::Type{UInt64})  = 0x003ffffffffffffd
AsHugeProjected(::Type{UInt64})  = 0x3fc0000000000002
  TinyProjected(::Type{UInt64})  = 0x0020000000000000
  HugeProjected(::Type{UInt64})  = 0x3fe0000000000001
