gap> START_TEST("ordering.tst");;

#
gap> PermList(List([1..NrSmallGroups(3^7)],SMALLGP_PERM3));
(7223,7226)(7224,7225)
gap> Order(PermList(List([1..NrSmallGroups(5^7)],SMALLGP_PERM5)));
29064892616760
gap> Order(PermList(List([1..NrSmallGroups(7^7)],SMALLGP_PERM7)));
19308644774268106374
gap> Order(PermList(List([1..NrSmallGroups(11^7)],SMALLGP_PERM11)));
4900488315903285563137680
gap> G := SmallGroup(5^7,656);;
gap> H := OneSmallGroup(Size,5^7,G->IdGroup(G)[2],656);;
gap> CodePcGroup(G) = CodePcGroup(H);
true

#
gap> STOP_TEST("ordering,tst");;
