# interoperability with Distributions

import Distributions: Distribution,Univariate,Continuous,Triweight,AbstractMixtureModel,
                      cdf,pdf,quantile,logcdf,logpdf,ccdf,cquantile,invlogcdf,invlogccdf

typealias TriDist Triweight
typealias MixDist AbstractMixtureModel{Univariate,Continuous}
typealias UniDist Distribution{Univariate,Continuous}

pdf(d::MixDist, x::Float65) = pdf(d, convert(Float64,x))
logpdf(d::MixDist, x::Float65) = logpdf(d, convert(Float64,x))

for op in (:cdf,:pdf,:quantile,:logcdf,:logpdf,:ccdf,:cquantile,:invlogcdf,:invlogccdf)
    @eval ($op)(d::TriDist, x::Float65) = ($op)(d, convert(Float64,x))
    @eval ($op)(d::UniDist, x::Float65) = ($op)(d, convert(Float64,x))
end    
