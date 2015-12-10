bitstype 64 Float65{A} <: AbstractFloat

param{A}(::Type{Float65{A}}) = A 

Float65(x::Float64) = reinterpret(Float65{zero(Int32)},x)
Float65(A::Int32, x::Float64) = reinterpret(Float65{A},x)
Float65(A::Int64, x::Float64) = Float65(convert(Int32,A),x)

function show(io::IO, x::Float65)
   show(io, reinterpret(Float64,x))
end
