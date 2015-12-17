const NaNValue    = "NaN"

const InfValue    = "∞"
const PosInfValue = "+∞" 
const NegInfValue = "-∞" 
const InfName     = "Inf"

const TinyValue = "⬭"
const HugeValue = "⬬"
const TinyName  = "TINY"
const HugeName  = "HUGE"

const Exactly   = "⌁"
const Inexactly = "~"

function show(io::IO, x::Float65)

    state = getstate(x)
    fp = convert(Float64, x)
    
    if AsTiny(Float64) <= fp <= AsHuge(Float64)
       s = prepshow(fp, state)
    elseif fp == 0.0
       s = prepshow0(fp, state)
    elseif isfinite(fp)
       if fp <= AsTiny(Float64)
          s = prepshowTiny(fp, state)
       else
          s = prepshowHuge(fp, state)
       end
    elseif isinf(fp)  # ±Inf or NaN
       s = prepshowInf(fp,state)
    else
       s = prepshowNaN(fp,state)
    end

    print(io, s)
end

@inline prepshowState(state::Bool) = state ? Inexactly : Exactly

function prepshow(fp::Float64, state::Bool)
   string(fp, prepshowState(state))
end
function prepshow0(fp::Float64, state::Bool)
   string(fp, prepshowState(state))
end
function prepshowTiny(fp::Float64, state::Bool)
   string( (signbit(fp) ? "-" : "+"), TinyValue )
end
function prepshowHuge(fp::Float64, state::Bool)
   string( (signbit(fp) ? "-" : "+"), HugeValue )
end
function prepshowInf(fp::Float64, state::Bool)
   string( (signbit(fp) ? "-" : "+"), InfValue )
end
function prepshowNaN(fp::Float64, state::Bool)
   string( (signbit(fp) ? "-" : "+"), NaNValue )
end
