gap> START_TEST("addlayer.tst");
gap> saved := rec( layers := ShallowCopy( SMALL_GROUPS_LAYER_LIST ),
>                  avail  := ShallowCopy( SMALL_AVAILABLE_FUNCS ) );;

#
# The layers below are stand-ins. None of the orders they claim -- 2016,
# 2025, 2040 -- has a layer in this library, and none of them hands out all
# the groups of its orders; they hand out enough to watch the plumbing.
#
gap> SmallGroupsAddLayer( rec(
>        name := "two of them",
>        available := function( order )
>            if order <> 2016 then
>                return fail;
>            fi;
>            return rec( number := 2 );
>        end,
>        group := function( order, i, inforec )
>            if i = 1 then
>                return CyclicGroup( order );
>            fi;
>            return DihedralGroup( order );
>        end,
>        id := function( G, inforec )
>            if IsAbelian( G ) then
>                return 1;
>            fi;
>            return 2;
>        end,
>        information := function( order, inforec, num )
>            Print( "\n  Namely the cyclic and the dihedral one.\n" );
>        end ) );
gap> SmallGroupsAvailable( 2016 );
true
gap> IdGroupsAvailable( 2016 );
true
gap> NumberSmallGroups( 2016 );
2
gap> List( [ 1, 2 ], i -> IdGroup( SmallGroup( 2016, i ) ) );
[ [ 2016, 1 ], [ 2016, 2 ] ]
gap> IdsOfAllSmallGroups( 2016, IsAbelian, true );
[ [ 2016, 1 ] ]
gap> NumberSmallGroups( 2016, IsAbelian, false );
1
gap> SmallGroupsInformation( 2016 );

  There are 2 groups of order 2016.

  Namely the cyclic and the dihedral one.

  This size belongs to the layer "two of them". 
  IdSmallGroup is available for this size. 
 

#
# The layer is registered by name, behind the layers of this library.
#
gap> Position( SMALL_GROUPS_LAYER_LIST, SMALL_GROUPS_LAYERS.("two of them") );
2
gap> SmallGroupsAddLayer( rec( name := "two of them",
>                              available := ReturnFail,
>                              group := ReturnFail ) );
Error, a layer named "two of them" is already registered
gap> SmallGroupsAddLayer( rec( name := "typo", available := ReturnFail,
>                              group := ReturnFail, ids := ReturnFail ) );
Error, unknown component <desc>.ids
gap> SmallGroupsAddLayer( rec( name := "sparse", available := ReturnFail ) );
Error, <desc>.group must be given
gap> SmallGroupsAddLayer( 42 );
Error, <desc> must be a record
gap> SmallGroupsAddLayer( rec( name := 42, available := ReturnFail,
>                              group := ReturnFail ) );
Error, <desc>.name must be a non-empty string
gap> SmallGroupsAddLayer( rec( name := "", available := ReturnFail,
>                              group := ReturnFail ) );
Error, <desc>.name must be a non-empty string
gap> SmallGroupsAddLayer( rec( name := "odd", available := 42,
>                              group := ReturnFail ) );
Error, <desc>.available must be a function
gap> SmallGroupsAddLayer( rec( name := "odd", available := ReturnFail,
>                              group := ReturnFail, before := [ 42 ] ) );
Error, <desc>.before must be a list of layer names

#
# Layers all claiming order 2025, to watch the order they are consulted in.
# What they hand out is beside the point; only which of them answers is.
#
gap> claim := function( name, number, wishes )
>        local desc;
>        desc := ShallowCopy( wishes );
>        desc.name := name;
>        desc.available := function( order )
>            if order <> 2025 then
>                return fail;
>            fi;
>            return rec( number := number );
>        end;
>        desc.group := { order, i, inforec } -> CyclicGroup( order );
>        SmallGroupsAddLayer( desc );
>    end;;
gap> claim( "alpha", 3, rec() );
gap> NumberSmallGroups( 2025 );
3
gap> claim( "beta", 4, rec( before := [ "alpha" ] ) );
gap> NumberSmallGroups( 2025 );
4
gap> claim( "gamma", 5, rec( after := [ "beta" ], before := [ "alpha" ] ) );
gap> NumberSmallGroups( 2025 );
4
gap> List( SMALL_GROUPS_LAYER_LIST, l -> l.name );
[ "SmallGrp", "two of them", "beta", "gamma", "alpha" ]

# a wish about a layer that is not registered is ignored
gap> claim( "delta", 6, rec( after := [ "not loaded" ] ) );
gap> NumberSmallGroups( 2025 );
4

# wishes that cannot all be met are refused, and nothing is registered
gap> claim( "loop", 7, rec( before := [ "alpha" ], after := [ "alpha" ] ) );
Error, SmallGroupsAddLayer: the layers alpha, loop ask for an order that canno\
t be met
gap> IsBound( SMALL_GROUPS_LAYERS.loop );
false
gap> NumberSmallGroups( 2025 );
4

# without an 'id' function the identification stays unavailable
gap> IdGroupsAvailable( 2025 );
false

#
# 'number' where 'available' does not report the count, and 'count' where the
# layer knows better than to construct the groups.
#
gap> SmallGroupsAddLayer( rec(
>        name := "counted",
>        available := function( order )
>            if order = 2040 then
>                return rec();
>            fi;
>            return fail;
>        end,
>        group := { order, i, inforec } -> CyclicGroup( order ),
>        number := { order, inforec } -> 7,
>        count := { order, funcs, vals, inforec, idList } -> 42 ) );
gap> NumberSmallGroups( 2040 );
7
gap> NumberSmallGroups( 2040, IsAbelian, true );
42

# a layer has to report the number one way or the other
gap> SmallGroupsAddLayer( rec(
>        name := "countless",
>        available := function( order )
>            if order = 2064 then
>                return rec();
>            fi;
>            return fail;
>        end,
>        group := ReturnFail ) );
gap> NumberSmallGroups( 2064 );
Error, layer countless reports no number of groups of order 2064

#
# A layer that selects for itself: no generic count is installed over it, so
# the counting goes through its own selection.
#
gap> SmallGroupsAddLayer( rec(
>        name := "selective",
>        available := function( order )
>            if order = 2052 then
>                return rec( number := 2 );
>            fi;
>            return fail;
>        end,
>        group := { order, i, inforec } -> CyclicGroup( order ),
>        select := function( order, funcs, vals, inforec, all, id, idList )
>            if not all then
>                return CyclicGroup( order );
>            elif id then
>                return [ [ order, 1 ], [ order, 2 ] ];
>            fi;
>            return [ CyclicGroup( order ), CyclicGroup( order ) ];
>        end ) );
gap> IsBound( SMALL_GROUPS_LAYERS.selective.count );
false
gap> IdsOfAllSmallGroups( 2052, IsAbelian, true );
[ [ 2052, 1 ], [ 2052, 2 ] ]
gap> NumberSmallGroups( 2052, IsAbelian, true );
2
gap> IsCyclic( OneSmallGroup( 2052, IsAbelian, true ) );
true

#
# 'available' has to return 'fail' or a record
#
gap> SmallGroupsAddLayer( rec(
>        name := "confused",
>        available := function( order )
>            if order = 2058 then
>                return 42;
>            fi;
>            return fail;
>        end,
>        group := ReturnFail ) );
gap> SmallGroupsAvailable( 2058 );
Error, the 'available' function of layer confused must return 'fail' or a reco\
rd

#
# A layer added the old way, by filling the arrays directly, is picked up by
# the layer "SmallGrp": it needs no slot of its own here, and registering a
# further layer leaves it where it is.
#
gap> SMALL_AVAILABLE_FUNCS[ Length( SMALL_AVAILABLE_FUNCS ) + 1 ] :=
>    function( order )
>        if order <> 2079 then
>            return fail;
>        fi;
>        return rec( lib := 12, func := 1000, number := 9 );
>    end;;
gap> NumberSmallGroups( 2079 );
9
gap> SMALL_AVAILABLE( 2079 ).layer.name;
"SmallGrp"
gap> claim( "epsilon", 8, rec() );
gap> NumberSmallGroups( 2079 );
9
gap> NumberSmallGroups( 2025 );
4

# a wish is met wherever the layers sit
gap> claim( "zeta", 9, rec( before := [ "beta" ] ) );
gap> List( SMALL_GROUPS_LAYER_LIST, l -> l.name );
[ "SmallGrp", "two of them", "delta", "counted", "countless", "selective", 
  "confused", "epsilon", "zeta", "beta", "gamma", "alpha" ]
gap> NumberSmallGroups( 2079 );
9

#
# a layer may put itself in front of this library, and then answers for an
# order this library covers
#
gap> NumberSmallGroups( 96 );
231
gap> SmallGroupsAddLayer( rec(
>        name := "in front",
>        before := [ "SmallGrp" ],
>        available := function( order )
>            if order <> 96 then
>                return fail;
>            fi;
>            return rec( number := 1 );
>        end,
>        group := { order, i, inforec } -> CyclicGroup( order ) ) );
gap> Position( SMALL_GROUPS_LAYER_LIST, SMALL_GROUPS_LAYERS.("in front") )
>    < Position( SMALL_GROUPS_LAYER_LIST, SMALL_GROUPS_LAYERS.SmallGrp );
true
gap> NumberSmallGroups( 96 );
1

#
# put the library back as it was, so the stand-ins do not follow the rest of
# the tests around
#
gap> SMALL_GROUPS_LAYERS := rec( SmallGrp := saved.layers[1] );;
gap> SMALL_GROUPS_LAYER_LIST := saved.layers;;
gap> SMALL_AVAILABLE_FUNCS := saved.avail;;
gap> List( [ 2016, 2025, 2040, 2052, 2064 ], SmallGroupsAvailable );
[ false, false, false, false, false ]
gap> NumberSmallGroups( 96 );
231

#
gap> STOP_TEST( "addlayer.tst", 1);
