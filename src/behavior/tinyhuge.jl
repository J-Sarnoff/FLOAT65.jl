
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


@inline isTiny{T<:AbstractFloat}(x::T) = (abs(x) <= Tiny(T)) & isnotzero(x)
@inline isHuge{T<:AbstractFloat}(x::T) = (abs(x) >= Huge(T)) & isnotinf(x)
# projection takes domain(Float64) onto  halfdomain(Float64)
@inline isProjectedTiny{T<:AbstractFloat}(x::T) = (abs(x) <= TinyProjected(T)) & isnotzero(x)
@inline isProjectedHuge{T<:AbstractFloat}(x::T) = (abs(x) >= HugeProjected(T)) & isnotinf(x)
# stateful takes projection into one of two coextant, equivalued halfdomain(Float64) bistablities
@inline isStatefulTiny{T<:AbstractFloat}(x::T)  = (abs(x) <= TinyProjected(T)) & isnotzero(x)
@inline isStatefulHuge{T<:AbstractFloat}(x::T)  = (abs(x) >= HugeProjected(T)) & isnotinf(x)


# Bias is used in projective and reflective mappings (projection and reflection behave as dual ops)
Bias(::Type{Float64}) = 511                     # exponent_bias(Float64) >> 1
Bias(::Type{UInt64})  = 0x00000000000001ff      # use with bitops

# Tiny and Huge, assigned
#
Tiny(::Type{Float64}) = 2.983336292480083e-154  # collective value representing all smallest normal magnitudes
Huge(::Type{Float64}) = 3.3519519824856493e153  # collective value representing all largest  normal magnitudes
Tiny(::Type{UInt64})  = 0x2010000000000000      # use with bitops (Tiny as largest  inadmissble small magnitude)
Huge(::Type{UInt64})  = 0x5fd0000000000000      # use with bitops (Huge as smallest inadmissble large magnitude)

# Tiny and Huge, projected
#
TinyProjected(::Type{Float64}) = 4.450147717014403e-308 # ldexp(0.5,-1020) == frexp(pushout(Tiny(Float64))
HugeProjected(::Type{Float64}) = 0.5000000000000000     # ldexp(0.5,+0)    == frexp(pushout(Huge(Float64))
TinyStateful( ::Type{Float64}) = 8.0000000000000000     # ldexp(0.5,+4)    == set_ebit(TinyProjected(Float64))
HugeStateful( ::Type{Float64}) = 8.98846567431158e+307  # ldexp(0.5,+1024) == set_ebit(HugeProjected(Float64))
                                                        #            use with bitops
TinyProjected(::Type{UInt64})  = 0x0020000000000000     # reinterpret(UInt64, TinyProjected(Float64))
HugeProjected(::Type{UInt64})  = 0x3fe0000000000000     # reinterpret(UInt64, HugeProjected(Float64))
TinyStateful( ::Type{UInt64})  = 0x4020000000000000     # reinterpret(UInt64, TinyStateful(Float64))
HugeStateful( ::Type{UInt64})  = 0x7fe0000000000000     # reinterpret(UInt64, HugeStateful(Float64))
