# idempotency
convert(::Type{Float65}, x::Float65) = x
# ambiguity reduction: first specify interconversion with Bool
convert(::Type{Float65}, x::Bool) = convert(Float65, convert(Float64,x))
convert(::Type{Bool}, x::Float65) = !iszero(x)
promote_rule(::Type{Float65}, ::Type{Bool}) = Float65
# ambiguity resolution: specify interconversion with Float64
convert(::Type{Float64}, x::Float65) = reflect(x.fp)
convert(::Type{Float65}, x::Float64) = Float65(x)
promote_rule(::Type{Float64}, ::Type{Float65}) = Float65
# special numerical types
convert(::Type{Float65}, x::Irrational) = convert(Float65, convert(Float64, x))
promote_rule(::Type{Float65}, ::Type{Irrational}) = Float65
# delegation with non-leaf types
convert(::Type{Float65}, x::Integer) = convert(Float65, convert(Float64, convert(Int64,x)))
convert(::Type{Float65}, x::AbstractFloat) = convert(Float65, convert(Float64,x))
convert(::Type{Integer}, x::Float65) = convert(Int64, convert(Float64, x))
convert(::Type{AbstractFloat}, x::Float65) = convert(Float64, x)
promote_rule(::Type{Float65}, ::Type{Integer}) = Float65
promote_rule(::Type{Float65}, ::Type{AbstractFloat}) = Float65
# autoprocessable types
for T in (:Int16, :Int32, :Int64, :Float16, :Float32, 
          :(Rational{Int32}), :(Rational{Int64}))
    @eval begin
        convert(::Type{Float65}, x::$T) = Float65(convert(Float64,x))
        convert(::Type{$T}, x::Float65) = ($T)( convert(Float64,x) )
        promote_rule(::Type{Float65}, ::Type{$T}) = Float65
    end
end


