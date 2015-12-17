const NaN         = "NaN"

const InfValue    = "∞"
const PosInfValue = "+∞" 
const NegInfValue = "-∞" 
const InfName     = "Inf"

const TinyValue = "⬭"
const HugeValue = "⬬"
const TinyName  = "TINY"
const HugeName  = "HUGE"


show(io::IO, x::Float65) = show(io, convert(Float64,x))
