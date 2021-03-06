module FLOAT65

import Base: convert, promote_rule, reinterpret, 
             show, showcompact, read, write,
             sizeof, hash,
             typemin, typemax, realmin, realmax,
             isinf, isnan, issubnormal, isfinite, isinteger,
             zero, one, sign, signbit, abs, eps,
             (==),(!=),(<),(<=),(>=),(>), isless, isequal,
             (+),(-),(*),(/),(\),(%),(^),sqrt,
             (.+),(.-),(.*),(./),(.\),(.^),
             min, max, minmax,
             div, fld, rem, mod, mod1, rem1, fld1,
             exp, expm1, log, log1p,
             sin, cos, tan, csc, sec, cot,
             asin, acos, atan, acsc, asec, acot,
             sinh, cosh, tanh, csch, sech, coth,
             asinh, acosh, atanh, acsch, asech, acoth

export Float65, 
       getstate, setstate, clearstate



include("type/abstract.jl")
include("type/Float65.jl")
include("type/conversion.jl")
include("type/basics.jl")
include("type/predicates.jl")
include("type/compare.jl")
include("type/io.jl")
include("type/wrapfuns.jl")

include("behavior/Reinterpret.jl")
include("behavior/ebit.jl")
include("behavior/tinyhuge.jl")
include("behavior/absorb.jl")


if (isdefined(Main,:NoStatePropagation) && Main.NoStatePropagatione==true)

include("math/assignState/arith.jl")
include("math/assignState/elementary.jl")

else # propagate the set state

include("math/propagateState/arith.jl")
include("math/propagateState/elementary.jl")

end

if isdefined(Main, :Distributions)
    include("interop/Distributions.jl")
end

end # module
