#             funcname: the name of the function to become wrapped
#             argType:  the name of the type of argument
#             cvtType:  the name of the type of the conversion target

macro wrapUnaryFunction(fname, argType, cvtType)
    @eval begin
      function ($fname)(x::($argType))
          ($fname)(convert(($cvtType), x))
      end
    end
end

macro wrapUnaryFunctionFloat65(fname, argType)
    @eval begin
      function ($fname)(a::($argType))
          value = (argType)( ($fname)(reflect(a.fp)) )
          if getstate(a)
             value = setstate(value)
          end
          value
      end
    end
end

macro wrapBinaryFunctionFloat65(fname, argType, arg2Type)
    @eval begin
      function ($fname)(a::($argType), b::($arg2Type))
          value = (argType)( ($fname)(reflect(a.fp),reflect(b.fp)) )
          if getstate(a)|getstate(b)
             value = setstate(value)
          end
          value
      end
    end
end
