
#=
    roles

    Tiny[Huge] is a collective value, gathering all finite Float64 values <= [>=] itself.
    Tiny[Huge] is largest inadmissble small [smallest inadmissable large] discrete magnitude.

    constraints

     isfinite(Tiny) & !issubnormal(Tiny) & isfinite(Huge) & !!issubnormal(Tiny)
     ldexp(0.5,-510) < Tiny < ldexp(0.5,-508)  
     ldexp(0.5,+509) < Huge < ldexp(0.5,+512)
     0.0 == 1.0-Tiny*Huge == Huge-1.0/Tiny == Tiny-1.0/Huge
     
     assignments
     
     Tiny = parse(Float64, "0x1p-510") # ldexp(0.5, -509) == 2.9833_3629_2480_0830e-154
     Huge = parse(Float64, "0x1p+510") # ldexp(0.5, +511) == 3.3519_5198_2485_6493e+153
=#


@inline isTiny{T<:AbstractFloat}(x::T) = (abs(x) <= Tiny(T)) & nonzero(x)
@inline isHuge{T<:AbstractFloat}(x::T) = (abs(x) >= Huge(T)) & noninf(x)
# projection takes domain(Float64) onto  halfdomain(Float64)
@inline isProjectedTiny{T<:AbstractFloat}(x::T) = (abs(x) <= TinyProjected(T)) & nonzero(x)
@inline isProjectedHuge{T<:AbstractFloat}(x::T) = (abs(x) >= HugeProjected(T)) & noninf(x)
# projection takes domain(Float64) onto  halfdomain(Float64)
@inline isStatefulTiny{T<:AbstractFloat}(x::T) = (abs(x) <= TinyProjected(T)) & nonzero(x)
@inline isStatefulHuge{T<:AbstractFloat}(x::T) = (abs(x) >= HugeProjected(T)) & noninf(x)



Bias(::Type{Float64}) = 511                     # exponent_bias(Float64) >> 1
Bias(::Type{UInt64})  = 0x00000000000001ff      # for use with other UInt64 bitforms

# Tiny and Huge, valuations to be used as proxies for their respective collective intent.
#
AsTiny(::Type{Float64}) = 1.1933345169920327e-153 # first inadmissible small magnitude & all smallest
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
