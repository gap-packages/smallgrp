#############################################################################
##
#W  verify-indices.g         GAP small groups library
##
##  Checks the tables a few orders store -- SMALL_GROUPS_512_TYPES in
##  small7/smlgp7.g, SMALL_GROUPS_1152_NOT_SUPERSOLVABLE in small6/smlgp6.g,
##  SMALLGRP_P6_INDEX in small9/smlgp9.g and SMALLGRP_P7_INDEX in
##  small11/smlgp11.g -- against the groups themselves.
##
##  Not run by tst/testall.g: it builds some 200000 groups. Run it after
##  touching one of those tables:
##
##      gap tst/verify-indices.g
##

LoadPackage( "smallgrp" );

VERIFY_INDICES_FAILURES := 0;

#############################################################################
##
#F  VERIFY_INDICES_REPORT( ok, description )
##
VERIFY_INDICES_REPORT := function( ok, description )
    if ok then
        Print( "ok    ", description, "\n" );
    else
        VERIFY_INDICES_FAILURES := VERIFY_INDICES_FAILURES + 1;
        Print( "FAIL  ", description, "\n" );
    fi;
end;

#############################################################################
##
#F  VERIFY_INDICES_ORDER( size, criteria )
##
##  checks that selecting by each of the <criteria>, a list of pairs
##  [ <function>, <name> ], returns the groups whose value it is
##
VERIFY_INDICES_ORDER := function( size, criteria )
    local nr, groups, crit, values, value, expected, got;

    nr := NrSmallGroups( size );
    groups := List( [ 1 .. nr ], i -> SmallGroup( size, i ) );

    for crit in criteria do
        values := List( groups, crit[ 1 ] );
        for value in Set( values ) do
            expected := Filtered( [ 1 .. nr ], i -> values[ i ] = value );
            got := List( IdsOfAllSmallGroups( size, crit[ 1 ], value ),
                         x -> x[ 2 ] );
            VERIFY_INDICES_REPORT( got = expected,
                Concatenation( String( size ), ": ", crit[ 2 ], " = ",
                               String( value ), ", ",
                               String( Length( expected ) ), " groups" ) );
        od;
    od;
end;

#############################################################################
##
#F  VERIFY_INDICES_512( )
##
##  10494213 groups are too many to build, so check only the range boundaries
##  of SMALL_GROUPS_512_TYPES, that they cover everything and that
##  neighbouring ranges differ. The abelian list needs no such compromise:
##  there is one abelian group per partition of 9.
##
VERIFY_INDICES_512 := function( )
    local prev, t, i, g, ids;

    prev := fail;
    for t in SMALL_GROUPS_512_TYPES do
        for i in [ t[ 1 ], t[ 2 ] ] do
            g := SmallGroup( 512, i );
            VERIFY_INDICES_REPORT(
                [ RankPGroup( g ), PClassPGroup( g ) ] = t{ [ 3, 4 ] },
                Concatenation( "512: group ", String( i ), " has rank ",
                               String( t[ 3 ] ), " and p-class ",
                               String( t[ 4 ] ) ) );
        od;
        if prev <> fail then
            VERIFY_INDICES_REPORT( prev[ 2 ] + 1 = t[ 1 ],
                Concatenation( "512: nothing is left out in front of ",
                               String( t[ 1 ] ) ) );
            VERIFY_INDICES_REPORT( prev{ [ 3, 4 ] } <> t{ [ 3, 4 ] },
                Concatenation( "512: the range starting at ",
                               String( t[ 1 ] ),
                               " differs from its predecessor" ) );
        fi;
        prev := t;
    od;
    VERIFY_INDICES_REPORT( SMALL_GROUPS_512_TYPES[ 1 ][ 1 ] = 1 and
                           prev[ 2 ] = NrSmallGroups( 512 ),
                           "512: the ranges cover every group" );

    ids := IdsOfAllSmallGroups( 512, IsAbelian, true );
    VERIFY_INDICES_REPORT( Length( ids ) = NrPartitions( 9 ),
                           Concatenation( "512: there are ",
                               String( NrPartitions( 9 ) ),
                               " abelian groups, one per partition of 9" ) );
    VERIFY_INDICES_REPORT( ForAll( ids, x -> IsAbelian( SmallGroup( x ) ) ),
                           "512: each of them is abelian" );
end;

VERIFY_INDICES_512( );

VERIFY_INDICES_ORDER( 1152,
        [ [ IsSupersolvableGroup, "IsSupersolvableGroup" ] ] );

for size in [ 15625, 117649, 2187, 78125 ] do
    VERIFY_INDICES_ORDER( size, [ [ RankPGroup, "RankPGroup" ],
                                  [ PClassPGroup, "PClassPGroup" ],
                                  [ IsAbelian, "IsAbelian" ] ] );
od;

Print( "\n", VERIFY_INDICES_FAILURES, " failures\n" );
