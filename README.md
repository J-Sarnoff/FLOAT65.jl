### FLOAT65
```ruby
                      Jeffrey Sarnoff            2015-Dec-15
```

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



