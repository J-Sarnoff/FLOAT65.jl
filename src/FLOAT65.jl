module FLOAT65

import Base: convert, promote_rule, show, showcompact,
             typemin, typemax, realmin, realmax,
             isinf, isnan, issubnormal, isfinite, isinteger,
             zero, one
             
export Float65

include("type/Float65.jl")
include("behavior/absorb.jl")
#=
include("basics.jl")
include("fn1arg.jl")
include("fn2arg.jl")
=#
end # module
