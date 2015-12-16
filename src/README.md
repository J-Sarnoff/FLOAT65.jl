###Some notes on Unum-like processing using Julia


Julia presents a platform that is amenable to unum-like work.  Implementing
unums exactly is less helpful than implementing a somewhat constrained
paradigm that provides the primary advantages of unums without the hardware-
oriented modelling. A concession to throughput practicality is to substitute
some predetermined value sizes for the highly variable sizing available with a
canonical unum.  Using the arithmetic rules which subsume Unums given by
Ulrich Kulisch in "Up-to-date Interval Arithmetic" allows conceptual
simplification and affords design clarity.  Simplicity is served further by
setting a family of 1D intervals to be the ground type.

####On the u-bit

I have implemented two ways for floating point values to have a settable,
gettable, switchable binary state.  One uses a type parameter, so the state is
carried as the subtype given by parameterization.  The other enfolds state
directly within the floating point value by appropriating one bit of the
exponent field.  The second truly offers a value that carries alterable state
and requires a fast decoding prior to calculation and fast encoding of the
result. With the first, statefulness carries the value and offers state-based
processing without appreciable runtime overhead. Importantly, enfolding state
immediately assures everywhere interoperability with e.g. Float64.


An untested working implementation of Float64s with enfolded binary state is
available at https://github.com/J-Sarnoff/FLOAT65.jl.  At best, which is with
elementary functions, on my machine it runs 2.5x slower.  At worst, which is
with multiply, it runs 6x slower than Float64*Float64.  The implementation
supports Tiny and Huge as collective, finite values.


An as-it-is-today implementation of Float64 based intervals with parameterized
binary state is available at https://github.com/J-Sarnoff/FlexFloat.jl.  There
is a better way to formulate the abstract types and concrete inheritance so that
intervals of differing states interoperate more simply, probably.  This module
really exists to show a way to process intervals that respects the axiomatics.


It is also possible to obviate the need for an u-bit state.  Where the ground
values are intervals (some may be point-like intervals) and uncertainty means
covering part of the real numbers that extend up to [down to] a bounding value
without reaching that value, then each uncertain interval has a nearest certain
interval and one may process everything using these nearest certain intervals.


####About the intervals


An implementation of intervals that should be appropriate to building unum-like
behavior over Float64s is available at https://github.com/J-Sarnoff/FlexFloat.jl.


