#=
    Absorb behavior into the medium (Float64).

    Project state-free value as an unmarked stateful quantity (the projection).
    Mark the stateful quantity, or do not mark it (the stateful projection).
    
    Unmark the stateful projection.
    Reflect the projection as state-free value (the reflection).
=#


#=
    givenFloat
         FloatExponent  -->  stationedExponent
                                      stationedFloat
                                      
                                      stationedFloat
                                               stationedExponent  -->  stationaryExponent
          FloatExponent                                                stationaryExponent
               givenFloat                  =                 stationaryFloat                                           
                                               
=#
@inline function pushout{F<:AbstractFloat}(fp::F)
   stationedExponent = get_exponent(fp) - Bias(F) 
   reinterpret(F,put_exponent(fp, stationedExponent))
end                                                    # pushout of/from a systemFloat, pushout a stationedFloat

@inline function pullback{F<:AbstractFloat}(fp::F)
   stationaryExponent = get_exponent(fp) + Bias(F)
   reinterpret(F,put_exponent(fp, stationaryExponent))
end                                                    # pullback from/of a stationedFloat, pullback a systemFloat

function project{F<:AbstractFloat}(fp::F)
    if Tiny(F) < fp < Huge(F)
      pushout(fp)
    elseif fp == 0.0
       fp
    elseif isfinite(fp)
       if fp == 0.0
           fp
       elseif fp < Huge(F)    # Tiny and Huge are formed in the enchaned state (collective values)
-           signbit(fp) ? -set_ebit(TinyProjected(F)) : set_ebit(TinyProjected(F))
       else
           signbit(fp) ? -set_ebit(HugeProjected(F)) : set_ebit(HugeProjected(F))
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
