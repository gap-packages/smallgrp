#
# Counting a selection without listing it
#
gap> START_TEST("count.tst");

# the orders where listing is out of the question
gap> NumberSmallGroups(1536, IsSolvableGroup, true);
408641062
gap> NumberSmallGroups(1536, IsNilpotentGroup, true);
10494213
gap> NumberSmallGroups(512, RankPGroup, 2);
2043
gap> NumberSmallGroups(1920, IsSolvableGroup, false);
588

# counting agrees with listing wherever listing is affordable
gap> orders := [ 12, 30, 64, 96, 128, 720, 1016, 1029, 1088, 1215, 2002,
>                2004, 3420 ];;
gap> props := [ IsAbelian, IsNilpotentGroup, IsSupersolvableGroup,
>               IsSolvableGroup ];;
gap> ForAll(orders, n -> ForAll(props, f -> ForAll([true, false], v ->
>      NumberSmallGroups(n, f, v) = Length(IdsOfAllSmallGroups(n, f, v)))));
true

# with a list of group numbers, and with a criterion no layer indexes
gap> ForAll(orders, n -> NumberSmallGroups(n,
>        Filtered([1 .. NrSmallGroups(n)], IsOddInt), IsAbelian, true)
>      = Length(IdsOfAllSmallGroups(n,
>        Filtered([1 .. NrSmallGroups(n)], IsOddInt), IsAbelian, true)));
true
gap> ForAll(orders, n ->
>      NumberSmallGroups(n, IsSolvableGroup, true, IsCyclic, false)
>        = Length(IdsOfAllSmallGroups(n, IsSolvableGroup, true, IsCyclic,
>                                     false)));
true

# several orders at once, with and without criteria
gap> NumberSmallGroups([1 .. 100]) = Sum([1 .. 100], NrSmallGroups);
true
gap> NumberSmallGroups(Size, [96, 720], IsAbelian, true)
>      = Length(IdsOfAllSmallGroups(Size, [96, 720], IsAbelian, true));
true

#
gap> STOP_TEST("count.tst");
