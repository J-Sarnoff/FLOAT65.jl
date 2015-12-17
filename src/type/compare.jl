
for op in (:(<=), :(<), :(==), :(!=), :(?), :(>=), :isless, :isequal)
    @eval begin
        ($op){T<:Float65}(a::T, b::Float65) = ($op)(reflect(a.fp), reflect(b.fp))
        ($op){T<:Float65}(a::T, b::Float64) = ($op)(reflect(a.fp), b)
        ($op){T<:Float65}(a::Float64, b::T) = ($op)(a, reflect(b.fp))
        
        ($op){T<:Float65,I<:Union{Int64,Int32}}(a::T, b::I) = ($op)(reflect(a.fp), b)
        ($op){T<:Float65,I<:Union{Int64,Int32}}(a::I, b::T) = ($op)(a, reflect(b.fp))
        ($op){T<:Float65}(a::T, b::Bool)      = ($op)(reflect(a.fp), convert(Float64,b))
        ($op){T<:Float65}(a::Bool, b::T)      = ($op)(convert(Float64,a), reflect(b.fp))
        ($op){T<:Float65,R<:Real}(a::T, b::R) = ($op)(reflect(a.fp), convert(Float64,b))
        ($op){T<:Float65,R<:Real}(a::R, b::T) = ($op)(convert(Float64,a), reflect(b.fp))
    end
end

