[![CI](https://github.com/gap-packages/smallgrp/actions/workflows/CI.yml/badge.svg)](https://github.com/gap-packages/smallgrp/actions/workflows/CI.yml)
[![Code Coverage](https://codecov.io/github/gap-packages/smallgrp/coverage.svg?branch=master&token=)](https://codecov.io/gh/gap-packages/smallgrp)

# The SmallGrp GAP package

The Small Groups Library is a catalogue of groups of "small" order. The groups
are sorted by their orders and they are listed up to isomorphism; that is, for
each of the available orders a complete and irredundant list of isomorphism
type representatives of groups is given. Currently, the library contains the
groups

  * of order at most 2000 except 1024,
  * of cubefree order at most 50 000,
  * of order p^7 for the primes p = 3, 5, 7, 11,
  * of order p^n for n <= 6 and all primes p,
  * of order q^n * p for q^n dividing 2^8, 3^6, 5^5 or 7^4, and p a prime
    different from q,
  * of squarefree order,
  * whose order factorises into at most 3 primes.

The package provides access to the groups of these orders, and a method to
identify the catalogue number of a given group for many of these orders.


## Documentation

Full information and documentation can be found in the manual, available
as PDF `doc/manual.pdf` or as HTML `doc/chap0_mj.html`, or on the package
homepage at

  <https://gap-packages.github.io/smallgrp/>

Besides describing the available functions, the manual also documents how the
library is organised: how the groups were determined, how they are stored, and
which algorithms the identification routines use.


## Related packages

Groups of further orders are provided by other GAP packages:

  * [SglPPow](https://gap-packages.github.io/sglppow/) provides the groups of
    order p^7 for primes p > 11 and those of order 3^8. It extends this
    library: once loaded, its groups are available via `SmallGroup` and
    friends.
  * [SOTGrps](https://gap-packages.github.io/sotgrps/) constructs and
    identifies the groups whose order factorises into at most 4 primes, and
    those of order p^4 * q. It uses its own functions and its own numbering,
    which in general differs from the one used here.


## Bug reports and feature requests

Please submit bug reports and feature requests via our GitHub issue tracker:

  <https://github.com/gap-packages/smallgrp/issues>


## Authors

The Small Groups Library has been constructed by Hans Ulrich Besche, Bettina
Eick and Eamonn O'Brien. It is maintained by Max Horn.


# License

The Small Groups Library is free software distributed under
the [Artistic License 2.0](https://opensource.org/licenses/Artistic-2.0).

For details see the files `LICENSE` and `COPYRIGHT.md`.
