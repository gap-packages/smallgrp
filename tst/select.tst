#
# Tests for the property based selection performed by SelectSmallGroups
#
gap> START_TEST("select.tst");

################################################################################
# helpers for the lists of group numbers
################################################################################
gap> SMALL_IDS_EXPAND([]);
[  ]
gap> SMALL_IDS_EXPAND([1, [5 .. 8], 12]);
[ 1, 5, 6, 7, 8, 12 ]
gap> SMALL_IDS_EXPAND([[4 .. 9]]);
[ 4 .. 9 ]
gap> SMALL_IDS_UNION([[1 .. 3], 8, [10 .. 11]], [[4 .. 5], 12]);
[ [ 1 .. 5 ], [ 8 ], [ 10 .. 12 ] ]
gap> SMALL_IDS_INTERSECTION([[1 .. 10]], [[4 .. 5], 12]);
[ [ 4, 5 ] ]
gap> SMALL_IDS_DIFFERENCE([[1 .. 10]], [[4 .. 5], 12]);
[ [ 1 .. 3 ], [ 6 .. 10 ] ]
gap> SMALL_IDS_DIFFERENCE([[1 .. 5], [10 .. 20]], [[3 .. 12], 18]);
[ [ 1, 2 ], [ 13 .. 17 ], [ 19, 20 ] ]
gap> Filtered([0 .. 13], i -> SMALL_IDS_MEMBER([[1 .. 3], 5, [8 .. 11]], i));
[ 1, 2, 3, 5, 8, 9, 10, 11 ]

# the data files use an older description, in which a negative entry marks
# the end of a range
gap> SMALL_IDS_FROM_LIBRARY([1, -3, 5, 8, -11]);
[ [ 1 .. 3 ], 5, [ 8 .. 11 ] ]

################################################################################
# the orders 1152 and 1920, see issue #4; none of the following may construct
# any of the more than 150000 groups of these orders
################################################################################
gap> IdsOfAllSmallGroups(1920, IsSolvableGroup, false)
>      = List([240417 .. 241004], i -> [1920, i]);
true
gap> IdsOfAllSmallGroups(1920, IsNilpotentGroup, true)
>      = List([1 .. 2328], i -> [1920, i]);
true
gap> IdsOfAllSmallGroups(1152, IsSolvableGroup, false);
[  ]
gap> IdsOfAllSmallGroups(1152, IsNilpotentGroup, true)
>      = List([1 .. 4656], i -> [1152, i]);
true
gap> IdGroup(OneSmallGroup(1920, IsSolvableGroup, false));
[ 1920, 240417 ]
gap> IdGroup(OneSmallGroup(1152, IsNilpotentGroup, false));
[ 1152, 4657 ]

# the boundaries of the ranges used above
gap> List([2328, 2329], i -> IsNilpotentGroup(SmallGroup(1920, i)));
[ true, false ]
gap> List([240416, 240417], i -> IsSolvableGroup(SmallGroup(1920, i)));
[ true, false ]
gap> List([4656, 4657], i -> IsNilpotentGroup(SmallGroup(1152, i)));
[ true, false ]

################################################################################
# the abelian groups sit where those of the order of the nilpotent part do
################################################################################
gap> List([768, 1152, 1920, 1536], n ->
>         Length(IdsOfAllSmallGroups(n, IsAbelian, true)));
[ 22, 30, 15, 30 ]
gap> List([8, 7, 7, 9], NrPartitions);   # and that is what there should be
[ 22, 15, 15, 30 ]
gap> IdsOfAllSmallGroups(768, IsAbelian, true)
>      = List(IdsOfAllSmallGroups(256, IsAbelian, true), x -> [768, x[2]]);
true
gap> IdsOfAllSmallGroups(1536, IsAbelian, true)
>      = List(IdsOfAllSmallGroups(512, IsAbelian, true), x -> [1536, x[2]]);
true
gap> ForAll(IdsOfAllSmallGroups(1536, IsAbelian, true),
>           x -> IsAbelian(SmallGroup(x)));
true
gap> ForAll(IdsOfAllSmallGroups(768, IsAbelian, true),
>           x -> IsAbelian(SmallGroup(x)));
true

################################################################################
# IsSupersolvableGroup, see issue #4
################################################################################
gap> IdsOfAllSmallGroups(1920, IsSupersolvableGroup, false)
>      = List([236345 .. 241004], i -> [1920, i]);
true
gap> IdGroup(OneSmallGroup(1536, IsSupersolvableGroup, false));
[ 1536, 408526598 ]
gap> List([408526597, 408526598],
>         i -> IsSupersolvableGroup(SmallGroup(1536, i)));
[ true, false ]
gap> IdGroup(OneSmallGroup(768, IsSupersolvableGroup, false));
[ 768, 1083473 ]
gap> Length(IdsOfAllSmallGroups(1152, IsSupersolvableGroup, false));
13010
gap> IdGroup(OneSmallGroup(1152, IsSupersolvableGroup, false));
[ 1152, 4660 ]
gap> List([4659, 4660], i -> IsSupersolvableGroup(SmallGroup(1152, i)));
[ true, false ]

# the orders 2^n * q and q^n * p: a group is supersolvable exactly if it has
# a normal Sylow subgroup for the prime occurring once, unless the chief
# factors of the other Sylow subgroup are one dimensional, i.e. q = 1 mod p
gap> List([1029, 1458], n -> IdsOfAllSmallGroups(n, IsSupersolvableGroup, false));
[ [  ], [  ] ]
gap> IdsOfAllSmallGroups(1215, IsSupersolvableGroup, false);
[ [ 1215, 68 ], [ 1215, 69 ] ]

################################################################################
# the order 1536
################################################################################
gap> IdGroup(OneSmallGroup(1536, IsNilpotentGroup, false));
[ 1536, 10494214 ]
gap> OneSmallGroup(1536, IsSolvableGroup, false);
fail
gap> List([10494213, 10494214], i -> IsNilpotentGroup(SmallGroup(1536, i)));
[ true, false ]

################################################################################
# groups of prime power order are nilpotent; for some of the orders the rank
# and the p-class are known from the position as well
################################################################################
gap> IdsOfAllSmallGroups(512, IsNilpotentGroup, false);
[  ]
gap> IdsOfAllSmallGroups(512, IsSupersolvableGroup, false);
[  ]
gap> IdsOfAllSmallGroups(3^7, IsSolvableGroup, false);
[  ]
gap> IdsOfAllSmallGroups(11^6, IsNilpotentGroup, false);
[  ]
gap> IdGroup(OneSmallGroup(512, IsNilpotentGroup, true));
[ 512, 1 ]

# none of the following may construct any of the 10494213 groups of order 512
gap> Length(IdsOfAllSmallGroups(512, RankPGroup, 2));
2043
gap> Length(IdsOfAllSmallGroups(512, PClassPGroup, 2));
8785772
gap> Length(IdsOfAllSmallGroups(512, RankPGroup, 2, PClassPGroup, 4));
790
gap> IdsOfAllSmallGroups(512, RankPGroup, 9);
[ [ 512, 10494213 ] ]
gap> IdsOfAllSmallGroups(512, RankPGroup, 1);
[ [ 512, 1 ] ]

# the ranks and p-classes of order 512 agree with the groups themselves
gap> ForAll(SMALL_GROUPS_512_TYPES, t -> ForAll([t[1], t[2]],
>      i -> [RankPGroup(SmallGroup(512, i)), PClassPGroup(SmallGroup(512, i))]
>             = [t[3], t[4]]));
true

# orders p^4 and p^5
gap> List([1 .. 5], r -> List(IdsOfAllSmallGroups(14641, RankPGroup, r),
>                             x -> x[2]));
[ [ 1 ], [ 2, 3, 4, 5, 6, 7, 8, 9, 10 ], [ 11, 12, 13, 14 ], [ 15 ], [  ] ]
gap> List(IdsOfAllSmallGroups(14641, IsAbelian, true), x -> x[2]);
[ 1, 2, 5, 11, 15 ]
gap> List(IdsOfAllSmallGroups(16807, RankPGroup, [1, 5]), x -> x[2]);
[ 1, 83 ]
gap> Number([1 .. NrSmallGroups(16807)],
>           i -> RankPGroup(SmallGroup(16807, i)) = 3)
>      = Length(IdsOfAllSmallGroups(16807, RankPGroup, 3));
true

# the abelian groups of order 512, one for each partition of 9
gap> Length(IdsOfAllSmallGroups(512, IsAbelian, true));
30
gap> IdsOfAllSmallGroups(512, IsAbelian, true){[1, 30]};
[ [ 512, 1 ], [ 512, 10494213 ] ]
gap> Length(IdsOfAllSmallGroups(512, IsAbelian, true, RankPGroup, 3));
7
gap> ForAll(IdsOfAllSmallGroups(512, IsAbelian, true),
>           x -> IsAbelian(SmallGroup(x)));
true

# order p^6: the first isoclinism family consists of the abelian groups; the
# ranks and p-classes are stored for the two smallest such orders
gap> List(IdsOfAllSmallGroups(15625, IsAbelian, true), x -> x[2]);
[ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ]
gap> [Length(IdsOfAllSmallGroups(15625, RankPGroup, 3)),
>     Length(IdsOfAllSmallGroups(15625, PClassPGroup, 4)),
>     Length(IdsOfAllSmallGroups(117649, RankPGroup, 3))];
[ 429, 111, 563 ]
gap> ForAll([1 .. NrSmallGroups(15625)], i -> ForAll([RankPGroup, PClassPGroup],
>      f -> [15625, i] in IdsOfAllSmallGroups(15625, f, f(SmallGroup(15625, i)))));
true

# order p^7: the ranks, p-classes and abelian groups are stored for the two
# smallest such orders, where they were determined by brute force
gap> [Length(IdsOfAllSmallGroups(2187, RankPGroup, 3)),
>     Length(IdsOfAllSmallGroups(2187, PClassPGroup, 2)),
>     Length(IdsOfAllSmallGroups(78125, RankPGroup, 3)),
>     Length(IdsOfAllSmallGroups(78125, PClassPGroup, 3))];
[ 5474, 1565, 22104, 22797 ]
gap> List(IdsOfAllSmallGroups(2187, RankPGroup, 7), x -> x[2]);
[ 9310 ]
gap> List(IdsOfAllSmallGroups(2187, IsAbelian, true), x -> x[2]);
[ 1, 79, 312, 384, 409, 4070, 5297, 5841, 5866, 7957, 9043, 9093, 9271, 9301, 
  9310 ]
gap> ForAll(IdsOfAllSmallGroups(2187, IsAbelian, true),
>           x -> IsAbelian(SmallGroup(x)));
true
gap> ForAll(IdsOfAllSmallGroups(78125, RankPGroup, 6),
>           x -> RankPGroup(SmallGroup(x)) = 6);
true

################################################################################
# cubefree orders: solvable unless there is a PSL( 2, p ) direct factor, and
# nilpotent exactly for the first group of every solvable range
################################################################################
gap> IdsOfAllSmallGroups(3420, IsSolvableGroup, false);
[ [ 3420, 142 ], [ 3420, 143 ], [ 3420, 144 ] ]
gap> IdsOfAllSmallGroups(3660, IsNilpotentGroup, true);
[ [ 3660, 1 ], [ 3660, 19 ] ]
gap> IdsOfAllSmallGroups(3900, IsNilpotentGroup, true);
[ [ 3900, 1 ], [ 3900, 13 ], [ 3900, 53 ], [ 3900, 81 ] ]

################################################################################
# selections agree with checking the groups one by one
################################################################################
gap> orders := [ 12, 30,             # layers with at most three prime factors
>                96,                 # a layer with precomputed properties
>                1016, 1072, 1096,   # order 2^n * q
>                1029, 1107, 1215,   # order p^n * q^m
>                14641,              # order p^4
>                2002, 2046, 2145,   # squarefree order
>                2004, 2020, 3420 ];; # cubefree order
gap> groups := List(orders,
>                   n -> List([1 .. NrSmallGroups(n)], i -> SmallGroup(n, i)));;
gap> props := [ IsAbelian, IsNilpotentGroup, IsSupersolvableGroup,
>               IsSolvableGroup ];;
gap> byhand := function(k, prop, val)
>      return Filtered([1 .. Length(groups[k])], i -> prop(groups[k][i]) = val);
>    end;;
gap> ForAll([1 .. Length(orders)], k -> ForAll(props, prop ->
>      ForAll([true, false], val ->
>        List(IdsOfAllSmallGroups(orders[k], prop, val), x -> x[2])
>          = byhand(k, prop, val))));
true

# the same, restricted to a list of group numbers
gap> IdsOfAllSmallGroups(96, [1, 2, 3], IsAbelian, true);
[ [ 96, 2 ] ]
gap> ForAll([1 .. Length(orders)], k -> ForAll(props, prop ->
>      ForAll([true, false], val ->
>        List(IdsOfAllSmallGroups(orders[k],
>                                 Filtered([1 .. Length(groups[k])], IsOddInt),
>                                 prop, val), x -> x[2])
>          = Filtered(byhand(k, prop, val), IsOddInt))));
true

# the same, for OneSmallGroup
gap> ForAll([1 .. Length(orders)], k -> ForAll(props, prop ->
>      ForAll([true, false], val ->
>        byhand(k, prop, val) = []
>          and OneSmallGroup(orders[k], prop, val) = fail
>        or IdGroup(OneSmallGroup(orders[k], prop, val))
>             = [orders[k], byhand(k, prop, val)[1]])));
true

# properties which are not known in advance must still be checked
gap> ForAll([1 .. Length(orders)], k ->
>      List(IdsOfAllSmallGroups(orders[k], IsSolvableGroup, true,
>                               IsCyclic, false), x -> x[2])
>        = Filtered([1 .. Length(groups[k])],
>                   i -> IsSolvableGroup(groups[k][i])
>                        and not IsCyclic(groups[k][i])));
true

################################################################################
# preprocessing of the query
################################################################################
# a criterion admitting both values holds for every group and is dropped,
# no matter which layer the order belongs to
gap> ForAll([1 .. Length(orders)], k -> ForAll(props, prop ->
>      IdsOfAllSmallGroups(orders[k], prop, [true, false])
>        = List([1 .. Length(groups[k])], i -> [orders[k], i])));
true

# the deprecated names of the properties are treated the same way
gap> IdsOfAllSmallGroups(1920, IsSolvable, false)
>      = IdsOfAllSmallGroups(1920, IsSolvableGroup, false);
true
gap> IdsOfAllSmallGroups(1016, IsNilpotent, true)
>      = IdsOfAllSmallGroups(1016, IsNilpotentGroup, true);
true
gap> IdsOfAllSmallGroups(96, IsSupersolvable, false)
>      = IdsOfAllSmallGroups(96, IsSupersolvableGroup, false);
true

# a property asked for a value which is not a boolean is an error, again
# independently of the layer
gap> AllSmallGroups(96, IsSolvableGroup, 1);
Error, SelectSmallGroups: Use Test-Funcs with true or false
gap> AllSmallGroups(1016, IsSolvableGroup, 1);
Error, SelectSmallGroups: Use Test-Funcs with true or false
gap> AllSmallGroups(2004, IsAbelian, [true, 1]);
Error, SelectSmallGroups: Use Test-Funcs with true or false

# a test function which is not a property is left alone
gap> List(AllSmallGroups(1016, NrConjugacyClasses, [257, 635]),
>         NrConjugacyClasses);
[ 635, 635, 257, 257, 257 ]

#
gap> STOP_TEST("select.tst");
