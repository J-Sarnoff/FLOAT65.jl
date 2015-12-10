module FLOAT65

import Base: convert, promote_rule, show, showcompact,
             isinf, isnan, issubnormal, isfinite,
             zero, one
             
             
include("Float65.jl")
include("basics.jl")
include("fn1arg.jl")
include("fn2arg.jl")

end # module
