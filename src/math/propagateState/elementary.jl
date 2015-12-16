for op in (:exp, :expm1, :log, :log1p,
           :sin, :cos, :tan, :csc, :sec, :cot,
           :asin, :acos, :atan, :acsc, :asec, :acot,
           :sinh, :cosh, :tanh, :csch, :sech, :coth,
           :asinh, :acosh, :atanh, :acsch, :asech, :acoth)
    @eval begin

        function ($op)(a::Float65)
            state = getstate(a)
            value = Float65( ($op)(reflect(a.fp)) )
            if state 
               value = setstate(value)
            end
            value
         end            

    end
end
