# Test file by Wilf A. Wilson
#
gap> START_TEST("small.tst");

################################################################################
# SMALL_AVAILABLE
################################################################################
gap> notavailable := [];;
gap> for i in [1 .. 4000] do
>   if SMALL_AVAILABLE(i) = fail then
>     Add(notavailable, i);
>   fi;
> od;
gap> notavailable;
[ 1024, 2016, 2024, 2025, 2040, 2048, 2052, 2058, 2064, 2072, 2079, 2080, 
  2088, 2106, 2112, 2120, 2128, 2136, 2160, 2184, 2200, 2208, 2214, 2232, 
  2240, 2250, 2256, 2268, 2280, 2288, 2295, 2296, 2304, 2312, 2320, 2322, 
  2328, 2352, 2360, 2376, 2392, 2400, 2408, 2424, 2430, 2440, 2448, 2457, 
  2464, 2472, 2480, 2484, 2496, 2500, 2520, 2538, 2544, 2552, 2560, 2565, 
  2568, 2576, 2584, 2592, 2600, 2616, 2625, 2632, 2640, 2646, 2662, 2664, 
  2680, 2688, 2700, 2704, 2712, 2720, 2728, 2736, 2744, 2750, 2754, 2760, 
  2784, 2800, 2808, 2832, 2835, 2840, 2856, 2862, 2880, 2888, 2904, 2912, 
  2916, 2920, 2928, 2952, 2960, 2968, 2970, 2976, 2992, 3000, 3016, 3024, 
  3040, 3048, 3072, 3078, 3080, 3087, 3096, 3105, 3120, 3128, 3132, 3136, 
  3144, 3160, 3168, 3186, 3192, 3200, 3213, 3216, 3224, 3240, 3248, 3250, 
  3256, 3264, 3267, 3280, 3288, 3294, 3304, 3312, 3320, 3336, 3344, 3348, 
  3360, 3375, 3384, 3400, 3402, 3408, 3416, 3430, 3432, 3440, 3456, 3472, 
  3480, 3496, 3500, 3504, 3510, 3520, 3528, 3536, 3552, 3560, 3564, 3576, 
  3584, 3591, 3600, 3608, 3618, 3624, 3640, 3648, 3672, 3680, 3696, 3720, 
  3726, 3744, 3750, 3752, 3760, 3768, 3780, 3784, 3792, 3800, 3808, 3816, 
  3834, 3840, 3848, 3861, 3864, 3872, 3880, 3888, 3912, 3915, 3920, 3936, 
  3942, 3944, 3952, 3960, 3969, 3976, 3984, 3993, 3996, 4000 ]
gap> SmallGroupsAvailable(0);
Error, <size> must be a positive integer
gap> SmallGroupsAvailable(-10);
Error, <size> must be a positive integer
gap> notavailable2 := Filtered([1..4000], x -> not SmallGroupsAvailable(x));;
gap> notavailable = notavailable2;
true
gap> Filtered([1..4000], i -> NumberSmallGroupsAvailable(i) <> SmallGroupsAvailable(i));
[ 1024 ]

################################################################################
# Testing some of the data lists
################################################################################
gap> Length(SMALL_GROUP_FUNCS) >= 26;
true
gap> Number(SMALL_GROUP_FUNCS) >= 24;
true
gap> Filtered([1 .. 26], i -> not IsBound(SMALL_GROUP_FUNCS[i]));
[ 15, 16 ]
gap> Length(CODE_SMALL_GROUP_FUNCS) >= 10;
true
gap> Number(CODE_SMALL_GROUP_FUNCS) >= 3;
true
gap> Filtered([1 .. 26], i -> IsBound(CODE_SMALL_GROUP_FUNCS[i]));
[ 8, 9, 10 ]
gap> Length(NUMBER_SMALL_GROUPS_FUNCS) >= 26;
true
gap> Number(NUMBER_SMALL_GROUPS_FUNCS) >= 12;
true
gap> Filtered([1 .. 26], i -> not IsBound(NUMBER_SMALL_GROUPS_FUNCS[i]));
[ 1, 2, 4, 10, 12, 13, 14, 15, 16, 18, 19, 20, 22, 23 ]
gap> Length(SELECT_SMALL_GROUPS_FUNCS) >= 26;
true
gap> Number(SELECT_SMALL_GROUPS_FUNCS) >= 21;
true
gap> Filtered([1 .. 26], i -> not IsBound(SELECT_SMALL_GROUPS_FUNCS[i]));
[ 13, 15, 16, 22, 23 ]

################################################################################
# SmallGroup GlobalFunction
################################################################################
gap> SmallGroup();
Error, usage: SmallGroup( order, number )
gap> SmallGroup(fail);
Error, usage: SmallGroup( order, number )
gap> SmallGroup([]);
Error, usage: SmallGroup( order, number )
gap> SmallGroup([fail]);
Error, usage: SmallGroup( order, number )
gap> SmallGroup([fail, fail]);
Error, usage: SmallGroup( order, number )
gap> SmallGroup(fail, fail);
Error, usage: SmallGroup( order, number )
gap> SmallGroup(1, fail);
Error, usage: SmallGroup( order, number )
gap> SmallGroup(fail, fail, fail);
Error, usage: SmallGroup( order, number )
gap> SmallGroup(1024, 1);
Error, the library of groups of size 1024 is not available
gap> G := SmallGroup(4, 2);
<pc group of size 4 with 2 generators>
gap> HasIsPGroup(G) and HasIdGroup(G);
true
gap> IsPGroup(G);
true
gap> IdGroup(G);
[ 4, 2 ]

################################################################################
# NumberSmallGroups GlobalFunction
################################################################################
gap> NumberSmallGroups(fail);
Error, usage: NumberSmallGroups( order )
gap> NumberSmallGroups(0);
Error, usage: NumberSmallGroups( order )
gap> NumberSmallGroups(19);
1
gap> NumberSmallGroups(1024);
49487367289
gap> NumberSmallGroups(3996);
Error, the library of groups of size 3996 is not available
gap> NumberSmallGroups(60);
13

################################################################################
# SelectSmallGroups GlobalFunction (called by AllSmallGroups or OneSmallGroup)
################################################################################
gap> OneSmallGroup();
Error, Variable: 'vals' must have an assigned value
gap> OneSmallGroup(Size);
Error, Variable: 'vals' must have an assigned value
gap> OneSmallGroup(0);
Error, usage: AllSmallGroups / OneSmallGroup(
             Size, [ sizes ],
             function1, [ values1 ],
             function2, [ values2 ], ... )
gap> OneSmallGroup(-10);
Error, usage: AllSmallGroups / OneSmallGroup(
             Size, [ sizes ],
             function1, [ values1 ],
             function2, [ values2 ], ... )
gap> OneSmallGroup(IsAbelian);
Error, usage: AllSmallGroups / OneSmallGroup(
             Size, [ sizes ],
             function1, [ values1 ],
             function2, [ values2 ], ... )
gap> OneSmallGroup(IsAbelian, true);
Error, usage: AllSmallGroups / OneSmallGroup(
             Size, [ sizes ],
             function1, [ values1 ],
             function2, [ values2 ], ... )
gap> OneSmallGroup(128);
<pc group of size 128 with 7 generators>
gap> G := OneSmallGroup(Size, 3);;
gap> Size(G) = 3 and Length(GeneratorsOfGroup(G)) = 1;
true
gap> OneSmallGroup(Size, [4, 5]);
<pc group of size 4 with 2 generators>
gap> G := OneSmallGroup(2, 3);;
gap> Size(G) = 2 and Length(GeneratorsOfGroup(G)) = 1;
true
gap> OneSmallGroup(2, Size);
fail
gap> StructureDescription(OneSmallGroup(4, [1]));
"C4"
gap> StructureDescription(OneSmallGroup(4, [2]));
"C2 x C2"
gap> List(AllSmallGroups(4, [1, 2]), StructureDescription);
[ "C4", "C2 x C2" ]
gap> OneSmallGroup(1024);
Error, AllSmallGroups / OneSmallGroup: groups of order 1024 not available
gap> G := OneSmallGroup(Size, 8, IsAbelian, true, IsCyclic, [false, true]);;
gap> StructureDescription(G);
"C8"
gap> G := OneSmallGroup(Size, 8, IsAbelian, IsCyclic, false);;
gap> StructureDescription(G);
"C4 x C2"
gap> G := OneSmallGroup(Size, 8, IsAbelian, IsCyclic, [false, false]);;
gap> StructureDescription(G);
"C4 x C2"
gap> G := OneSmallGroup(Size, 12, Size, [12]);;
gap> StructureDescription(G);
"C3 : C4"
gap> G := OneSmallGroup(Size, 12, IdGroup, [[12]], [1]);
fail
gap> G := OneSmallGroup(Size, 12, IdGroup, [12, 1]);
fail
gap> G := OneSmallGroup(Size, 12, IdGroup, [[12, 1]]);;
gap> StructureDescription(G);
"C3 : C4"
gap> G := AllSmallGroups(Size, 12, Size, 12, [1]);
[  ]
gap> IdsOfAllSmallGroups(4);
[ [ 4, 1 ], [ 4, 2 ] ]

################################################################################
# ID_AVAILABLE
################################################################################
gap> notavailable := [];;
gap> for i in [1 .. 5000] do
>   if ID_AVAILABLE(i) = fail then
>     Add(notavailable, i);
>   fi;
> od;
gap> notavailable;
[ 512, 1024, 1536, 2016, 2024, 2025, 2040, 2048, 2052, 2058, 2064, 2072, 
  2079, 2080, 2088, 2106, 2112, 2120, 2128, 2136, 2160, 2184, 2187, 2200, 
  2208, 2214, 2232, 2240, 2250, 2256, 2268, 2280, 2288, 2295, 2296, 2304, 
  2312, 2320, 2322, 2328, 2352, 2360, 2376, 2392, 2400, 2408, 2424, 2430, 
  2440, 2448, 2457, 2464, 2472, 2480, 2484, 2496, 2500, 2520, 2538, 2544, 
  2552, 2560, 2565, 2568, 2576, 2584, 2592, 2600, 2616, 2625, 2632, 2640, 
  2646, 2662, 2664, 2680, 2688, 2700, 2704, 2712, 2720, 2728, 2736, 2744, 
  2750, 2754, 2760, 2784, 2800, 2808, 2832, 2835, 2840, 2856, 2862, 2880, 
  2888, 2904, 2912, 2916, 2920, 2928, 2952, 2960, 2968, 2970, 2976, 2992, 
  3000, 3016, 3024, 3040, 3048, 3072, 3078, 3080, 3087, 3096, 3105, 3120, 
  3128, 3132, 3136, 3144, 3160, 3168, 3186, 3192, 3200, 3213, 3216, 3224, 
  3240, 3248, 3250, 3256, 3264, 3267, 3280, 3288, 3294, 3304, 3312, 3320, 
  3336, 3344, 3348, 3360, 3375, 3384, 3400, 3402, 3408, 3416, 3430, 3432, 
  3440, 3456, 3472, 3480, 3496, 3500, 3504, 3510, 3520, 3528, 3536, 3552, 
  3560, 3564, 3576, 3584, 3591, 3600, 3608, 3618, 3624, 3640, 3648, 3672, 
  3680, 3696, 3720, 3726, 3744, 3750, 3752, 3760, 3768, 3780, 3784, 3792, 
  3800, 3808, 3816, 3834, 3840, 3848, 3861, 3864, 3872, 3880, 3888, 3912, 
  3915, 3920, 3936, 3942, 3944, 3952, 3960, 3969, 3976, 3984, 3993, 3996, 
  4000, 4008, 4032, 4040, 4048, 4050, 4056, 4080, 4088, 4096, 4104, 4116, 
  4120, 4125, 4128, 4136, 4144, 4152, 4158, 4160, 4176, 4185, 4200, 4212, 
  4216, 4224, 4232, 4240, 4248, 4250, 4256, 4264, 4266, 4272, 4280, 4296, 
  4312, 4320, 4344, 4347, 4360, 4368, 4374, 4392, 4394, 4400, 4408, 4416, 
  4424, 4428, 4440, 4455, 4464, 4472, 4480, 4482, 4488, 4500, 4512, 4520, 
  4536, 4560, 4563, 4576, 4584, 4590, 4592, 4600, 4608, 4624, 4632, 4640, 
  4644, 4648, 4656, 4664, 4680, 4698, 4704, 4712, 4720, 4725, 4728, 4750, 
  4752, 4760, 4776, 4784, 4800, 4806, 4816, 4824, 4840, 4848, 4860, 4872, 
  4875, 4880, 4888, 4896, 4914, 4920, 4928, 4944, 4960, 4968, 4984, 4992, 
  4995, 5000 ]
gap> notavailable2 := Filtered([1..5000], x -> not IdGroupsAvailable(x));;
gap> notavailable = notavailable2;
true

################################################################################
# IdGroup
################################################################################
gap> IdGroup(SymmetricGroup(1));
[ 1, 1 ]
gap> IdGroup(CyclicGroup(1024));
Error, the group identification for groups of size 1024 is not available
gap> G := GL(2, 2);;
gap> IdGroup(G);
[ 6, 1 ]
gap> StructureDescription(G);
"S3"
gap> IdGroup(SL(3, 2));
[ 168, 42 ]
gap> StructureDescription(SmallGroup(168, 42));
"PSL(3,2)"
gap> IdGroup(CyclicGroup(IsPermGroup, 1001));
[ 1001, 1 ]
gap> StructureDescription(SmallGroup(1001, 1));
"C1001"
gap> G := CyclicGroup(IsPcGroup, 12000);
<pc group of size 12000 with 9 generators>
gap> H := Subgroup(G, [G.1 ^ 6000]);;
gap> IdGroup(H);
[ 2, 1 ]

################################################################################
# ReadSmallLib
################################################################################
gap> SMALL_GROUP_LIB[1536] := rec(npnil := List([1 .. 12], x -> []));;
gap> ReadSmallLib("sml", 8, 1536, [1]);
gap> ReadSmallLib("sml", 8, 1536, [1, 2]);
gap> ReadSmallLib("sml", 8, 1536, [1, 27]);
gap> ReadSmallLib("sml", 8, 1536, [2]);

################################################################################
# Gap3CatalogueIdGroup & Gap3CatalogueGroup
################################################################################
gap> Gap3CatalogueIdGroup(SymmetricGroup(5));
Error, Gap3CatalogueIdGroup: the group catalogue of gap-3.0 was
limited to size 100
gap> Gap3CatalogueGroup(101, 1);
Error, Gap3CatalogueIdGroup: the group catalogue of gap-3.0 was
limited to size 100
gap> GAP3_CATALOGUE_ID_GROUP := fail;;
gap> Gap3CatalogueIdGroup(SymmetricGroup(2));
[ 2, 1 ]
gap> GAP3_CATALOGUE_ID_GROUP := fail;;
gap> StructureDescription(Gap3CatalogueGroup(2, 1));
"C2"
gap> Gap3CatalogueIdGroup(CyclicGroup(4));
[ 4, 2 ]
gap> IsCyclic(Gap3CatalogueGroup(4, 2));
true
gap> Gap3CatalogueGroup(4, 3);
Error, Gap3CatalogueGroup: there are just 2 groups of size 4

################################################################################
# UnloadSmallGroupsData
################################################################################
gap> UnloadSmallGroupsData();
gap> SMALL_GROUP_LIB;
[  ]
gap> PROPERTIES_SMALL_GROUPS;
[  ]
gap> GAP3_CATALOGUE_ID_GROUP;
fail
gap> ID_GROUP_TREE;
rec( fp := [ 1 .. 50000 ], next := [  ] )

################################################################################
# FrattinifactorSize and FrattinifactorId
################################################################################
gap> FrattinifactorSize(CyclicGroup(IsPermGroup, 2));
2
gap> FrattinifactorId(CyclicGroup(IsPermGroup, 2));
[ 2, 1 ]
gap> C2 := CyclicGroup(2);;
gap> H := DirectProduct(C2, C2, C2, C2, C2, C2, C2, C2, C2);
<pc group of size 512 with 9 generators>
gap> StructureDescription(H);
"C2 x C2 x C2 x C2 x C2 x C2 x C2 x C2 x C2"
gap> FrattinifactorSize(H);
512
gap> FrattinifactorId(H);
Error, FrattinifactorId: IdGroup for groups of size 512 not available

#
gap> STOP_TEST("small.tst");
