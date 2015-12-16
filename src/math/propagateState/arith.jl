# these require decoding to work correctly

isinteger(a::Float65) = isinteger(reflect(a.fp))

for op in (:(+), :(-), :(*), :(/), :(\), :(%))

    @eval begin
    
        function ($op){T<:Float65}(a::T, b::T)
            value = (T)( ($op)(reflect(a.fp), reflect(b.fp)) )
            state = getstate(a) | getstate(b)
            if state 
               value = setstate(value)
            end
            value
         end
    end
end


for op in (:(+), :(-), :(*), :(/), :(\), :(%))
    @eval begin
    
        function ($op){T<:Float65}(a::T, b::Float64)
            value = (T)( ($op)(reflect(a.fp), b) )
            if getstate(a)
               value = setstate(value)
            end
            value
         end     
         
        function ($op){T<:Float65}(a::Float64, b::T)
            value = (T)( ($op)(a, reflect(b.fp)) )
            if getstate(b) 
               value = setstate(value)
            end
            value
         end     
         
        ($op){T<:Float65,I<:Union{Int64,Int32}}(a::T, b::I) = 
            getstate(a) ? setstate(Float65( $op(reflect(a.fp), b) )) : Float65( $op(reflect(a.fp), b) )
        ($op){T<:Float65,I<:Union{Int64,Int32}}(a::I, b::T) = 
            getstate(b) ? setstate(Float65( $op(a, reflect(b.fp)) )) : Float65( $op(a, reflect(b.fp)) )
        ($op){T<:Float65}(a::T, b::Bool) = 
            getstate(a) ? setstate(Float65( $op(reflect(a.fp), convert(Float64,b)) )) : Float65( $op(reflect(a.fp), convert(Float64,b)) )
        ($op){T<:Float65}(a::Bool, b::T) = 
            getstate(b) ? setstate(Float65( $op(convert(Float64,a), reflect(b.fp)) )) : Float65( $op(convert(Float64,a), reflect(b.fp)) )
        ($op){T<:Float65}(a::T, b::Real) = 
            getstate(a) ? setstate(Float65( $op(reflect(a.fp), convert(Float64,b)) )) : Float65( $op(reflect(a.fp), convert(Float64,b)) )
        ($op){T<:Float65}(a::Real, b::T) = 
            getstate(b) ? setstate(Float65( $op(convert(Float64,a), reflect(b.fp)) )) : Float65( $op(convert(Float64,a), reflect(b.fp)) )
    end
end
