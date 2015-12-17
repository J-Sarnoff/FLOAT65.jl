### FLOAT65
```ruby
                      Jeffrey Sarnoff            2015-Dec-15
```
_*under development, changing frequently*_

Exports Float65, a variant of Float64 that enfolds a two-valued state directly.

State is held within the floating point value by appropriating one bit of the
exponent field.  This offers a value that maximally interoperable with Float64
and carries alterable state.  It requires decoding prior to calculation and
encoding of the result. 

This is a largely untested working implementation.  At best, which is with
elementary functions, on my machine it runs 2.5x slower than Float64.  With
multiply, it runs 6x slower.  The implementation supports Tiny and Huge as
collective, finite values.

```
# for interoperability with Polynomials just use Polynomials
# for interoperability with Distributions that are Univariate and Continuous

using Distributions
using FLOAT65
```

```
To engage automatic propagation of the set state, before loading/using this module,
PropogateState must be assigned true.

PropagateState = true        # the set state will propogate through arithmetic
                             #     and elementary function calculations
using FLOAT65                # PropagateState = true (MUST come first if used)

pi_clr = Float65(pi); pi_set = setstate(Float65(pi));
julia> pi_clr,getstate(pi_clr), pi_set,getstate(pi_set)
(3.141592653589793⌁,false,3.141592653589793~,true)   # unset|exact value⌁   set|inexact value~

pi_tst = pi_clr; s1=getstate(pi_tst); setstate(pi_tst); s2=getstate(pi_tst); s3=getstate(clearstate(pi_tst));
julia> s1,s2,s3
(false,true,false)

julia> a = exp(pi_clr); b = exp(pi_set); a, getstate(a), b, getstate(b)
(23.140692632779267⌁,false,23.140692632779267~,true)

julia> pi_set*pi_set, getstate(pi_set*pi_set)
(9.869604401089358~,true)
julia> pi_set*pi_clr, getstate(pi_set*pi_clr)
(9.869604401089358~,true)
julia> pi_clr*pi_clr, getstate(pi_clr*pi_clr)
(9.869604401089358⌁,false)

julia> tiny=Float65(1.0e-250); huge=Float65(1.0e+250);
julia> tiny, 1/huge, tiny/huge, 1/tiny, huge, huge-tiny
(+TINY,+TINY,+TINY,+HUGE,+HUGE,+HUGE)

```
