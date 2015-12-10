bitstype 64 Float65{A} <: AbstractFloat

Float65(x::Float64) = reinterpret(Float65{zero(Int32)},x)
Float65(A<:Int32, x::Float64) = reinterpret(Float65{A},x)

function show(io::IO, x::Float65)
   A = stypeof(x).parameters[1]
   fp = reinterpret(Float64,x)
   s = string(fp,"₍",A,"₎")
   print(io, s)
end
