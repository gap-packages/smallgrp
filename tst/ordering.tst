gap> START_TEST("ordering.tst");;

#
gap> PermList(List([1..30087], SMALL_GROUPS_PERM5));
(2,30083)(3,30084)(4,30085)(5,30086)
gap> PermList(List([1..104602], SMALL_GROUPS_PERM7));
(2,104599)(3,104600)(4,104601)(5,104602)
gap> PermList(List([1..721057], SMALL_GROUPS_PERM11));
(2,721053)(3,721054)(4,721055)(5,721056)

#
gap> TestSmallPerm := function(n, low, high)
> local ord, res, old_low, old_high, new_low, new_high;
> ord := SMALL_GROUPS_OLD_ORDER;
> SMALL_GROUPS_OLD_ORDER := false;
> new_low := List(low, i -> CodePcGroup(SmallGroup(n, i)));;
> new_high := List(high, i -> CodePcGroup(SmallGroup(n, i)));;
> SMALL_GROUPS_OLD_ORDER := true;;
> old_low := List(low, i -> CodePcGroup(SmallGroup(n, i)));;
> old_high := List(high, i -> CodePcGroup(SmallGroup(n, i)));;
> SMALL_GROUPS_OLD_ORDER := ord;
> return new_low = old_high and new_high = old_low;
> end;;

#
gap> TestSmallPerm(5^7, [2..5], [30083..30086]);
true
gap> TestSmallPerm(7^7, [2..5], [104599..104602]);
true
gap> TestSmallPerm(11^7, [2..5], [721053..721056]);
true

#
gap> STOP_TEST("ordering,tst");;
