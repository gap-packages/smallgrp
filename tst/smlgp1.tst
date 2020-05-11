#
gap> START_TEST("smlgp1.tst");;

################################################################################
# Layer 1: SMALL_AVAILABLE_FUNCS
################################################################################
gap> IsBound(SMALL_AVAILABLE_FUNCS);
true
gap> IsBound(SMALL_AVAILABLE_FUNCS);
true
gap> SMALL_AVAILABLE_FUNCS[1];
function( size ) ... end
gap> SMALL_AVAILABLE_FUNCS[1](2 * 3 * 5 * 7);
fail
gap> SMALL_AVAILABLE_FUNCS[1](1049);
rec( func := 1, number := 1 )
gap> SMALL_AVAILABLE_FUNCS[1](2 * 2);
rec( func := 2, number := 2, p := 2 )
gap> SMALL_AVAILABLE_FUNCS[1](2 * 3);
rec( func := 3, p := 2, q := 3 )
gap> SMALL_AVAILABLE_FUNCS[1](3 * 3 * 3);
rec( func := 4, number := 5, p := 3 )
gap> SMALL_AVAILABLE_FUNCS[1](2 * 2 * 3);
rec( func := 5, p := 2, q := 3 )
gap> SMALL_AVAILABLE_FUNCS[1](2 * 3 * 3);
rec( func := 6, p := 2, q := 3 )
gap> SMALL_AVAILABLE_FUNCS[1](5 * 7 * 11);
rec( func := 7, p := 5, q := 7, r := 11 )

################################################################################
# Layer 1: SMALL_GROUP_FUNCS
################################################################################
#
# Order p
gap> SMALL_GROUP_FUNCS[1];
function( size, i, inforec ) ... end
gap> inforec := SMALL_AVAILABLE_FUNCS[1](2);
rec( func := 1, number := 1 )
gap> SMALL_GROUP_FUNCS[1](2, 2, inforec);
Error, there is just 1 group of size 2
gap> IsCyclic(SMALL_GROUP_FUNCS[1](2, 1, inforec));
true

# Order p ^ 2
gap> SMALL_GROUP_FUNCS[2];
function( size, i, inforec ) ... end
gap> inforec := SMALL_AVAILABLE_FUNCS[1](9);
rec( func := 2, number := 2, p := 3 )
gap> SMALL_GROUP_FUNCS[2](9, 3, rec());
Error, there are just 2 groups of size 9
gap> IsElementaryAbelian(SMALL_GROUP_FUNCS[2](9, 2, rec()));
true
gap> IsCyclic(SMALL_GROUP_FUNCS[2](9, 1, rec()));
true

# Order p * q
gap> SMALL_GROUP_FUNCS[3];
function( size, i, inforec ) ... end
gap> inforec := SMALL_AVAILABLE_FUNCS[1](6);
rec( func := 3, p := 2, q := 3 )
gap> IsSymmetricGroup(SMALL_GROUP_FUNCS[3](6, 1, inforec));
true
gap> inforec := SMALL_AVAILABLE_FUNCS[1](35);
rec( func := 3, p := 5, q := 7 )
gap> IsCyclic(SMALL_GROUP_FUNCS[3](35, 1, inforec));
true
gap> SMALL_GROUP_FUNCS[3](35, inforec.number + 1, inforec);
Error, there are just 1 groups of size 35

# Order p ^ 3
gap> SMALL_GROUP_FUNCS[4];
function( size, i, inforec ) ... end
gap> inforec := SMALL_AVAILABLE_FUNCS[1](27);
rec( func := 4, number := 5, p := 3 )
gap> SMALL_GROUP_FUNCS[4](27, 6, inforec);
Error, there are just 5 groups of size 27
gap> G := SMALL_GROUP_FUNCS[4](27, 5, inforec);
<pc group of size 27 with 3 generators>
gap> IsAbelian(G);
true
gap> G := SMALL_GROUP_FUNCS[4](27, 4, inforec);
<pc group of size 27 with 3 generators>
gap> IsAbelian(G);
false
gap> G := SMALL_GROUP_FUNCS[4](27, 3, inforec);
<pc group of size 27 with 3 generators>
gap> IsAbelian(G);
false
gap> G := SMALL_GROUP_FUNCS[4](27, 2, inforec);
<pc group of size 27 with 3 generators>
gap> IsAbelian(G) and not IsCyclic(G);
true
gap> IsCyclic(SMALL_GROUP_FUNCS[4](27, 1, inforec));
true
gap> G := SMALL_GROUP_FUNCS[4](8, 4, SMALL_AVAILABLE_FUNCS[1](8));
<pc group of size 8 with 3 generators>
gap> StructureDescription(G);
"Q8"

# Order p ^ 2 * q
gap> SMALL_GROUP_FUNCS[5];
function( size, i, inforec ) ... end
gap> inforec := SMALL_AVAILABLE_FUNCS[1](45);
rec( func := 5, p := 3, q := 5 )
gap> IsCyclic(SMALL_GROUP_FUNCS[5](45, 1, inforec));
true
gap> inforec;
rec( func := 5, number := 2, p := 3, q := 5, types := [ "p2q", "ppq" ] )
gap> SMALL_GROUP_FUNCS[5](45, inforec.number + 1, inforec);
Error, there are just 2 groups of size 45
gap> not IsCyclic(SMALL_GROUP_FUNCS[5](45, 2, inforec));
true
gap> inforec := SMALL_AVAILABLE_FUNCS[1](12);
rec( func := 5, p := 2, q := 3 )
gap> G := SMALL_GROUP_FUNCS[5](12, 1, inforec);
<pc group of size 12 with 3 generators>
gap> StructureDescription(G);
"C3 : C4"
gap> StructureDescription(SMALL_GROUP_FUNCS[5](12, 3, inforec));
"A4"
gap> inforec := SMALL_AVAILABLE_FUNCS[1](20);
rec( func := 5, p := 2, q := 5 )
gap> G := SMALL_GROUP_FUNCS[5](20, 3, inforec);
<pc group of size 20 with 3 generators>
gap> StructureDescription(G);
"C5 : C4"
gap> StructureDescription(SMALL_GROUP_FUNCS[5](20, 4, inforec));
"D20"

# Order p * q ^ 2
gap> SMALL_GROUP_FUNCS[6];
function( size, i, inforec ) ... end
gap> inforec := SMALL_AVAILABLE_FUNCS[1](18);
rec( func := 6, p := 2, q := 3 )
gap> IsCyclic(SMALL_GROUP_FUNCS[6](18, 2, inforec));
true
gap> inforec;
rec( func := 6, number := 5, p := 2, q := 3, 
  types := [ "Mpq2", "pq2", "Dpqxq", 1, "pqq" ] )
gap> SMALL_GROUP_FUNCS[6](18, inforec.number + 1, inforec);
Error, there are just 5 groups of size 18
gap> G := SMALL_GROUP_FUNCS[6](18, 1, inforec);
<pc group of size 18 with 3 generators>
gap> IsDihedralGroup(G);
true
gap> G := SMALL_GROUP_FUNCS[6](18, 3, inforec);
<pc group of size 18 with 3 generators>
gap> IsAbelian(G);
false
gap> G := SMALL_GROUP_FUNCS[6](18, 4, inforec);
<pc group of size 18 with 3 generators>
gap> StructureDescription(G);
"(C3 x C3) : C2"
gap> inforec := SMALL_AVAILABLE_FUNCS[1](75);
rec( func := 6, p := 3, q := 5 )
gap> G := SMALL_GROUP_FUNCS[6](75, 2, inforec);
<pc group of size 75 with 3 generators>
gap> StructureDescription(G);
"(C5 x C5) : C3"
gap> G := SMALL_GROUP_FUNCS[6](75, 3, inforec);
<pc group of size 75 with 3 generators>
gap> StructureDescription(G);
"C15 x C5"

# Order p * q * r
gap> SMALL_GROUP_FUNCS[7];
function( size, i, inforec ) ... end
gap> inforec := SMALL_AVAILABLE_FUNCS[1](165);
rec( func := 7, p := 3, q := 5, r := 11 )
gap> IsCyclic(SMALL_GROUP_FUNCS[7](165, 2, inforec));
true
gap> inforec;
rec( func := 7, number := 2, p := 3, q := 5, r := 11, 
  types := [ "Dqrxp", "pqr" ] )
gap> SMALL_GROUP_FUNCS[7](165, inforec.number + 1, inforec);
Error, there are just 2 groups of size 165
gap> G := SMALL_GROUP_FUNCS[7](165, 1, inforec);
<pc group of size 165 with 3 generators>
gap> IsAbelian(G);
false
gap> inforec := SMALL_AVAILABLE_FUNCS[1](42);
rec( func := 7, p := 2, q := 3, r := 7 )
gap> IsCyclic(SMALL_GROUP_FUNCS[7](42, 6, inforec));
true
gap> inforec;
rec( func := 7, number := 6, p := 2, q := 3, r := 7, 
  types := [ "Hpqr", "Dqrxp", "Dpqxr", "Dprxq", 1, "pqr" ] )
gap> SMALL_GROUP_FUNCS[7](42, 1, inforec);
<pc group of size 42 with 3 generators>
gap> SMALL_GROUP_FUNCS[7](42, 2, inforec);
<pc group of size 42 with 3 generators>
gap> SMALL_GROUP_FUNCS[7](42, 3, inforec);
<pc group of size 42 with 3 generators>
gap> SMALL_GROUP_FUNCS[7](42, 4, inforec);
<pc group of size 42 with 3 generators>
gap> SMALL_GROUP_FUNCS[7](42, 5, inforec);
<pc group of size 42 with 3 generators>

################################################################################
# Layer 1: SELECT_SMALL_GROUP_FUNCS
################################################################################
gap> f := SELECT_SMALL_GROUPS_FUNCS[1];
function( size, funcs, vals, inforec, all, id, idList ) ... end
gap> IsIdenticalObj(SELECT_SMALL_GROUPS_FUNCS[1], f);
true
gap> IsIdenticalObj(SELECT_SMALL_GROUPS_FUNCS[2], f);
true
gap> IsIdenticalObj(SELECT_SMALL_GROUPS_FUNCS[3], f);
true
gap> IsIdenticalObj(SELECT_SMALL_GROUPS_FUNCS[4], f);
true
gap> IsIdenticalObj(SELECT_SMALL_GROUPS_FUNCS[5], f);
true
gap> IsIdenticalObj(SELECT_SMALL_GROUPS_FUNCS[6], f);
true
gap> IsIdenticalObj(SELECT_SMALL_GROUPS_FUNCS[7], f);
true

# We avoid viewing cyclic groups to avoid the grammatically incorrect output
# '1 generators' given by older versions of GAP
gap> SELECT_SMALL_GROUPS_FUNCS[1](7, [IsCyclic], [[true]],
> SMALL_AVAILABLE_FUNCS[1](7), true, true, fail);
[ [ 7, 1 ] ]
gap> SELECT_SMALL_GROUPS_FUNCS[1](7, [IsCyclic], [[false]],
> SMALL_AVAILABLE_FUNCS[1](7), true, true, fail);
[  ]
gap> SELECT_SMALL_GROUPS_FUNCS[1](7, [IsCyclic], [[false]],
> SMALL_AVAILABLE_FUNCS[1](7), false, true, fail);
fail
gap> SELECT_SMALL_GROUPS_FUNCS[1](7, [Size], [[7]],
> SMALL_AVAILABLE_FUNCS[1](7), true, true, [1]);
[ [ 7, 1 ] ]
gap> x := SELECT_SMALL_GROUPS_FUNCS[1](7, [Size], [[7]],
> SMALL_AVAILABLE_FUNCS[1](7), true, false, [1]);;
gap> Length(x) = 1 and Size(x[1]) = 7 and Length(GeneratorsOfGroup(x[1])) = 1;
true
gap> x := SELECT_SMALL_GROUPS_FUNCS[1](7, [Size], [[7]],
> SMALL_AVAILABLE_FUNCS[1](7), false, false, [1]);;
gap> Size(x) = 7 and Length(GeneratorsOfGroup(x)) = 1;
true
gap> SELECT_SMALL_GROUPS_FUNCS[5](45, [IsCyclic], [[true]],
> SMALL_AVAILABLE_FUNCS[1](45), false, false, fail);
<pc group of size 45 with 3 generators>

#
gap> STOP_TEST("smlgp1.tst");
