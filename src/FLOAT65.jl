module FLOAT65

import Base: convert, promote_rule, show, showcompact,
             typemin, typemax, realmin, realmax, sizeof,
             isinf, isnan, issubnormal, isfinite, isinteger,
             zero, one,
             (==),(!=),(<),(<=),(>=),(>),isless,isequal,
             (+),(-),(*),(/),(\),(%),
             exp, expm1, log, log1p,
             sin, cos, tan, csc, sec, cot,
             asin, acos, atan, acsc, asec, acot,
             sinh, cosh, tanh, csch, sech, coth,
             asinh, acosh, atanh, acsch, asech, acoth
             
export Float65, setstate, clearstate, getstate


include("behavior/Reinterpret.jl")
include("behavior/ebit.jl")
include("behavior/absorb.jl")

include("type/Float65.jl")
include("type/basics.jl")

if (isdefined(:PropagateState) && PropagateState==true)

include("math/propagateState/arith.jl")
include("math/propagateState/elementary.jl")

else # do not propogate the set state

include("math/assignState/arith.jl")
include("math/assignState/elementary.jl")

end

if isdefined(Main, :Distributions)
    include("interop/Distributions.jl")
end

end # module
