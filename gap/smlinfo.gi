#############################################################################
##
#W  smlinfo.gi               GAP group library             Hans Ulrich Besche
##                                               Bettina Eick, Eamonn O'Brien
##
##  This file contains the ...
##

#############################################################################
##
#V  SMALL_GROUPS_INFORMATION_RECORDS
##
##  for each value of 'func' of the layers of this package, a function
##  '( size, smav, num )' returning what 'SmallGroupsInformationRecord'
##  reports beyond the generic components: 'description', the text that
##  'SmallGroupsInformation' prints; 'ranges', the groups of this order
##  grouped by what they have in common; and optionally 'sortedBy',
##  'comment' and 'indexed'
SMALL_GROUPS_INFORMATION_RECORDS := [ ];

#############################################################################
##
#F  SMALL_GROUPS_INFORMATION
##
##  for each value of 'func', a function '( size, smav, num )' printing the
##  description of the groups of order 'size'. Other packages can fill
##  further entries; the entries for the layers of this package print what
##  'SMALL_GROUPS_INFORMATION_RECORDS' returns.
SMALL_GROUPS_INFORMATION := [ ];

#############################################################################
##
#F  SMALL_GROUPS_PRINT_INDEXED( names )
##
##  prints the list of those selection criteria whose value the selection
##  functions know for a size without having to construct a group
SMALL_GROUPS_PRINT_INDEXED := function( names )
    local col, i, s;

    if names = [ ] then
        return;
    fi;

    Print( "\n  The following selection criteria are indexed for this size:",
           "\n    " );
    col := 4;
    for i in [ 1 .. Length( names ) ] do
        s := ShallowCopy( names[ i ] );
        if i < Length( names ) - 1 then
            Append( s, "," );
        elif i = Length( names ) and i > 1 then
            s := Concatenation( "and ", s );
        fi;
        if i = Length( names ) then
            Append( s, "." );
        fi;
        if col + Length( s ) + 1 > 78 then
            Print( "\n    " );
            col := 4;
        fi;
        Print( " ", s );
        col := col + Length( s ) + 1;
    od;
    Print( "\n" );
end;

#############################################################################
##
#F  SMALL_GROUPS_INFO_RANGE( from, to, text, values )
##
##  the groups with ids 'from' to 'to', which share what 'text' says and the
##  attribute values in the record 'values'
SMALL_GROUPS_INFO_RANGE := function( from, to, text, values )
    return rec( from := from, to := to, text := text, values := values );
end;

#############################################################################
##
#F  SMALL_GROUPS_INFO_STREAM( str )
##
##  a stream appending to the string 'str', without the line breaks the
##  output to the screen would insert, so that printing 'str' later gives
##  exactly the output of the same calls to 'Print'
SMALL_GROUPS_INFO_STREAM := function( str )
    local out;
    out := OutputTextString( str, true );
    SetPrintFormattingStatus( out, false );
    return out;
end;

#############################################################################
##
#V  SMALL_GROUPS_LAYER_SOURCES
##
##  for each layer of this package, the keys in the bibliography of this
##  package of the publications that determined its groups, as listed in the
##  chapter on the organisation of the library
SMALL_GROUPS_LAYER_SOURCES := [
    [ "Hoelder1893" ],
    [ "OBr90", "JNO90", "OBr91", "BescheEick98", "BescheEick1000",
      "BescheEick768" ],
    [ "BescheEick768" ],
    [ "OBr90", "BescheEick768" ],
    [ "OBr90", "JNO90", "OBr91", "BescheEick98", "BescheEick1000",
      "BescheEick768" ],
    [ "BEO01", "BescheEick98" ],
    [ "EOB98", "EOB99", "OBr90", "BEO01" ],
    [ "BescheEick98", "BescheEick768" ],
    [ "Hoelder1893", "Bagnera1898", "NOV04", "Gir03" ],
    [ "Hoelder1895", "DEi05" ],
    [ "OV05" ] ];

#############################################################################
##
#F  SMALL_GROUPS_SOURCES( smav )
##
SMALL_GROUPS_SOURCES := function( smav )
    local lib;

    lib := 1;
    if IsBound( smav.lib ) then
        lib := smav.lib;
    fi;
    # layer 10 holds the squarefree orders (func 24) and the cubefree ones
    if lib = 10 and smav.func = 25 then
        return [ "DEi05" ];
    fi;
    if not IsBound( SMALL_GROUPS_LAYER_SOURCES[ lib ] ) then
        return [ ];
    fi;
    return ShallowCopy( SMALL_GROUPS_LAYER_SOURCES[ lib ] );
end;

#############################################################################
##
#F  SMALL_GROUPS_INFORMATION_DATA( size )
##
##  'fail' if the groups of order 'size' are not available, otherwise a record
##  with components 'record', the result of 'SmallGroupsInformationRecord';
##  'smav' and 'number', as needed to call the 'information' function of the
##  layer; and 'printed', whether 'record.description' replaces that call
SMALL_GROUPS_INFORMATION_DATA := function( size )
    local smav, num, r, info, props, nam;

    # the number is known, the groups are not
    if size = 1024 then
        return fail;
    fi;

    smav := SMALL_AVAILABLE( size );
    if smav = fail then
        return fail;
    fi;

    if IsBound( smav.number ) then
        num := smav.number;
    else
        num := smav.layer.numberOf( size, smav ).number;
    fi;

    r := rec( order := size, number := num, layer := smav.layer.name,
              ranges := [ ] );
    if smav.layer.name = "SmallGrp" then
        r.layerNumber := 1;
        if IsBound( smav.lib ) then
            r.layerNumber := smav.lib;
        fi;
    fi;

    info := fail;
    if IsBound( smav.layer.informationRecord ) then
        info := smav.layer.informationRecord( size, smav, num );
    fi;
    if info <> fail then
        for nam in RecNames( info ) do
            r.( nam ) := info.( nam );
        od;
    fi;

    # those properties whose value the selection functions can read off
    # from the position a group has in this list
    if not IsBound( r.indexed ) then
        r.indexed := [ ];
        if IsBound( smav.layer.properties ) then
            if not IsBound( smav.number ) then
                smav.number := num;
            fi;
            props := smav.layer.properties( size, smav );
            if props <> fail then
                r.indexed := List( Filtered( Concatenation(
                                       SMALL_GROUPS_INDEXED_PROPERTIES,
                                       SMALL_GROUPS_INDEXED_ATTRIBUTES ),
                                   t -> IsBound( props.( t[ 1 ] ) ) ),
                                   t -> t[ 3 ] );
            fi;
        fi;
    fi;

    r.idAvailable := ID_AVAILABLE( size ) <> fail;

    return rec( record := r, smav := smav, number := num,
                printed := IsBound( r.description ) );
end;

#############################################################################
##
#F  SmallGroupsInformationRecord( size )
##
InstallGlobalFunction( SmallGroupsInformationRecord, function( size )
    local data;

    if not IsPosInt( size ) then
        ErrorNoReturn( "usage: SmallGroupsInformationRecord( size )" );
    fi;

    data := SMALL_GROUPS_INFORMATION_DATA( size );
    if data = fail then
        return fail;
    fi;
    return data.record;
end );

#############################################################################
##
#F  SmallGroupsInformation( size )
##
InstallGlobalFunction( SmallGroupsInformation, function( size )
    local data, r;

    if not IsPosInt(size) then
      ErrorNoReturn("usage: SmallGroupsInformation( size )");
    fi;

    data := SMALL_GROUPS_INFORMATION_DATA( size );
    if data = fail then
        Print( "The groups of size ", size, " are not available. \n");
        return;
    fi;
    r := data.record;

    if r.number = 1 then
        Print("\n  There is 1 group of order ",size,".\n");
    else
        Print("\n  There are ",r.number," groups of order ",size,".\n" );
    fi;

    if data.printed then
        Print( r.description );
    else
        data.smav.layer.information( size, data.smav, data.number );
    fi;

    SMALL_GROUPS_PRINT_INDEXED( r.indexed );

    if r.layer = "SmallGrp" then
        Print("\n  This size belongs to layer ",r.layerNumber,
              " of the SmallGroups library. \n");
    else
        Print("\n  This size belongs to the layer \"",r.layer,"\". \n");
    fi;

    if r.idAvailable then
        Print("  IdSmallGroup is available for this size. \n \n");
    else
        Print("  IdSmallGroup is not available for this size. \n \n");
    fi;
end );

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 1 .. 7 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 1 ] := function( size, smav, num )
    local str;

    str := Concatenation(
        "\n",
        "  The groups whose order factorises in at most 3 primes \n",
        "  have been classified by O. Hoelder. This classification is \n",
        "  used in the SmallGroups library. \n" );
    return rec( description := str, ranges := [ ],
                comment := NormalizedWhitespace( str ) );
end;

SMALL_GROUPS_INFORMATION_RECORDS[ 2 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 1 ];
SMALL_GROUPS_INFORMATION_RECORDS[ 3 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 1 ];
SMALL_GROUPS_INFORMATION_RECORDS[ 4 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 1 ];
SMALL_GROUPS_INFORMATION_RECORDS[ 5 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 1 ];
SMALL_GROUPS_INFORMATION_RECORDS[ 6 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 1 ];
SMALL_GROUPS_INFORMATION_RECORDS[ 7 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 1 ];

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 8 .. 10 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 8 ] := function( size, smav, num )
    local ffid, prop, i, l, str, out, r, from, to;

    ffid := IdGroup( OneSmallGroup( size, FrattinifactorSize, size ) );
    prop := PROPERTIES_SMALL_GROUPS[ size ].frattFacs;
    str := "";
    out := SMALL_GROUPS_INFO_STREAM( str );
    r := rec( ranges := [ ] );

    if not IsPrimePowerInt( size ) then
        r.sortedBy := "Frattini factor";
        PrintTo( out, "  They are sorted by their Frattini factors. \n");
        i := 1;
        if ffid[ 2 ] > 1 then
            repeat
                from := prop.pos[ i ][ 1 ];
                to := -prop.pos[ i ][ 2 ];
                if from = to then
                    PrintTo( out, "     ", from,
                       " has Frattini factor ", prop.frattFacs[ i ], ".\n"  );
                else
                    PrintTo( out, "     ", from, " - ", to,
                       " have Frattini factor ", prop.frattFacs[ i ], ".\n"  );
                fi;
                Add( r.ranges, SMALL_GROUPS_INFO_RANGE( from, to,
                    Concatenation( "Frattini factor ",
                                   String( prop.frattFacs[ i ] ) ),
                    rec( FrattinifactorId := prop.frattFacs[ i ] ) ) );
                i := i + 1;
            until prop.frattFacs[ i ] = ffid;
        fi;
        PrintTo( out, "     ", ffid[2], " - ", num,
              " have trivial Frattini subgroup.\n");
        Add( r.ranges, SMALL_GROUPS_INFO_RANGE( ffid[ 2 ], num,
            "trivial Frattini subgroup",
            rec( FrattinifactorSize := size ) ) );
        r.indexed := [ "IsAbelian", "IsNilpotentGroup",
                "IsSupersolvableGroup", "IsSolvableGroup", "LGLength",
                "FrattinifactorSize", "FrattinifactorId" ];
    else
        r.sortedBy := "rank";
        PrintTo( out, "  They are sorted by their ranks. \n");
        PrintTo( out, "     ", 1, " is cyclic. \n");
        Add( r.ranges, SMALL_GROUPS_INFO_RANGE( 1, 1, "cyclic",
                                                rec( RankPGroup := 1 ) ) );
        i := 2;
        repeat
            l := Length( Factors( prop.frattFacs[ i ][1] ) );
            from := prop.pos[ i ][ 1 ];
            to := -prop.pos[ i ][ 2 ];
            if from = to then
                PrintTo( out, "     ", from, " has rank ", l, ".\n"  );
            else
                PrintTo( out, "     ", from, " - ", to, " have rank ", l,
                         ".\n"  );
            fi;
            Add( r.ranges, SMALL_GROUPS_INFO_RANGE( from, to,
                Concatenation( "rank ", String( l ) ),
                rec( RankPGroup := l ) ) );
            i := i + 1;
        until prop.frattFacs[ i ] = ffid;
        PrintTo( out, "     ", ffid[2], " is elementary abelian. \n");
        Add( r.ranges, SMALL_GROUPS_INFO_RANGE( ffid[ 2 ], ffid[ 2 ],
            "elementary abelian",
            rec( RankPGroup := Length( Factors( size ) ) ) ) );
        r.indexed := [ "IsAbelian", "IsNilpotentGroup",
                "IsSupersolvableGroup", "IsSolvableGroup", "PClassPGroup",
                "RankPGroup", "FrattinifactorSize", "FrattinifactorId" ];
    fi;

    CloseStream( out );
    r.description := str;
    return r;
end;
SMALL_GROUPS_INFORMATION_RECORDS[ 9 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 8 ];
SMALL_GROUPS_INFORMATION_RECORDS[ 10 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 8 ];

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 11, 17 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 11 ] := function( size, smav, num )
    local i, q, str, out, r, text;

    q := 2;
    if IsBound( smav.q ) then q := smav.q; fi;
    str := "";
    out := SMALL_GROUPS_INFO_STREAM( str );
    r := rec( sortedBy := "normal Sylow subgroups", ranges := [ ] );

    PrintTo( out, "  They are sorted by normal Sylow subgroups. \n");
    PrintTo( out, "     1 - ", smav.pos[ 2 ], " are the nilpotent groups.\n" );
    Add( r.ranges, SMALL_GROUPS_INFO_RANGE( 1, smav.pos[ 2 ], "nilpotent",
                                            rec( IsNilpotentGroup := true ) ) );
    for i in [ 2 .. Length( smav.types ) ] do
        PrintTo( out, "     ", smav.pos[i] + 1, " - ", smav.pos[i+1] );
        text := fail;
        if smav.types[ i ] = "p-autos" then
            PrintTo( out, " have a normal Sylow ", q,"-subgroup. \n");
            text := Concatenation( "normal Sylow ", String( q ), "-subgroup" );
        elif smav.types[ i ] = "none-p-nil" then
            PrintTo( out, " have no normal Sylow subgroup. \n");
            text := "no normal Sylow subgroup";
        elif IsInt( smav.types[ i ] ) then
            PrintTo( out, " have a normal Sylow ", smav.p, "-subgroup \n");
            PrintTo( out, "                     with centralizer of index ");
            PrintTo( out, q^smav.types[i],".\n");
            text := Concatenation( "normal Sylow ", String( smav.p ),
                                   "-subgroup with centralizer of index ",
                                   String( q^smav.types[ i ] ) );
        fi;
        if text <> fail then
            Add( r.ranges, SMALL_GROUPS_INFO_RANGE( smav.pos[ i ] + 1,
                                                    smav.pos[ i + 1 ], text,
                                                    rec() ) );
        fi;
    od;

    CloseStream( out );
    r.description := str;
    return r;
end;
SMALL_GROUPS_INFORMATION_RECORDS[ 17 ] := SMALL_GROUPS_INFORMATION_RECORDS[ 11 ];

#############################################################################
##
#F SMALL_GROUPS_INFO_FIXED( header, sortedBy, ranges )
##
##  the information for an order whose groups are described by the fixed
##  list 'ranges' of entries '[ from, to, printed, text, values ]', where
##  'printed' is what the line of the range prints after the ids; 'header',
##  if not 'fail', is the line printed before the ranges
SMALL_GROUPS_INFO_FIXED := function( header, sortedBy, ranges )
    local str, out, r, t;

    str := "";
    out := SMALL_GROUPS_INFO_STREAM( str );
    r := rec( sortedBy := sortedBy, ranges := [ ] );
    if header <> fail then
        PrintTo( out, header );
    fi;
    for t in ranges do
        PrintTo( out, "     ", t[ 1 ], " - ", t[ 2 ], " ", t[ 3 ], ".\n" );
        Add( r.ranges, SMALL_GROUPS_INFO_RANGE( t[ 1 ], t[ 2 ], t[ 4 ],
                                                t[ 5 ] ) );
    od;
    CloseStream( out );
    r.description := str;
    return r;
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 12 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 12 ] := function( size, smav, num )

    if size = 1152 then
        return SMALL_GROUPS_INFO_FIXED(
            "  They are sorted using Sylow subgroups. \n",
            "Sylow subgroups",
            [ [ 1, 2328, "are nilpotent with Sylow 3-subgroup c9",
                "nilpotent with Sylow 3-subgroup c9",
                rec( IsNilpotentGroup := true ) ],
              [ 2329, 4656, "are nilpotent with Sylow 3-subgroup 3^2",
                "nilpotent with Sylow 3-subgroup 3^2",
                rec( IsNilpotentGroup := true ) ],
              [ 4657, 153312, "are non-nilpotent with normal Sylow 3-subgroup",
                "non-nilpotent with normal Sylow 3-subgroup",
                rec( IsNilpotentGroup := false ) ],
              [ 153313, 157877, "have no normal Sylow 3-subgroup",
                "no normal Sylow 3-subgroup", rec() ] ] );
    fi;

    return SMALL_GROUPS_INFO_FIXED(
        "  They are sorted using Hall subgroups. \n",
        "Hall subgroups",
        [ [ 1, 2328, "are the nilpotent groups", "nilpotent",
            rec( IsNilpotentGroup := true ) ],
          [ 2329, 236344, "have a normal Hall (3,5)-subgroup",
            "normal Hall (3,5)-subgroup", rec() ],
          [ 236345, 240416, "are solvable without normal Hall (3,5)-subgroup",
            "solvable without normal Hall (3,5)-subgroup",
            rec( IsSolvableGroup := true ) ],
          [ 240417, 241004, "are not solvable", "not solvable",
            rec( IsSolvableGroup := false ) ] ] );
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 14 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 14 ] := function( size, smav, num )

    return SMALL_GROUPS_INFO_FIXED( fail, "normal Sylow subgroups",
        [ [ 1, 10494213, "are the nilpotent groups", "nilpotent",
            rec( IsNilpotentGroup := true ) ],
          [ 10494214, 408526597, "have a normal Sylow 3-subgroup",
            "normal Sylow 3-subgroup", rec() ],
          [ 408526598, 408544625, "have a normal Sylow 2-subgroup",
            "normal Sylow 2-subgroup", rec() ],
          [ 408544626, 408641062, "have no normal Sylow subgroup",
            "no normal Sylow subgroup", rec() ] ] );
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 18 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 18 ] := function( size, smav, num )
    local i, t, str, out, r;

    str := "";
    out := SMALL_GROUPS_INFO_STREAM( str );
    r := rec( sortedBy := "rank and p-class", ranges := [ ] );

    PrintTo( out, "     1 is cyclic. \n");
    Add( r.ranges, SMALL_GROUPS_INFO_RANGE( 1, 1, "cyclic",
                                            rec( RankPGroup := 1 ) ) );
    for i in [ 2 .. Length( SMALL_GROUPS_512_TYPES ) - 1 ] do
        t := SMALL_GROUPS_512_TYPES[ i ];
        if t[ 1 ] = t[ 2 ] then
            PrintTo( out, "     ", t[ 1 ], " has rank " );
        else
            PrintTo( out, "     ", t[ 1 ], " - ", t[ 2 ], " have rank " );
        fi;
        PrintTo( out, t[ 3 ], " and p-class ", t[ 4 ], ".\n" );
        Add( r.ranges, SMALL_GROUPS_INFO_RANGE( t[ 1 ], t[ 2 ],
            Concatenation( "rank ", String( t[ 3 ] ), " and p-class ",
                           String( t[ 4 ] ) ),
            rec( RankPGroup := t[ 3 ], PClassPGroup := t[ 4 ] ) ) );
    od;
    PrintTo( out, "     ", num, " is elementary abelian.\n");
    Add( r.ranges, SMALL_GROUPS_INFO_RANGE( num, num, "elementary abelian",
                       rec( RankPGroup := 9, PClassPGroup := 1 ) ) );

    CloseStream( out );
    r.description := str;
    return r;
end;

#############################################################################
##
#F SMALL_GROUPS_INFO_RANKS( header, size, bounds, ending )
##
##  the information for the groups of order 'size' = p^n, sorted by their
##  ranks: 1 is cyclic, then 'bounds[ i - 1 ] + 1' to 'bounds[ i ]' have rank
##  i + 1, and the last group is elementary abelian; 'ending' follows the
##  period of the line of the cyclic group
SMALL_GROUPS_INFO_RANKS := function( header, size, bounds, ending )
    local str, out, r, i, from, n;

    str := "";
    out := SMALL_GROUPS_INFO_STREAM( str );
    r := rec( sortedBy := "rank", ranges := [ ] );
    n := Length( Factors( size ) );

    PrintTo( out, header );
    PrintTo( out, "     1 is cyclic.", ending, "\n");
    Add( r.ranges, SMALL_GROUPS_INFO_RANGE( 1, 1, "cyclic",
                                            rec( RankPGroup := 1 ) ) );
    from := 2;
    for i in [ 1 .. Length( bounds ) ] do
        PrintTo( out, "     ", from, " - ", bounds[ i ], " have rank ", i + 1,
                 ". \n" );
        Add( r.ranges, SMALL_GROUPS_INFO_RANGE( from, bounds[ i ],
            Concatenation( "rank ", String( i + 1 ) ),
            rec( RankPGroup := i + 1 ) ) );
        from := bounds[ i ] + 1;
    od;
    PrintTo( out, "     ", from, " is elementary abelian. \n");
    Add( r.ranges, SMALL_GROUPS_INFO_RANGE( from, from, "elementary abelian",
                                            rec( RankPGroup := n ) ) );

    CloseStream( out );
    r.description := str;
    return r;
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 19 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 19 ] := function( size, smav, num )
    return SMALL_GROUPS_INFO_RANKS( "  They are sorted by their ranks. \n",
                                    size, [ 10, 14 ], " " );
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 20 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 20 ] := function( size, smav, num )
    local p, a, b, c;

    p := Factors(size)[1];
    a:=27 + p   + 2*GcdInt(p-1,3) + GcdInt(p-1,4);
    b:=54 + 2*p + 2*GcdInt(p-1,3) + GcdInt(p-1,4);
    c:=60 + 2*p + 2*GcdInt(p-1,3) + GcdInt(p-1,4);

    return SMALL_GROUPS_INFO_RANKS( "  They are sorted by their ranks.\n",
                                    size, [ a, b, c ], "" );
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 21 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 21 ] := function( size, smav, num )
    local str;

    str := Concatenation(
        " \n",
        "      Easterfield (1940) constructed a list of the groups of\n",
        "      order p^6 for p >= 5.\n \n",

        "      The database of parametrised presentations for the groups \n",
        "      with order p^6 for p >= 5 is based on the Easterfield \n",
        "      list, corrected by Newman, O'Brien and Vaughan-Lee (2004).\n",
        "      It differs only in the addition of groups in isoclinism \n",
        "      family $\\Phi_{13}$, in using the James (1980) presentations \n",
        "      for the groups in $\\Phi_{19}$, and a small number of \n",
        "      typographical amendments. The linear ordering employed is \n",
        "      very close to that of Easterfield. \n \n",

        "      Each group with order $p^6$ is described by a power- \n",
        "      commutator presentation on 6 generators and 21 relations:\n",
        "      15 are commutator relations and 6 are power relations. \n",
        "      Each presentation has the prime $p$ as a parameter. \n",
        "      The database contains about 500 parametrised \n",
        "      presentations, most of these have $p$ as the only \n",
        "      parameter. \n" );
    return rec( description := str, ranges := [ ],
                comment := NormalizedWhitespace( str ) );
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 24 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 24 ] := function( size, smav, num )
    local i, set, c, str, out, r, text;

    str := "";
    out := SMALL_GROUPS_INFO_STREAM( str );
    r := rec( ranges := [ ], comment := Concatenation(
            "The groups of squarefree order have a cyclic socle and a ",
            "cyclic socle factor." ) );

    PrintTo( out, "\n" );
    PrintTo( out, "  The groups of squarefree order have a cyclic socle and a " );
    PrintTo( out, "cyclic socle factor.\n" );

    PrintTo( out, "\n" );
    i := 0;
    for set in smav.sets do
        c := Product( smav.primes{ set.kp } );
        if c = 1 then
            PrintTo( out, "    1 is abelian\n" );
            Add( r.ranges, SMALL_GROUPS_INFO_RANGE( i + 1, i + set.number,
                               "abelian", rec( IsAbelian := true ) ) );
        else
            if set.number = 1 then
                PrintTo( out, "    ", i + 1, " has socle C_" );
            else
                PrintTo( out, "    ", i + 1, " - ", i + set.number,
                         " have socle C_" );
            fi;
            PrintTo( out, size / c, " and factor C_", c, "\n" );
            text := Concatenation( "socle C_", String( size / c ),
                                   " and factor C_", String( c ) );
            Add( r.ranges, SMALL_GROUPS_INFO_RANGE( i + 1, i + set.number,
                                                    text, rec() ) );
        fi;
        i := i + set.number;
    od;

    CloseStream( out );
    r.description := str;
    return r;
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 25 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 25 ] := function( size, smav, num )
    local i, set, str, out, r, text, s;

    str := "";
    out := SMALL_GROUPS_INFO_STREAM( str );
    r := rec( ranges := [ ], comment := Concatenation(
            "The groups of cubefree order are either solvable or a direct ",
            "product of the form PSL( 2, p ) x solvable group. The cubefree ",
            "solvable groups are determined by their Frattini factor." ) );

    PrintTo( out, "\n" );
    PrintTo( out, "  The groups of cubefree order are either solvable or a direct ",
           "product of \n  the form PSL( 2, p ) x solvable group. ",
           "The cubefree solvable groups are \n  determined by their Frattini",
           " factor.\n\n" );

    i := 0;
    for set in smav.sets do
      if set.number = 1 then
        s := String( i + 1 );
      else
        s := Concatenation( String( i + 1 ), " - ", String( i + set.number ) );
      fi;
      if set.psl_p = 1 then
        if set.size_phi = 1 then
          text := "solvable and Frattini free";
          if set.number = 1 then
            PrintTo( out, "    ", s, " is solvable and Frattini free\n" );
          else
            PrintTo( out, "    ", s, " are solvable ",
                   "and Frattini free\n" );
          fi;
        else
          text := Concatenation( "solvable with Frattini factor of size ",
                                 String( set.size_ff ) );
          if set.number = 1 then
            PrintTo( out, "    ", s, " is solvable with Frattini factor of ",
                   "size ", set.size_ff, "\n" );
          else
            PrintTo( out, "    ", s, " are solvable ",
                   "with Frattini factor of size ", set.size_ff, "\n" );
          fi;
        fi;
      elif
        set.size_ff = 1 then
          text := Concatenation( "PSL( 2, ", String( set.psl_p ), " )" );
          PrintTo( out, "    ", s, " is PSL( 2, ", set.psl_p, " )\n" );
      else
        if set.size_phi = 1 then
          text := Concatenation( "PSL( 2, ", String( set.psl_p ),
                      " ) x F with F solvable and Frattini free of order ",
                      String( set.size_ff ) );
          if set.number = 1 then
            PrintTo( out, "    ", s, " is PSL( 2, ", set.psl_p, " ) x F, F ",
                   "solvable and Frattini free of order ", set.size_ff, "\n");
          else
            PrintTo( out, "    ", s, " are PSL( 2, ",
                   set.psl_p, " ) x F_i, F_i solvable ",
                   "Frattini free of order ", set.size_ff, "\n" );
          fi;
        else
          text := Concatenation( "PSL( 2, ", String( set.psl_p ),
                      " ) x G with G solvable of order ",
                      String( set.size_ff * set.size_phi ),
                      " with a Frattini factor of order ",
                      String( set.size_ff ) );
          if set.number = 1 then
            PrintTo( out, "    ", s, " is PSL( 2, ", set.psl_p, " ) x G, G ",
                   "solvable of order ", set.size_ff * set.size_phi,
                   " with a Frattini factor\n      of order ", set.size_ff,
                   "\n");
          else
            PrintTo( out, "    ", s, " are PSL( 2, ",
                   set.psl_p, " ) x G_i, G_i ", "solvable of order ",
                   set.size_ff * set.size_phi, " with a",
                   "\n      Frattini factor of order ", set.size_ff, "\n");
          fi;
        fi;
      fi;
      Add( r.ranges, SMALL_GROUPS_INFO_RANGE( i + 1, i + set.number, text,
                                              rec() ) );
      i := i + set.number;
    od;

    CloseStream( out );
    r.description := str;
    return r;
end;

#############################################################################
##
#F SMALL_GROUPS_INFORMATION_RECORDS[ 26 ]( size, smav, num )
##
SMALL_GROUPS_INFORMATION_RECORDS[ 26 ] := function( size, smav, num )
    local str;

    str := Concatenation(
        " \n",
        "      E.A. O'Brien and M.R. Vaughan-Lee determined presentations\n",
        "      of the groups with order p^7. A preprint of their paper is\n",
        "      available at\n",
        "      http://www.math.auckland.ac.nz/%7Eobrien/research/p7/paper-p7.pdf\n\n",
        "      For p in { 3, 5, 7, 11 } explicit lists of groups of order\n",
        "      p^7 have been produced and stored into the database.\n\n",
        "      Giving the power commutator presentations of any of these\n",
        "      groups using a standard notation they might be reduced to 35\n",
        "      elements of the group or a 245 p-digit number.\n\n",
        "      Only 56 of these digits may be unlike 0 for any group and\n",
        "      even these 56 digits are mostly like 0. Further on these\n",
        "      digits are often quite likely for sequences of subsequent\n",
        "      groups. Thus storage of groups was done by finding a so\n",
        "      called head group and a so called tail. Along the tail\n",
        "      only the different digits compared to the head are relevant.\n",
        "      Even the tails occur more or less often and this is used\n",
        "      to improve storage too. Since p^7 is too big the data is\n",
        "      stored into some remaining holes of SMALL_GROUP_LIB at\n",
        "      Primes[ p + 10 ].\n" );
    return rec( description := str, ranges := [ ],
                comment := NormalizedWhitespace( str ) );
end;

#############################################################################
##
#F  SMALL_GROUPS_INFORMATION[ ... ]( size, smav, num )
##
##  the entries for the layers of this package, printing what the
##  corresponding entries of 'SMALL_GROUPS_INFORMATION_RECORDS' return
Perform( [ 1 .. Length( SMALL_GROUPS_INFORMATION_RECORDS ) ], function( f )
    if IsBound( SMALL_GROUPS_INFORMATION_RECORDS[ f ] ) then
        SMALL_GROUPS_INFORMATION[ f ] := function( size, smav, num )
            local r;
            r := SMALL_GROUPS_INFORMATION_RECORDS[ f ]( size, smav, num );
            Print( r.description );
            if IsBound( r.indexed ) then
                SMALL_GROUPS_PRINT_INDEXED( r.indexed );
            fi;
        end;
    fi;
end );
