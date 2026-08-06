#
# Constructing groups from the paths the other test files never take
#
gap> START_TEST("construct.tst");

# the 4912 groups of order 768 without a normal Sylow subgroup are stored in
# four files; take one group from each, and identify it again
gap> ids := [1085324, 1086574, 1087824, 1089074];;
gap> List(ids, i -> Size(SmallGroup(768, i)));
[ 768, 768, 768, 768 ]
gap> List(ids, i -> IdGroup(SmallGroup(768, i))) = List(ids, i -> [768, i]);
true

# p^7 for the primes other than 5, which tst/ordering.tst builds
gap> List([3^7, 7^7, 11^7], NrSmallGroups);
[ 9310, 113147, 750735 ]
gap> ForAll([3^7, 7^7, 11^7], n ->
>      ForAll([1, 2, NrSmallGroups(n)], i -> Size(SmallGroup(n, i)) = n));
true
gap> List([3^7, 7^7, 11^7], n -> RankPGroup(SmallGroup(n, NrSmallGroups(n))));
[ 7, 7, 7 ]
gap> List([3^7, 7^7, 11^7], n -> RankPGroup(SmallGroup(n, 1)));
[ 1, 1, 1 ]

#
gap> STOP_TEST("construct.tst");
