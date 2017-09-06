# Test file by Wilf A. Wilson
#
gap> START_TEST("idgrp1.tst");;

# 1
gap> ID_GROUP_FUNCS[1](Group((1,2)), SMALL_AVAILABLE(2)); 
1

# 2
gap> ID_GROUP_FUNCS[2](Group((1,2), (3,4)), SMALL_AVAILABLE(4)); 
2
gap> ID_GROUP_FUNCS[2](Group((1,2,3,4)), SMALL_AVAILABLE(4)); 
1

# 3
gap> ID_GROUP_FUNCS[3](Group([(1,2), (1,2,3)]), SMALL_AVAILABLE(6));
1
gap> ID_GROUP_FUNCS[3](Group([(1,2)(3,4,5)]), SMALL_AVAILABLE(6));
2

# 4
gap> ID_GROUP_FUNCS[4](Group([(1,2,3,4,5,6,7,8)]), SMALL_AVAILABLE(8));
1
gap> ID_GROUP_FUNCS[4](Group([(1,2,3,4), (5,6,7,8)]), SMALL_AVAILABLE(8));
2

#
gap> G := SmallGroup(100949, 5);;
gap> H := PcGroupCode(CodePcGroup(G), 100949);;
gap> IdSmallGroup(H);
[ 100949, 5 ]

#
gap> STOP_TEST("idgrp1.tst");;
