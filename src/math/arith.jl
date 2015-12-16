# these require decoding to work correctly

isinteger(a::Float65) = isinteger(reflect(a.fp))


if isdefined(:PropagateState) && PropagateState


if isdefined(:PropagateSharedState) && PropagateSharedState

for op in (:(+), :(-), :(*), :(/), :(\), :(%))

    @eval begin
    
        function ($op){T<:Float65}(a::T, b::T)
            value = (T)( ($op)(reflect(a.fp), reflect(b.fp)) )
            state = getstate(a) & getstate(b)
            if state 
               value = setstate(value)
            end
            value
         end
    end
         
else # do propagate the set state when at least one input is in the set state

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

end # PropagateSharedState


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
         
        ($op){I<:Union{Int64,Int32}}(a::Float65, b::I) = 
            getstate(a) ? setstate(Float65( $op(reflect(a.fp), b) )) : Float65( $op(reflect(a.fp), b) )
        ($op){I<:Union{Int64,Int32}}(a::I, b::Float65) = 
            getstate(b) ? setstate(Float65( $op(a, reflect(b.fp)) )) : Float65( $op(a, reflect(b.fp)) )
        ($op)(a::Float65, b::Bool) = 
            getstate(a) ? setstate(Float65( $op(reflect(a.fp), convert(Float64,b)) )) : Float65( $op(reflect(a.fp), convert(Float64,b)) )
        ($op)(a::Bool, b::Float65) = 
            getstate(b) ? setstate(Float65( $op(convert(Float64,a), reflect(b.fp)) )) : Float65( $op(convert(Float64,a), reflect(b.fp)) )
        ($op)(a::Float65, b::Real) = 
            getstate(a) ? setstate(Float65( $op(reflect(a.fp), convert(Float64,b)) )) : Float65( $op(reflect(a.fp), convert(Float64,b)) )
        ($op)(a::Real, b::Float65) = 
            getstate(b) ? setstate(Float65( $op(convert(Float64,a), reflect(b.fp)) )) : Float65( $op(convert(Float64,a), reflect(b.fp)) )
    end
end

else # do not propagate the set state


for op in (:(+), :(-), :(*), :(/), :(\), :(%))
    @eval begin
        ($op)(a::Float65, b::Float65) = Float65( $op(reflect(a.fp), reflect(b.fp)) )
        ($op)(a::Float65, b::Float64) = Float65( $op(reflect(a.fp), b) )
        ($op)(a::Float64, b::Float65) = Float65( $op(a, reflect(b.fp)) )
        
        ($op){I<:Union{Int64,Int32}}(a::Float65, b::I) = Float65( $op(reflect(a.fp), b) )
        ($op){I<:Union{Int64,Int32}}(a::I, b::Float65) = Float65( $op(a, reflect(b.fp)) )
        ($op)(a::Float65, b::Bool) = Float65( $op(reflect(a.fp), convert(Float64,b)) )
        ($op)(a::Bool, b::Float65) = Float65( $op(convert(Float64,a), reflect(b.fp)) )
        ($op)(a::Float65, b::Real) = Float65( $op(reflect(a.fp), convert(Float64,b)) )
        ($op)(a::Real, b::Float65) = Float65( $op(convert(Float64,a), reflect(b.fp)) )
    end
end

end # PropagateState
