# these do not require decoding to work correctly

issubnormal(a::Float65) = false
for op in (:sign, :signbit, :isinf, :isnan)
    @eval ($op)(a::Float65) = ($op)(a.fp)
end
(-)(a::Float65) = Float65(-a.fp)
abs(a::Float65) = Float65(abs(a.fp))

# these require decoding to work correctly

isinteger(a::Float65) = isinteger(reflect(a.fp))

for op in (:(+), :(-), :(*), :(/), :(\), :(%))
    @eval begin
        ($op)(a::Float65, b::Float65) = Float65( ($op)(reflect(a.fp), reflect(b.fp) )
        ($op)(a::Float65, b::Float64) = Float65( ($op)(reflect(a.fp), b )
        ($op)(a::Float64, b::Float65) = Float65( ($op)(a, reflect(b.fp) )
        
        ($op){I<:Union{Int64,Int32}}(a::Float65, b::I) = Float65( ($op)(reflect(a.fp), b )
        ($op){I<:Union{Int64,Int32}}(a::I, b::Float65) = Float65( ($op)(a, reflect(b.fp) )
        ($op)(a::Float65, b::Real) = Float65( ($op)(reflect(a.fp), convert(Float64,b) )
        ($op)(a::Real, b::Float65) = Float65( ($op)(convert(Float64,a), reflect(b.fp) )
    end
end
