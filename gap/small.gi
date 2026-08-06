#############################################################################
##
#W  small.gi                 GAP group library             Hans Ulrich Besche
##                                               Bettina Eick, Eamonn O'Brien
##
##  This file contains the basic installations for the library of small
##  groups and the group identification routines. 
##

#############################################################################
##
#F  SMALL_AVAILABLE_FUNCS
##
##  On every level of the small groups library one function is written into
##  this list. It will detect those sizes, which are contained in this
##  library level.
SMALL_AVAILABLE_FUNCS := [ ];

#############################################################################
##
#F  SMALL_AVAILABLE( size )
##
##  returns fail if the library of groups of <size> is not installed.
##  Otherwise a record with some information about the construction of the
##  groups of <size> is returned.
InstallGlobalFunction( SMALL_AVAILABLE, function( size )
    local l, r;

    if not IsPosInt( size ) then
      Error( "<size> must be a positive integer");
    fi;

    for l in [ 1 .. Length( SMALL_AVAILABLE_FUNCS ) ] do
        if IsBound( SMALL_AVAILABLE_FUNCS[ l ] ) then
            r := SMALL_AVAILABLE_FUNCS[ l ]( size );
            if r <> fail then
                return r;
            fi;
        fi;
    od;
    return fail;
end );

InstallGlobalFunction( SmallGroupsAvailable,
function(order)
    return SMALL_AVAILABLE(order) <> fail;
end);

InstallGlobalFunction( NumberSmallGroupsAvailable,
function(order)
    if order = 1024 then
        return true;
    else
        return SmallGroupsAvailable(order);
    fi;
end);

#############################################################################
##
#F  SMALL_GROUP_FUNCS
##
##  This list will contain all functions to construct/read the groups from
##  the library.
SMALL_GROUP_FUNCS := [ ];

#############################################################################
##
#F  CODE_SMALL_GROUP_FUNCS
##
##  This list will contain those functions used to read the code of the
##  groups of some sizes from the data files.
CODE_SMALL_GROUP_FUNCS := [ ];

#############################################################################
##
#F  NUMBER_SMALL_GROUPS_FUNCS
##
NUMBER_SMALL_GROUPS_FUNCS := [ ];

#############################################################################
##
#F  SELECT_SMALL_GROUPS_FUNCS
##
SELECT_SMALL_GROUPS_FUNCS := [ ];

#############################################################################
##
#F  SMALL_IDS_EXPAND( <ids> )
#F  SMALL_IDS_UNION( <ids1>, <ids2> )
#F  SMALL_IDS_INTERSECTION( <ids1>, <ids2> )
#F  SMALL_IDS_DIFFERENCE( <ids1>, <ids2> )
#F  SMALL_IDS_MEMBER( <ids>, <i> )
##
##  A set of group numbers is a list of its maximal runs, each a range or a
##  bare integer: [ 1, [ 5 .. 8 ], 12 ] is [ 1, 5, 6, 7, 8, 12 ]. Some orders
##  have billions of groups, so the operations below never expand a run.
##
##  'SMALL_IDS_FROM_LIBRARY' converts the form the data files use, where a
##  negative entry -n ends a run starting at its predecessor.
SMALL_IDS_FIRST := function( run )
    if IsInt( run ) then
        return run;
    fi;
    return run[ 1 ];
end;

SMALL_IDS_LAST := function( run )
    if IsInt( run ) then
        return run;
    fi;
    return run[ Length( run ) ];
end;

SMALL_IDS_FROM_LIBRARY := function( l )
    local res, i;

    res := [ ];
    i := 1;
    while i <= Length( l ) do
        if i < Length( l ) and l[ i + 1 ] < 0 then
            Add( res, [ l[ i ] .. -l[ i + 1 ] ] );
            i := i + 2;
        else
            Add( res, l[ i ] );
            i := i + 1;
        fi;
    od;
    return res;
end;

SMALL_IDS_FROM_LIST := function( l )
    local res, s, e, i;

    res := [ ];
    s := fail;
    for i in l do
        if s = fail then
            s := i;
            e := i;
        elif i = e + 1 then
            e := i;
        else
            Add( res, [ s .. e ] );
            s := i;
            e := i;
        fi;
    od;
    if s <> fail then
        Add( res, [ s .. e ] );
    fi;
    return res;
end;

SMALL_IDS_EXPAND := function( ids )
    if Length( ids ) = 0 then
        return [ ];
    elif Length( ids ) = 1 then
        if IsInt( ids[ 1 ] ) then
            return [ ids[ 1 ] ];
        fi;
        return ids[ 1 ];
    fi;
    return Concatenation( List( ids,
                                run -> [ SMALL_IDS_FIRST( run )
                                         .. SMALL_IDS_LAST( run ) ] ) );
end;

SMALL_IDS_MEMBER := function( ids, i )
    local run;

    for run in ids do
        if i <= SMALL_IDS_LAST( run ) then
            return i >= SMALL_IDS_FIRST( run );
        fi;
    od;
    return false;
end;

SMALL_IDS_UNION := function( l1, l2 )
    local all, res, run, s, e;

    # a plain sort would put the integers in front of the ranges
    all := Concatenation( l1, l2 );
    SortBy( all, SMALL_IDS_FIRST );

    res := [ ];
    s := fail;
    for run in all do
        if s = fail then
            s := SMALL_IDS_FIRST( run );
            e := SMALL_IDS_LAST( run );
        elif SMALL_IDS_FIRST( run ) <= e + 1 then
            e := Maximum( e, SMALL_IDS_LAST( run ) );
        else
            Add( res, [ s .. e ] );
            s := SMALL_IDS_FIRST( run );
            e := SMALL_IDS_LAST( run );
        fi;
    od;
    if s <> fail then
        Add( res, [ s .. e ] );
    fi;
    return res;
end;

SMALL_IDS_INTERSECTION := function( l1, l2 )
    local res, p1, p2, s, e;

    res := [ ];
    p1 := 1;
    p2 := 1;
    while p1 <= Length( l1 ) and p2 <= Length( l2 ) do
        s := Maximum( SMALL_IDS_FIRST( l1[ p1 ] ), SMALL_IDS_FIRST( l2[p2] ) );
        e := Minimum( SMALL_IDS_LAST( l1[ p1 ] ), SMALL_IDS_LAST( l2[ p2 ] ) );
        if s <= e then
            Add( res, [ s .. e ] );
        fi;
        if SMALL_IDS_LAST( l1[ p1 ] ) < SMALL_IDS_LAST( l2[ p2 ] ) then
            p1 := p1 + 1;
        else
            p2 := p2 + 1;
        fi;
    od;
    return res;
end;

SMALL_IDS_DIFFERENCE := function( l1, l2 )
    local res, run, p, s, e;

    res := [ ];
    p := 1;
    for run in l1 do
        s := SMALL_IDS_FIRST( run );
        e := SMALL_IDS_LAST( run );

        # skip the runs of l2 lying entirely in front of this one
        while p <= Length( l2 ) and SMALL_IDS_LAST( l2[ p ] ) < s do
            p := p + 1;
        od;

        # cut away the runs of l2 meeting this one
        while p <= Length( l2 ) and SMALL_IDS_FIRST( l2[ p ] ) <= e
                                and SMALL_IDS_LAST( l2[ p ] ) <= e do
            if s < SMALL_IDS_FIRST( l2[ p ] ) then
                Add( res, [ s .. SMALL_IDS_FIRST( l2[ p ] ) - 1 ] );
            fi;
            s := SMALL_IDS_LAST( l2[ p ] ) + 1;
            p := p + 1;
        od;
        if p <= Length( l2 ) and SMALL_IDS_FIRST( l2[ p ] ) <= e then
            # this run of l2 reaches beyond the current one, so it may meet
            # the next one as well and must not be skipped
            if s < SMALL_IDS_FIRST( l2[ p ] ) then
                Add( res, [ s .. SMALL_IDS_FIRST( l2[ p ] ) - 1 ] );
            fi;
        elif s <= e then
            Add( res, [ s .. e ] );
        fi;
    od;
    return res;
end;

#############################################################################
##
#V  SMALL_GROUPS_PROPERTY_SYNONYMS
##
##  a list of pairs [ <old>, <new> ] of functions computing the same value
##  for a group. The first entry of each pair is one of the deprecated GAP 3
##  names of a property; 'SMALL_GROUPS_SIMPLIFY_QUERY' replaces it by the
##  property itself, so that the rest of the code only has to know about the
##  latter.
SMALL_GROUPS_PROPERTY_SYNONYMS := [
    [ IsNilpotent,     IsNilpotentGroup ],
    [ IsSupersolvable, IsSupersolvableGroup ],
    [ IsSolvable,      IsSolvableGroup ] ];

#############################################################################
##
#V  SMALL_GROUPS_INDEXED_PROPERTIES
##
##  a list of triples [ <component>, <property>, <name> ] describing the
##  properties for which a layer may report information in advance;
##  <component> is the name of the corresponding component of the records
##  returned by the functions in 'SMALL_GROUPS_PROPERTIES_FUNCS', and <name>
##  is the name under which the property is documented.
SMALL_GROUPS_INDEXED_PROPERTIES := [
    [ "isAbelian",       IsAbelian,            "IsAbelian" ],
    [ "isNilpotent",     IsNilpotentGroup,     "IsNilpotentGroup" ],
    [ "isSupersolvable", IsSupersolvableGroup, "IsSupersolvableGroup" ],
    [ "isSolvable",      IsSolvableGroup,      "IsSolvableGroup" ] ];

#############################################################################
##
#V  SMALL_GROUPS_INDEXED_ATTRIBUTES
##
##  as 'SMALL_GROUPS_INDEXED_PROPERTIES', but for attributes which do not
##  take boolean values. The value of such a component of the records
##  returned by the functions in 'SMALL_GROUPS_PROPERTIES_FUNCS' is a list
##  of pairs [ <value>, <ids> ], where <ids> is the compressed list of the
##  numbers of those groups whose attribute value is <value>.
SMALL_GROUPS_INDEXED_ATTRIBUTES := [
    [ "rankPGroup",   RankPGroup,   "RankPGroup" ],
    [ "pClassPGroup", PClassPGroup, "PClassPGroup" ] ];

#############################################################################
##
#F  SMALL_GROUPS_SIMPLIFY_QUERY( funcs, vals )
##
##  preprocesses the selection described by <funcs> and <vals> before it is
##  handed to the selection function of a layer: the deprecated synonyms
##  listed in 'SMALL_GROUPS_PROPERTY_SYNONYMS' are replaced by the
##  properties they stand for, and a criterion which admits both 'true' and
##  'false' for a property is dropped, as every group satisfies it. The
##  result is a record with the components 'funcs' and 'vals'.
SMALL_GROUPS_SIMPLIFY_QUERY := function( funcs, vals )
    local newfuncs, newvals, i, func, val, p;

    newfuncs := [ ];
    newvals  := [ ];
    for i in [ 1 .. Length( funcs ) ] do
        func := funcs[ i ];
        val  := vals[ i ];

        p := PositionProperty( SMALL_GROUPS_PROPERTY_SYNONYMS,
                               x -> x[ 1 ] = func );
        if p <> fail then
            func := SMALL_GROUPS_PROPERTY_SYNONYMS[ p ][ 2 ];
        fi;

        if IsProperty( func ) then
            if not ForAll( val, x -> x = true or x = false ) then
                Error("SelectSmallGroups: Use Test-Funcs with true or false");
            elif true in val and false in val then
                # every group satisfies this criterion, so drop it
                val := fail;
            fi;
        fi;

        if val <> fail then
            Add( newfuncs, func );
            Add( newvals, val );
        fi;
    od;

    return rec( funcs := newfuncs, vals := newvals );
end;

#############################################################################
##
#F  SMALL_GROUPS_PROPERTIES_FUNCS
##
##  A layer installs a function here taking <size> and <inforec>, the latter
##  with 'number' bound, and returning a record. Its components are named in
##  'SMALL_GROUPS_INDEXED_PROPERTIES' and 'SMALL_GROUPS_INDEXED_ATTRIBUTES';
##  each holds the numbers of the groups with that value, as described for
##  'SMALL_IDS_EXPAND'. An unbound component means the value is not known in
##  advance.
##
##  These are the numbers used by 'SmallGroup', which for 3^7, 5^7, 7^7 and
##  11^7 differ from those the library stores under (see
##  'SMALL_GROUPS_OLD_ORDER').
SMALL_GROUPS_PROPERTIES_FUNCS := [ ];

#############################################################################
##
#V  SMALL_GROUPS_512_TYPES
##
##  the ranks and p-classes of the groups of order 512; the data is filled in
##  by the layer containing this order and is used both for the selection
##  functions and by 'SmallGroupsInformation'
SMALL_GROUPS_512_TYPES := [ ];

#############################################################################
##
#F  SMALL_GROUPS_PROPERTIES_PGROUP( size, inforec )
##
##  the properties of the groups in a layer which contains groups of prime
##  power order only: all of them are nilpotent
SMALL_GROUPS_PROPERTIES_PGROUP := function( size, inforec )
    local all;

    all := [ [ 1 .. inforec.number ] ];
    return rec( isNilpotent     := all,
                isSupersolvable := all,
                isSolvable      := all );
end;

#############################################################################
##
#F  SMALL_GROUPS_ABELIAN_IDS( size )
##
##  the numbers of the abelian groups of order <size>, as described for
##  'SMALL_IDS_EXPAND'.
SMALL_GROUPS_ABELIAN_IDS := function( size )
    return SMALL_IDS_FROM_LIST( List(
               IdsOfAllSmallGroups( size, IsAbelian, true ), x -> x[ 2 ] ) );
end;

#############################################################################
##
#F  SMALL_GROUPS_PROPERTIES_TWO_PRIMES( size, inforec )
##
##  for a layer of orders q^n * p, p occurring once, sorted by their normal
##  Sylow subgroups with the nilpotent groups first. Solvable by Burnside.
##  Supersolvable exactly with a normal Sylow p-subgroup -- cyclic of order
##  p, with a q-group quotient -- or with a normal Sylow q-subgroup and
##  q = 1 mod p, the irreducible F_q[C_p]-modules then being 1-dimensional.
##  Without a normal Sylow subgroup there is no Sylow tower.
SMALL_GROUPS_PROPERTIES_TWO_PRIMES := function( size, inforec )
    local q, k;

    if not IsBound( inforec.pos ) then
        inforec := NUMBER_SMALL_GROUPS_FUNCS[ inforec.func ]( size, inforec );
    fi;

    # the type "nil" and the integer types describe the groups with a normal
    # Sylow p-subgroup; they come first
    k := 1;
    while k < Length( inforec.types ) and IsInt( inforec.types[ k + 1 ] ) do
        k := k + 1;
    od;

    q := 2;
    if IsBound( inforec.q ) then
        q := inforec.q;
    fi;
    if q mod inforec.p = 1 and IsBound( inforec.types[ k + 1 ] )
                           and inforec.types[ k + 1 ] = "p-autos" then
        k := k + 1;
    fi;

    # the nilpotent groups are the groups of order q^n times C_p, listed in
    # the order of the former, so the abelian ones keep their places
    return rec( isAbelian       := SMALL_GROUPS_ABELIAN_IDS( q ^ inforec.n ),
                isNilpotent     := [ [ 1 .. inforec.pos[ 2 ] ] ],
                isSupersolvable := [ [ 1 .. inforec.pos[ k + 1 ] ] ],
                isSolvable      := [ [ 1 .. inforec.number ] ] );
end;

#############################################################################
##
#F  SMALL_GROUPS_PROPERTY_IDS( size, inforec, funcs, vals )
##
##  splits the selection into the part the position decides and the rest,
##  returning 'ids' for the former and 'funcs' and 'vals' for the latter.
SMALL_GROUPS_PROPERTY_IDS := function( size, inforec, funcs, vals )
    local hits, props, ids, evalfuncs, evalvals, i, p, tmp, entry;

    # find those selection criteria which possibly are known in advance; a
    # property is of no use here unless it is asked for a single value. Each
    # entry of 'hits' is 'fail' or a pair [ <component>, <isattribute> ].
    hits := [ ];
    for i in [ 1 .. Length( funcs ) ] do
        hits[ i ] := fail;
        p := PositionProperty( SMALL_GROUPS_INDEXED_PROPERTIES,
                               x -> x[ 2 ] = funcs[ i ] );
        if p <> fail then
            if vals[ i ] in [ [ true ], [ false ] ] then
                hits[ i ] := [ SMALL_GROUPS_INDEXED_PROPERTIES[p][1], false ];
            fi;
        else
            p := PositionProperty( SMALL_GROUPS_INDEXED_ATTRIBUTES,
                                   x -> x[ 2 ] = funcs[ i ] );
            if p <> fail then
                hits[ i ] := [ SMALL_GROUPS_INDEXED_ATTRIBUTES[p][1], true ];
            fi;
        fi;
    od;

    ids := [ [ 1 .. inforec.number ] ];
    if ForAll( hits, x -> x = fail ) or
       not IsBound( SMALL_GROUPS_PROPERTIES_FUNCS[ inforec.func ] ) then
        return rec( ids := ids, funcs := funcs, vals := vals );
    fi;
    props := SMALL_GROUPS_PROPERTIES_FUNCS[ inforec.func ]( size, inforec );

    evalfuncs := [ ];
    evalvals  := [ ];
    for i in [ 1 .. Length( funcs ) ] do
        if hits[ i ] = fail or not IsBound( props.( hits[ i ][ 1 ] ) ) then
            Add( evalfuncs, funcs[ i ] );
            Add( evalvals, vals[ i ] );
        elif hits[ i ][ 2 ] then
            # an attribute: collect the groups with an admissible value
            tmp := [ ];
            for entry in props.( hits[ i ][ 1 ] ) do
                if entry[ 1 ] in vals[ i ] then
                    tmp := SMALL_IDS_UNION( tmp, entry[ 2 ] );
                fi;
            od;
            ids := SMALL_IDS_INTERSECTION( ids, tmp );
        elif vals[ i ] = [ true ] then
            ids := SMALL_IDS_INTERSECTION( ids, props.( hits[ i ][ 1 ] ) );
        else
            ids := SMALL_IDS_DIFFERENCE( ids, props.( hits[ i ][ 1 ] ) );
        fi;
    od;

    return rec( ids := ids, funcs := evalfuncs, vals := evalvals );
end;

#############################################################################
##
#F  SMALL_GROUPS_SELECT_GENERIC( size, funcs, vals, inforec, all, id, idList )
##
##  the selection for a layer with no better way: narrow the candidates with
##  what 'SMALL_GROUPS_PROPERTY_IDS' knows, then construct the rest and test
##  them.
SMALL_GROUPS_SELECT_GENERIC := function( size, funcs, vals, inforec,
                                        all, id, idList )
    local result, i, g, ok, j, sel, range, nid;

    if not IsBound( inforec.number ) then
        inforec := NUMBER_SMALL_GROUPS_FUNCS[ inforec.func ]( size, inforec);
    fi;

    # narrow down the candidates using properties which can be decided from
    # the position of a group in the library
    sel   := SMALL_GROUPS_PROPERTY_IDS( size, inforec, funcs, vals );
    funcs := sel.funcs;
    vals  := sel.vals;

    if idList = fail then
        range := SMALL_IDS_EXPAND( sel.ids );
    else
        range := Filtered( idList, x -> SMALL_IDS_MEMBER( sel.ids, x ) );
    fi;

    # if nothing is left to be checked, the groups need not be constructed
    if funcs = [ ] and all and id then
        return List( range, x -> [ size, x ] );
    fi;

    if funcs <> [ ] and idList = fail then
        Info( InfoWarning, 2, "`SelectSmallGroups' checks ", Length( range ),
                            " grps of size ", size, " with trivial methods");
    fi;

    result := [ ];
    for i in range do
        nid:=i;
        if not SMALL_GROUPS_OLD_ORDER then
            if size = 3^7 then
                nid := SMALLGP_PERM3(i);
            elif size = 5^7 then
                nid := SMALLGP_PERM5(i);
            elif size = 7^7 then
                nid := SMALLGP_PERM7(i);
            elif size = 11^7 then
                nid := SMALLGP_PERM11(i);
            fi;
        fi;

        g := SMALL_GROUP_FUNCS[ inforec.func ]( size, nid, inforec );
        SetIdGroup( g, [ size, i ] );
        ok := true;
        for j in [ 1 .. Length( funcs ) ] do
            ok := ok and funcs[ j ]( g ) in vals[ j ];
        od;
        if all and id and ok then
            Add( result, [ size, i ] );
        elif all and ok then
            Add( result, g );
        elif ok then          
            return g;                                           
        fi;
    od;                                                                     

    if all then
        return result;
    else
        return fail;
    fi;
end;

#############################################################################
##
#V  SMALL_GROUP_LIB
##
##  This list will contain all data for the group construction read from the
##  small group library.
SMALL_GROUP_LIB := [ ];

#############################################################################
##
#V  PROPERTIES_SMALL_GROUPS
##
##  This list will contain all data for the group selection read from the
##  small group library.
PROPERTIES_SMALL_GROUPS := [ ];

#############################################################################
##
#F  SmallGroup(<size>,<i>)
##
##  returns the <i>th  group of  order <size> in the catalogue. It will return
##  an PcGroup, if the group is soluble and a permutation group otherwise.
##  If the groups of this size are not installed, it will return an error.
InstallGlobalFunction( SmallGroup, function( arg )
    local inforec, g, size, i, nid;

    if Length( arg ) = 1 then
        if not IsList( arg[1] ) or Length( arg[1] ) <> 2 then
            Error( "usage: SmallGroup( order, number )" );
        fi;
        size := arg[ 1 ][ 1 ];
        i    := arg[ 1 ][ 2 ];
    elif Length( arg ) = 2 then
        size := arg[ 1 ];
        i    := arg[ 2 ];
    else
        Error( "usage: SmallGroup( order, number )" );
    fi;
    if not IsPosInt( size ) or not IsPosInt( i ) then
        Error( "usage: SmallGroup( order, number )" );
    fi;
    inforec := SMALL_AVAILABLE( size );
    if inforec = fail then
        Error( "the library of groups of size ", size, " is not available" );
    fi;
    nid := i;
    if not SMALL_GROUPS_OLD_ORDER then
        if size = 3^7 then
            nid := SMALLGP_PERM3(i);
        elif size = 5^7 then
            nid := SMALLGP_PERM5(i);
        elif size = 7^7 then
            nid := SMALLGP_PERM7(i);
        elif size = 11^7 then
            nid := SMALLGP_PERM11(i);
        fi;
    fi;
    g := SMALL_GROUP_FUNCS[ inforec.func ]( size, nid, inforec );
    SetIdGroup( g, [ size, i ] );
    IsPGroup( g );
    return g;
end );

#############################################################################
##
#F  NumberSmallGroups(<size>)
##
##  returns the  number of groups of the order <size>.
InstallGlobalFunction( NumberSmallGroups, function( size )
    local inforec;

    if not IsPosInt( size ) then 
        Error( "usage: NumberSmallGroups( order )" ); 
    fi;
    if size = 1024 then 
        return 49487367289;
    fi;

    inforec := SMALL_AVAILABLE( size );
    if inforec = fail then
        Error( "the library of groups of size ", size, " is not available" );
    fi;

    if IsBound( inforec.number ) then 
        return inforec.number;
    fi;
    return NUMBER_SMALL_GROUPS_FUNCS[ inforec.func ]( size, inforec ).number;
end );

#############################################################################
##
#F  SelectSmallGroups( argl, all, id )
##
InstallGlobalFunction( SelectSmallGroups, function( argl, all, id )
    local sizes, size, i, funcs, vals, gs, inforec, result, hasSizes, pos,
          idList, query;

    sizes := [ ];
    hasSizes := false;
    idList := fail;

    for i in [ 1 .. Length( argl ) ] do
        if i = 1 and argl[ i ] = Size then
            ;
        elif ( not hasSizes ) and IsList( argl[ i ] )
                              and Length( sizes ) = 1 then
            idList := argl[ i ];
        elif ( not hasSizes ) and IsList( argl[ i ] ) then
            Append( sizes, argl[ i ] );
        elif ( not hasSizes ) and IsPosInt( argl[ i ] ) then
            Add( sizes, argl[ i ] );
        elif ( not hasSizes ) and sizes <> [] and IsFunction( argl[i] ) then
            hasSizes     := true;
            funcs        := [ argl[ i ] ];
            vals         := [ [ ] ];
            pos          := 1;
        elif not hasSizes then 
            Error( "usage: AllSmallGroups / OneSmallGroup(\n",
                   "             Size, [ sizes ],\n",
                   "             function1, [ values1 ],\n",
                   "             function2, [ values2 ], ... )" );
        elif vals[ pos ] <> [ ] and IsFunction( argl[ i ] ) then
            pos          := pos + 1;
            funcs[ pos ] := argl[ i ];
            vals[ pos ]  := [ ];
        elif IsFunction( argl[ i ] ) then
            vals[ pos ]  := [ true ];
            pos          := pos + 1; 
            funcs[ pos ] := argl[ i ];
            vals[ pos ]  := [ ];
        elif IsList( argl[ i ] ) and vals[ pos ] = [ ] then
            vals[ pos ]  := argl[ i ];
        elif IsList( argl[ i ] ) and IsInt( argl[ i ][ 1 ] ) and 
             IsList( vals[ pos ][ 1 ] ) and IsInt( vals[ pos ][1][ 1 ] ) then
            Add( vals[ pos ], argl[ i ] );
        elif IsList( argl[ i ] ) and IsInt( argl[ i ][ 1 ] ) and 
             IsInt( vals[ pos ][ 1 ] ) then
            vals[ pos ]  := [ vals[ pos ], argl[ i ] ];
        else 
            Add( vals[ pos ], argl[ i ] );
        fi;
    od;

    if sizes <> [ ] and ( not IsBound( vals ) ) then
        funcs := [ ];
        vals  := [ ];
    elif vals[ pos ] = [ ] then
        vals[ pos ] := [ true ];
    fi;

    query := SMALL_GROUPS_SIMPLIFY_QUERY( funcs, vals );
    funcs := query.funcs;
    vals  := query.vals;

    result := [ ];
    for size in sizes do
        inforec := SMALL_AVAILABLE( size );
        if inforec = fail then
            Error( "AllSmallGroups / OneSmallGroup: groups of order ", size,
                   " not available" );
        fi;
        gs := SELECT_SMALL_GROUPS_FUNCS[ inforec.func ]
                             ( size, funcs, vals, inforec, all, id, idList );
        if all then
            Append( result, gs );
        elif gs <> fail then
            return gs;
        fi;
    od;
    
    if all then
        return result;
    else
        return fail;
    fi;
end );

#############################################################################
##
#F ID_AVAILABLE_FUNCS
##
ID_AVAILABLE_FUNCS := [ ];

#############################################################################
##
#F ID_AVAILABLE
##
InstallGlobalFunction( ID_AVAILABLE, function( size )
    local l, r;

    if not IsInt( size ) then return fail; fi;

    for l in [ 1 .. Length( ID_AVAILABLE_FUNCS ) ] do
        if IsBound( ID_AVAILABLE_FUNCS[ l ] ) then
            r := ID_AVAILABLE_FUNCS[ l ]( size );
            if r <> fail then 
                return r;
            fi;
        fi;
    od;
    return fail;
end );

InstallGlobalFunction( IdGroupsAvailable,
function(order)
    return ID_AVAILABLE(order) <> fail;
end);

#############################################################################
##
#F  ID_GROUP_FUNCS
##
ID_GROUP_FUNCS := [ ];

#############################################################################
##
#M  IdGroup( G )
##
InstallMethod( IdGroup,
               "generic method for groups",
               true,
               [ IsGroup ],
               0,
function( G )
    local inforec, size, id;

    size := Size( G );
    if size = 1 then return [ 1, 1 ]; fi;

    inforec := ID_AVAILABLE( size );
    if inforec = fail then
        Error( "the group identification for groups of size ", size,
               " is not available" );
    fi;

    if not ( IsPcGroup( G ) or IsPermGroup( G ) ) then
        if IsSolvableGroup( G ) then
            G := Image( IsomorphismPcGroup( G ) );
        else
            G := Image( IsomorphismPermGroup( G ) );
        fi;
    fi;

    if Size( G ) > 1000 and IsPermGroup( G )
          and LargestMovedPoint( G ) > 100 and IsSolvableGroup( G ) then
        G := Image( IsomorphismPcGroup( G ) );
    fi;

    if IsPcGroup( G ) and HasParent( G ) and Size( Parent( G ) ) > 10000
       and Size( Parent( G ) ) / Size( G ) > 10 then
        G := PcGroupCode( CodePcGroup( G ), Size( G ) );
    fi;

    id := ID_GROUP_FUNCS[ inforec.func ]( G, inforec );

    if not SMALL_GROUPS_OLD_ORDER then
        if size = 3^7 then
          id:=First([1..NrSmallGroups(3^7)],x->SMALLGP_PERM3(x)=id);
        elif size = 5^7 then
          # note that the permutation is not an involution!
          id:=First([1..NrSmallGroups(5^7)],x->SMALLGP_PERM5(x)=id);
        elif size = 7^7 then
          id:=First([1..NrSmallGroups(7^7)],x->SMALLGP_PERM7(x)=id);
        elif size = 11^7 then
          id:=First([1..NrSmallGroups(11^7)],x->SMALLGP_PERM11(x)=id);
        fi;
    fi;
    return [ size, id ];
end );

#############################################################################
##
#V  ID_GROUP_TREE
##
##  Variable containing information for group identification
ID_GROUP_TREE := rec( fp := [ 1 .. 50000 ], next := [ ] );

#############################################################################
##
#F  ReadSmallLib( str, i, size, list )
##
##  universal reading function for data files
ReadSmallLib := function( str, i, size, list )
    local l, str2, str3, j;

    l := "abcdefghijklmnopqrstuvwxyz";     
    str2 := Concatenation( str, String( size ) );
    str3 :=  [ ];
    for j in list do
        if j > 702 then
            Add( str3, l[ QuoInt( j - 27, 676 ) ] );
            j := 27 + ( j - 27 ) mod 676;
        fi; 
        if j > 26 then
            Add( str3, l[ QuoInt( j - 1, 26 ) ] );        
        fi;         
        Add( str3, l[ ( j - 1 ) mod 26 + 1 ] );
    od;

    if Length( str2 ) > 8 then
        str3 := Concatenation( str2{[ 9..Length( str2 ) ]} , str3 );
        str2 := str2{[ 1..8 ]};
    elif Length( str3 ) = 0 then
        str3 := "z";
    elif Length( str3 ) > 3 then
        str2 := Concatenation( str2, str3{[ 1 .. Length( str3 ) - 3 ]} );
        str3 := str3{[ Length( str3 ) - 2 .. Length( str3 ) ]};
    fi;

    if str in [ "sml", "col", "prop", "nor" ] then
        READ_SMALL_FUNCS[ i ]( Concatenation( str2, ".", str3 ) );
    else
        READ_IDLIB_FUNCS[ i ]( Concatenation( str2, ".", str3 ) );
    fi;
end;

#############################################################################
##
#V  GAP3_CATALOGUE_ID_GROUP
##
##  List with the gap3-ids. Will be loaded before use.
GAP3_CATALOGUE_ID_GROUP := fail;

#############################################################################
##
#M  Gap3CatalogueIdGroup(<G>)
##
InstallMethod( Gap3CatalogueIdGroup,
               "for permgroups or pcgroups",
               true,
               [ IsGroup ],
               0,
function( G )
    if Size( G ) > 100 then
        Error( "Gap3CatalogueIdGroup: the group catalogue of gap-3.0 was\n",
               "limited to size 100" );
    fi;

    if GAP3_CATALOGUE_ID_GROUP = fail then
        ReadPackage( "smallgrp", "gap/gap3cat.g" );
    fi;

    if not IsBound( GAP3_CATALOGUE_ID_GROUP[ Size( G ) ] ) then
        return IdGroup( G );
    fi;

    return [ Size( G ),
             GAP3_CATALOGUE_ID_GROUP[ Size( G ) ][ IdGroup( G )[ 2 ] ] ];
end );

#############################################################################
##
#F  Gap3CatalogueGroup(<size>,<i>)
##
InstallGlobalFunction( Gap3CatalogueGroup,
function( size, i )
    local p;

    if size > 100 then
        Error( "Gap3CatalogueIdGroup: the group catalogue of gap-3.0 was\n",
               "limited to size 100" );
    fi;

    if GAP3_CATALOGUE_ID_GROUP = fail then
        ReadPackage("smallgrp", "gap/gap3cat.g");
    fi;

    if not IsBound( GAP3_CATALOGUE_ID_GROUP[ size ] ) then
        return SmallGroup( size, i );
    fi;

    p := Position( GAP3_CATALOGUE_ID_GROUP[ size ], i );
    if p = fail then
        Error( "Gap3CatalogueGroup: there are just ",
               Length( GAP3_CATALOGUE_ID_GROUP[ size ] ),
               " groups of size ", size );
    fi;

    return SmallGroup( size, p );
end );

#############################################################################
##
#F  UnloadSmallGroupsData( )
##
##  will remove the data from the small groups library from memory. 
InstallGlobalFunction( UnloadSmallGroupsData, function( )
    SMALL_GROUP_LIB := [ ];
    PROPERTIES_SMALL_GROUPS := [ ];
    GAP3_CATALOGUE_ID_GROUP := fail;
    ID_GROUP_TREE := rec( fp := [ 1 .. 50000 ], next := [ ] );
end );

#############################################################################
##
#M  FrattinifactorSize(<G>)
##
InstallMethod( FrattinifactorSize,
               "generic method for groups",
               true,
               [ IsGroup ],
               0,
function( G )
    return Size( G ) / Size( FrattiniSubgroup( G ) );
end );

#############################################################################
##
#M  FrattinifactorId(<G>)
##
InstallMethod( FrattinifactorId,
               "generic method for groups",
               true,
               [ IsGroup ],
               0,
function( G )
    local ff;                                  

    ff := G / FrattiniSubgroup( G );  
    if ID_AVAILABLE( Size( ff ) ) = fail then
        Error( "FrattinifactorId: IdGroup for groups of size ", Size( ff ),
               " not available" );
    fi;
    return IdGroup( ff );                                      
end );
