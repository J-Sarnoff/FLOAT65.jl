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
             
export Float65

include("behavior/absorb.jl")

include("type/Float65.jl")
include("type/basics.jl")
include("math/arith.jl")
include("math/elementary.jl")
#=
include("basics.jl")
include("fn1arg.jl")
include("fn2arg.jl")
=#
end # module
