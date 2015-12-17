#=
    Absorb behavior into the medium (Float64).

    Project state-free value as an unmarked stateful quantity (the projection).
    Mark the stateful quantity, or do not mark it (the stateful projection).
    
    Unmark the stateful projection.
    Reflect the projection as state-free value (the reflection).
=#


@inline function pushout{F<:AbstractFloat}(fp::F)
   stationedExponent = get_exponent(fp) - Bias(F)
   reinterpret(F,put_exponent(fp, stationedExponent))
end

@inline function pullback{F<:AbstractFloat}(fp::F)
   stationaryExponent = get_exponent(fp) + Bias(F)
   reinterpret(F,put_exponent(fp, stationaryExponent))
end 

function project{F<:AbstractFloat}(fp::F)
    if AsTiny(F) <= fp <= AsHuge(F)
      pushout(fp)
    elseif fp == 0.0
       fp
    elseif isfinite(fp)
       if fp == 0.0
           fp
       elseif fp < AsHuge(F)
           signbit(fp) ? -set_ebit(TinyProjected(F)) : TinyProjected(F)
       else
           signbit(fp) ? -set_ebit(HugeProjected(F)) : HugeProjected(F)
       end
    else  # ±Inf or NaN
       isinf(fp) ? set_ebit(fp) : fp
    end
end    

function reflect{F<:AbstractFloat}(fp::F)
    if TinyProjected(F) < abs(fp) < HugeProjected(F)
        pullback(clr_ebit(fp))
    elseif fp == 0.0
        fp
    elseif isfinite(fp)
       if clr_ebit(fp) <= TinyProjected(F)
           signbit(fp) ? -Tiny(F) : Tiny(F)
       else
           signbit(fp) ? -Huge(F) : Huge(F)
       end
    else # ±Inf or NaN
        fp
    end
end
