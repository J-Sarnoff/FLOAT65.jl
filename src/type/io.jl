const NaN   = "NaN"
const InfValue  = "∞"
const PosInfValue = "+∞" 
const NegInfValue = "-∞" 

const TinyValue = "⬭"
const HugeValue = "⬬"


show(io::IO, x::Float65) = show(io, convert(Float64,x))
