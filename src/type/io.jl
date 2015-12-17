const NaNValue    = "NaN"

const InfValue    = "∞"
const PosInfValue = "+∞" 
const NegInfValue = "-∞" 
const InfName     = "Inf"

const TinyValue = "⬭"
const HugeValue = "⬬"
const TinyName  = "TINY"
const HugeName  = "HUGE"

const Exactly   = "̇ "
const Inexactly = "~"

const OpenLeft    = "⟓"
const ClosedLeft  = "⟔"
const OpenRight   = "⟔"
const ClosedRight = "⟓"

const LeftTwoParens       = "｟"
const RightTwoParens      = "｠"
const LeftFullParens      = "（"
const RightFullParens     = "）"

const LeftCurvyAngle      = "⧼"
const RightCurvyAngle     = "⧽"
const LeftShallowWithDot  = "⦑"
const RightShallowWithDot = "⦒"

const LeftAngleWithArc    = "⦓"
const RightAngleWithArc   = "⦔"
const LeftAngleWithArcs   = "⦖"
const RightAngleWithArcs  = "⦕"

const InfinityTied = "⧝"
const InfinitySplit = "⧞"
const InfinityUnfinished = "⧜"



function show(io::IO, x::Float65)

    state = getstate(x)
    fp = convert(Float64, x)
    
    if isfinite(x)
        if Tiny(Float64) < fp < Huge(Float64)
           s = prepshow(fp, state)
        elseif fp == 0.0
           s = prepshow0(fp, state)
        elseif fp <= AsTiny(Float64)
          s = prepshowTiny(fp, state)
        else
          s = prepshowHuge(fp, state)
        end
    elseif isinf(x.fp)  # ±Inf or NaN (restore from clearing the state)
       s = prepshowInf(x.fp,state)
    else
       s = prepshowNaN(x.fp,state)
    end

    print(io, s)
end

@inline prepshowState(state::Bool) = state ? Inexactly : Exactly
@inline function prepnumsign(fp::Float64)
    isneg = signbit(fp)
    if isneg
        "-"
    else
        "+"
    end
end

function prepshow(fp::Float64, state::Bool)
   string(fp, prepshowState(state))
end
function prepshow0(fp::Float64, state::Bool)
   string(fp, prepshowState(state))
end
function prepshowTiny(fp::Float64, state::Bool)
   string( prepnumsign(fp), TinyName )
end
function prepshowHuge(fp::Float64, state::Bool)
   string( prepnumsign(fp), HugeName )
end
function prepshowInf(fp::Float64, state::Bool)
   string( prepnumsign(fp), InfValue )
end
function prepshowNaN(fp::Float64, state::Bool)
   string( prepnumsign(fp), NaNValue )
end
