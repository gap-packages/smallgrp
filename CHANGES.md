This file describes changes in the smallgrp package.

# 1.7.0 (2026-08-18)


  - Added `SmallGroupsAddLayer` as a clean interface for extending the
    Small Groups Library by a further layer.
  - Optimized `NumberSmallGroups` to be much faster in certain cases. For
    example `NumberSmallGroups(1536, IsSolvableGroup, true)` is now instant
    instead of running for 90 seconds.

# 1.6.0 (2026-08-09)

  - Require GAP 4.12
  - `NumberSmallGroups` now accepts a list of orders and the selection
    criteria of `AllSmallGroups`, as in `NumberSmallGroups(96, IsAbelian)`
    (issue #68)
  - Selection by `IsAbelian`, `IsNilpotentGroup`, `IsSupersolvableGroup`,
    `IsSolvableGroup`, `RankPGroup` and `PClassPGroup` now avoids
    constructing the groups for most orders which had no precomputed data,
    among them 512, 1152, 1536, 1920, the orders 2^n * q and p^n * q^m, and
    the squarefree, cubefree and prime power orders. So
    `IdsOfAllSmallGroups([1 .. 2000], IsSupersolvableGroup, false)` built
    412 million groups and now builds 3024. `SmallGroupsInformation` reports
    what a given order offers. Indexing `IsSupersolvableGroup` was Thomas
    Breuer's suggestion in issue #4
  - A selection criterion now means the same for every order. They differed
    in whether `IsSolvable` was accepted for `IsSolvableGroup`, in what
    `IsSolvableGroup, [true, false]` selected, and in whether a property
    asked for a non-boolean was rejected
  - Fix selection by `LGLength`, for which the library stores `false` where
    the attribute returns `fail`: `AllSmallGroups(240, LGLength, fail)` was
    empty though there are 8 such groups. Both values work now
  - Fix a list of group numbers being ignored when every criterion was
    indexed: `IdsOfAllSmallGroups(96, [1, 2, 3], IsAbelian, true)` returned
    all abelian groups of order 96
  - Correct the permutation for order 11^7 documented under
    `SMALL_GROUPS_OLD_ORDER`: releases 1.1-1.3 mapped id 5 to 721056, not
    721059. Only the documentation was wrong, never the code
  - Merged the old `README` file into `README.md` and the package manual:
    its description of the library's organisation (layers, storage formats,
    identification algorithms) is now a chapter of the manual

# 1.5.5 (2026-07-28)

  - Drop spurious dependency on GAPDoc
  - Minor janitorial changes

# 1.5.4 (2024-07-04)

  - Don't attempt to load non-existent source files (this was
    harmless so far as it failed silently, but in future GAP
    versions may result in a scary warning or even an error)

# 1.5.3 (2023-05-16)

  - Fix `SmallGroupsAvailable(p^7)` to return `false` when p > 11
    (unless the `sglppow` package is loaded)
  - Update contact details for Max Horn

# 1.5.2 (2023-02-11)

  - Correct the information printed by `SmallGroupsInformation(512)`;
    it used to claim that the groups with id 387 - 1698 all have p-class 5,
    but in fact those with id 445 - 858 only have p-class 4.
  - Minor janitorial changes

# 1.5.1 (2022-11-04)

  - Compress data files to reduce on-disk footprint

# 1.5 (2022-04-06)

  - Replaced the GAP Team as maintainer by Max Horn upon request by the
    authors
  - Corrected the number of groups of order 2^10 = 1024; it is 49487367289.
    This error was pointed out by David Burrell. For details refer
    to his paper "On the number of groups of order 1024", Comm. Alg. (2021), 1–3.

# 1.4.2 (2020-12-18)
  - In release 1.4, the ordering of groups of orders 3^7, 5^7, 7^7, 11^7 was
    aligned with Magma. However, due to an oversight this was not applied to
    SelectSmallGroups and hence not to OneSmallGroup, AllSmallGroups, and
    IdsOfAllSmallGroups. As a result, these commands in some rare cases may have
    produced a group with an incorrect IdGroup attribute set respectively
    listed some groups in the wrong order. This has been fixed.
  - Various janitorial changes

# 1.4.1 (2019-09-26)
  - Fix a broken link in the manual

# 1.4 (2019-09-21)
  - Add SmallGroupsAvailable, NumberSmallGroupsAvailable, IdGroupsAvailable
  - Align ordering with Magma for orders 3^7,5^7,7^7,11^7
  - Reject non-positive sizes in various functions
  - Add more manual examples
  - Various janitorial changes

# 1.3 (2018-04-09)
  - Change maintainer to GAP team
  - Clarify package license by updating the copyright statements in
    COPYRIGHT.md and README to mention the Artistic License 2.0
  - Ensure that p-groups "know" the value of p by always calling
    SetPrimePGroup after SetIsPGroup
  - Various janitorial changes

# 1.2 (2017-10-02)
  - Fix a broken test file

# 1.1 (2017-10-02)
  - Changed license to Artistic License 2.0
  - ...

# 1.0 (2016-10-03)
