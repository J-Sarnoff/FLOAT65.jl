### FLOAT65
```ruby
                      Jeffrey Sarnoff            2015-Dec-15
```
_*under development, frequent updates, the approach is not changing*_

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
Automatic propagation of the set state either occurs for all arithmetic and elementary functions,
or for none.  Either way, state may be set or cleared directly with setstate(x) and clearstate(x).
The set state will propagate unless when this module loads it finds this variable is assigned true:
Main.NoStatePropagation.

NoStatePropagation = true    # the set state will not propagate into the result of
                             #     arithmetic and elementary function calculations
using FLOAT65                # NoStatePropagation = true (MUST come first if used)
```
```julia
pi_clr = Float65(pi); pi_set = setstate(Float65(pi));
julia> getstate(pi_clr), pi_clr # ( false, 3.141592653589793̇ )  #  unset state,   exact valuė     value dots final digit
julia> getstate(pi_set), pi_set # ( true,  3.141592653589793⌁)  #    set state, inexact value~    value has postfix '~' 

pi_tst = pi_clr; s1=getstate(pi_tst); setstate(pi_tst); s2=getstate(pi_tst); s3=getstate(clearstate(pi_tst));
julia> s1,s2,s3 # (false,true,false)

julia> pi_set*pi_set, getstate(pi_set*pi_set)  # (9.869604401089358~,true)
julia> pi_set*pi_clr, getstate(pi_set*pi_clr)  # (9.869604401089358̇ ,false)
julia> pi_clr*pi_clr, getstate(pi_clr*pi_clr)  # (9.869604401089358̇ ,false)

julia> tiny=Float65(1.0e-250); huge=Float65(1.0e+250);

julia> tiny, 1/huge, tiny/huge, 1/tiny, huge, huge-tiny
(+TINY,+TINY,+TINY,+HUGE,+HUGE,+HUGE)
julia> tiny+tiny, tiny-tiny, tiny*tiny, tiny/tiny
(+TiNY,0.0̇ ,+TiNY,1.0̇ )

julia> tiny*tiny, tiny/huge, huge*huge, huge/tiny, tiny*huge
(+TiNY,+TiNY,+HuGE,+HuGE,1.0̇ )
```
