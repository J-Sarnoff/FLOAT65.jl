# these require decoding to work correctly

isinteger(a::Float65) = isinteger(reflect(a.fp))

(-){T<:Float65}(a::T) = (T)( (-)(reflect(a.fp)) )

sqrt{T<:Float65}(a::T) = (T)( sqrt(reflect(a.fp)) )

for op in (:(+), :(-), :(*), :(/), :(\), :(%), :(^),
           :div, :fld, :rem, :mod, :mod1, :rem1, :fld1)
    @eval begin
        ($op){T<:Float65}(a::T, b::Float65) = (T)( $op(reflect(a.fp), reflect(b.fp)) )
        ($op){T<:Float65}(a::T, b::Float64) = (T)( $op(reflect(a.fp), b) )
        ($op){T<:Float65}(a::Float64, b::T) = (T)( $op(a, reflect(b.fp)) )
        
        ($op){T<:Float65,I<:Union{Int64,Int32}}(a::T, b::I) = (T)( $op(reflect(a.fp), b) )
        ($op){T<:Float65,I<:Union{Int64,Int32}}(a::I, b::T) = (T)( $op(a, reflect(b.fp)) )
        ($op){T<:Float65}(a::T, b::Bool) = (T)( $op(reflect(a.fp), convert(Float64,b)) )
        ($op){T<:Float65}(a::Bool, b::T) = (T)( $op(convert(Float64,a), reflect(b.fp)) )
        ($op){T<:Float65,R<:Real}(a::T, b::R) = (T)( $op(reflect(a.fp), convert(Float64,b)) )
        ($op){T<:Float65,R<:Real}(a::R, b::T) = (T)( $op(convert(Float64,a), reflect(b.fp)) )
    end
end

eps{T<:Float65}(a::T) = (T)( eps(reflect(a.fp))  )
