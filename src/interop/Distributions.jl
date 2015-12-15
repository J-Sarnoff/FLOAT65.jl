# interoperability with Distributions

using Distributions

import Distributions: Distribution,Univariate,Continuous,Triweight,
                      cdf,pdf,quantile,logcdf,logpdf,ccdf,cquantile,invlogcdf,invlogccdf

typealias TriDist Triweight
typealias UniDist Distribution{Univariate,Continuous}

for op in (:cdf,:pdf,:quantile,:logcdf,:logpdf,:ccdf,:cquantile,:invlogcdf,:invlogccdf)
    @eval ($op)(d::TriDist, x::Float65) = ($op)(d, convert(Float64,x))
    @eval ($op)(d::UniDist, x::Float65) = ($op)(d, convert(Float64,x))
end    
