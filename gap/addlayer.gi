#############################################################################
##
#W  addlayer.gi              GAP group library                       Max Horn
##
##  The layers of the library, and the API for adding more.
##

#############################################################################
##
#V  SMALL_GROUPS_LAYERS
##
##  every layer, keyed by name. 'SMALL_GROUPS_LAYER_LIST' holds the same
##  records in the order they are consulted.
SMALL_GROUPS_LAYERS := rec();

#############################################################################
##
#V  SMALL_GROUPS_LAYERS.SmallGrp
##
##  one layer standing for all those installed the old way, by filling
##  'SMALL_AVAILABLE_FUNCS' and the other global arrays it reads below: the
##  layers built into this package, and any a package adds that way.
SMALL_GROUPS_LAYERS.SmallGrp := rec(
    name := "SmallGrp",
    before := [ ],
    after := [ ],

    available := function( size )
        local l, r;
        for l in [ 1 .. Length( SMALL_AVAILABLE_FUNCS ) ] do
            if IsBound( SMALL_AVAILABLE_FUNCS[ l ] ) then
                r := SMALL_AVAILABLE_FUNCS[ l ]( size );
                if r <> fail then
                    return r;
                fi;
            fi;
        od;
        return fail;
    end,

    idAvailable := function( size )
        local l, r;
        for l in [ 1 .. Length( ID_AVAILABLE_FUNCS ) ] do
            if IsBound( ID_AVAILABLE_FUNCS[ l ] ) then
                r := ID_AVAILABLE_FUNCS[ l ]( size );
                if r <> fail then
                    return r;
                fi;
            fi;
        od;
        return fail;
    end,

    group := function( size, i, inforec )
        return SMALL_GROUP_FUNCS[ inforec.func ]( size, i, inforec );
    end,

    id := function( G, inforec )
        return ID_GROUP_FUNCS[ inforec.func ]( G, inforec );
    end,

    numberOf := function( size, inforec )
        return NUMBER_SMALL_GROUPS_FUNCS[ inforec.func ]( size, inforec );
    end,

    properties := function( size, inforec )
        if not IsBound( SMALL_GROUPS_PROPERTIES_FUNCS[ inforec.func ] ) then
            return fail;
        fi;
        return SMALL_GROUPS_PROPERTIES_FUNCS[ inforec.func ]( size, inforec );
    end,

    select := function( size, funcs, vals, inforec, all, id, idList )
        return SELECT_SMALL_GROUPS_FUNCS[ inforec.func ]
                   ( size, funcs, vals, inforec, all, id, idList );
    end,

    count := function( size, funcs, vals, inforec, idList )
        if IsBound( COUNT_SMALL_GROUPS_FUNCS[ inforec.func ] ) then
            return COUNT_SMALL_GROUPS_FUNCS[ inforec.func ]
                       ( size, funcs, vals, inforec, idList );
        fi;
        return Length( SELECT_SMALL_GROUPS_FUNCS[ inforec.func ]
                           ( size, funcs, vals, inforec, true, true, idList ) );
    end,

    information := function( size, inforec, num )
        SMALL_GROUPS_INFORMATION[ inforec.func ]( size, inforec, num );
    end,
);

SMALL_GROUPS_LAYER_LIST[ 1 ] := SMALL_GROUPS_LAYERS.SmallGrp;

#############################################################################
##
#F  SMALL_GROUPS_SORT_LAYERS( layers )
##
##  <layers> in an order meeting every 'before' and 'after' wish, taking at
##  each step the earliest registered of those not waiting on another. A wish
##  naming a layer that is not registered is ignored, so wishing about a
##  package that is not loaded does no harm.
SMALL_GROUPS_SORT_LAYERS := function( layers )
    local names, pred, layer, other, order, done, next;

    names := List( layers, l -> l.name );
    pred := rec();
    for layer in layers do
        pred.( layer.name ) := [ ];
    od;
    for layer in layers do
        for other in layer.after do
            if other in names then
                AddSet( pred.( layer.name ), other );
            fi;
        od;
        for other in layer.before do
            if other in names then
                AddSet( pred.( other ), layer.name );
            fi;
        od;
    od;

    order := [ ];
    done  := [ ];
    while Length( order ) < Length( layers ) do
        next := First( layers, l -> not l.name in done and
                                    IsSubset( done, pred.( l.name ) ) );
        if next = fail then
            Error( "SmallGroupsAddLayer: the layers ",
                   JoinStringsWithSeparator(
                       Filtered( names, n -> not n in done ), ", " ),
                   " ask for an order that cannot be met" );
        fi;
        Add( order, next );
        AddSet( done, next.name );
    od;
    return order;
end;

#############################################################################
##
#F  SmallGroupsAddLayer( desc )
##
InstallGlobalFunction( SmallGroupsAddLayer, function( desc )
    local known, comp, layer, order;

    if not IsRecord( desc ) then
        Error( "<desc> must be a record" );
    fi;

    known := [ "name", "available", "group", "id", "idAvailable", "number",
               "properties", "information", "select", "count",
               "before", "after" ];
    for comp in RecNames( desc ) do
        if not comp in known then
            Error( "unknown component <desc>.", comp );
        fi;
    od;
    for comp in [ "name", "available", "group" ] do
        if not IsBound( desc.( comp ) ) then
            Error( "<desc>.", comp, " must be given" );
        fi;
    od;
    if not IsString( desc.name ) or IsEmpty( desc.name ) then
        Error( "<desc>.name must be a non-empty string" );
    fi;
    if IsBound( SMALL_GROUPS_LAYERS.( desc.name ) ) then
        Error( "a layer named \"", desc.name, "\" is already registered" );
    fi;
    for comp in [ "available", "group", "id", "idAvailable", "number",
                  "properties", "information", "select", "count" ] do
        if IsBound( desc.( comp ) ) and not IsFunction( desc.( comp ) ) then
            Error( "<desc>.", comp, " must be a function" );
        fi;
    od;
    for comp in [ "before", "after" ] do
        if IsBound( desc.( comp ) ) and
           not ( IsList( desc.( comp ) ) and ForAll( desc.( comp ), IsString ) )
          then
            Error( "<desc>.", comp, " must be a list of layer names" );
        fi;
    od;
    if IsBound( desc.idAvailable ) and not IsBound( desc.id ) then
        Error( "<desc>.idAvailable is of no use without <desc>.id" );
    fi;

    layer := ShallowCopy( desc );
    for comp in [ "before", "after" ] do
        if not IsBound( layer.( comp ) ) then
            layer.( comp ) := [ ];
        fi;
    od;

    # what the layer hands back is checked once, here, rather than wherever
    # it later turns out not to be a record
    layer.available := function( size )
        local r;
        r := desc.available( size );
        if r <> fail and not IsRecord( r ) then
            Error( "the 'available' function of layer ", layer.name,
                   " must return 'fail' or a record" );
        fi;
        return r;
    end;
    if IsBound( layer.id ) and not IsBound( layer.idAvailable ) then
        layer.idAvailable := layer.available;
    fi;

    # a layer reports a number, the library carries it in the record
    if IsBound( desc.number ) then
        layer.numberOf := function( size, inforec )
            inforec := ShallowCopy( inforec );
            inforec.number := desc.number( size, inforec );
            return inforec;
        end;
    else
        layer.numberOf := function( size, inforec )
            Error( "layer ", layer.name, " reports no number of groups of ",
                   "order ", size );
        end;
    fi;

    # a layer that selects for itself is not counted generically
    if not IsBound( layer.select ) then
        layer.select := SMALL_GROUPS_SELECT_GENERIC;
        if not IsBound( layer.count ) then
            layer.count := SMALL_GROUPS_COUNT_GENERIC;
        fi;
    fi;
    if not IsBound( layer.information ) then
        layer.information := ReturnTrue;
    fi;

    # settle the order before anything is written, so a rejected wish leaves
    # the library as it was
    order := SMALL_GROUPS_SORT_LAYERS(
                 Concatenation( SMALL_GROUPS_LAYER_LIST, [ layer ] ) );

    SMALL_GROUPS_LAYERS.( layer.name ) := layer;
    SMALL_GROUPS_LAYER_LIST := order;
end );
