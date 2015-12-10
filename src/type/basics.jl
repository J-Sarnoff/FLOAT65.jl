for fn in (:isnan, :isinf, :issubnormal, :isfinite, :isinteger, :typemax, :typemin)
   @eval ($fn)(fp::Float65) = ($fn)(reflect(fp.fp))
end

