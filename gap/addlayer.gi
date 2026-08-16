#############################################################################
##
#W  addlayer.gi              GAP group library                       Max Horn
##
##  Layers added from outside this package.
##

#############################################################################
##
#V  SMALL_GROUPS_LAYERS
##
##  the layers registered by 'SmallGroupsAddLayer', keyed by name.
SMALL_GROUPS_LAYERS := rec();

#############################################################################
##
#F  SMALL_GROUPS_LAYER_ORDER( layers )
##
##  <layers> in an order meeting every 'before' and 'after' wish, taking at
##  each step the earliest registered of those not waiting on another. A wish
##  naming a layer that is not registered is ignored, so wishing about a
##  package that is not loaded does no harm.
SMALL_GROUPS_LAYER_ORDER := function( layers )
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
#F  SMALL_GROUPS_LAYER_INSTALL( order )
##
##  puts the registered layers into consecutive slots, in the given order,
##  behind every layer added the old way. Registering one layer thus never
##  moves another across a slot this function did not hand out.
SMALL_GROUPS_LAYER_INSTALL := function( order )
    local ours, base, i, layer;

    ours := Set( order, l -> l.lib );
    base := Maximum( Concatenation( [ 0 ],
                Filtered( [ 1 .. Length( SMALL_AVAILABLE_FUNCS ) ],
                          i -> IsBound( SMALL_AVAILABLE_FUNCS[ i ] )
                               and not i in ours ) ) );
    for i in ours do
        Unbind( SMALL_AVAILABLE_FUNCS[ i ] );
        Unbind( ID_AVAILABLE_FUNCS[ i ] );
    od;

    for i in [ 1 .. Length( order ) ] do
        layer := order[ i ];
        layer.lib := base + i;
        SMALL_AVAILABLE_FUNCS[ layer.lib ] := layer.smallAvailable;
        if IsBound( layer.id ) then
            ID_AVAILABLE_FUNCS[ layer.lib ] := layer.smallAvailable;
        fi;
    od;
end;

#############################################################################
##
#F  SmallGroupsAddLayer( desc )
##
InstallGlobalFunction( SmallGroupsAddLayer, function( desc )
    local known, comp, layer, layers, order;

    if not IsRecord( desc ) then
        Error( "<desc> must be a record" );
    fi;

    known := [ "name", "available", "group", "id", "information", "number",
               "select", "count", "before", "after" ];
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
    for comp in [ "available", "group", "id", "information", "number",
                  "select", "count" ] do
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

    layer := ShallowCopy( desc );
    for comp in [ "before", "after" ] do
        if not IsBound( layer.( comp ) ) then
            layer.( comp ) := [ ];
        fi;
    od;
    layer.seq := Length( RecNames( SMALL_GROUPS_LAYERS ) ) + 1;
    layer.lib := Length( SMALL_AVAILABLE_FUNCS ) + 1;
    layer.func := Maximum( List( [ SMALL_GROUP_FUNCS,
                                   CODE_SMALL_GROUP_FUNCS,
                                   NUMBER_SMALL_GROUPS_FUNCS,
                                   SELECT_SMALL_GROUPS_FUNCS,
                                   COUNT_SMALL_GROUPS_FUNCS,
                                   SMALL_GROUPS_PROPERTIES_FUNCS,
                                   SMALL_GROUPS_INFORMATION,
                                   ID_GROUP_FUNCS ], Length ) ) + 1;

    # the layer never sees 'lib' or 'func', so its own record is passed on
    # with both filled in
    layer.smallAvailable := function( size )
        local r;
        r := layer.available( size );
        if r = fail then
            return fail;
        elif not IsRecord( r ) then
            Error( "the 'available' function of layer ", layer.name,
                   " must return 'fail' or a record" );
        fi;
        r := ShallowCopy( r );
        r.lib := layer.lib;
        r.func := layer.func;
        return r;
    end;

    # settle the order before anything is written, so a rejected wish leaves
    # the library as it was
    layers := List( RecNames( SMALL_GROUPS_LAYERS ),
                    n -> SMALL_GROUPS_LAYERS.( n ) );
    SortBy( layers, l -> l.seq );
    Add( layers, layer );
    order := SMALL_GROUPS_LAYER_ORDER( layers );

    SMALL_GROUP_FUNCS[ layer.func ] := layer.group;
    if IsBound( layer.id ) then
        ID_GROUP_FUNCS[ layer.func ] := layer.id;
    fi;
    if IsBound( layer.number ) then
        NUMBER_SMALL_GROUPS_FUNCS[ layer.func ] := function( size, inforec )
            inforec := ShallowCopy( inforec );
            inforec.number := layer.number( size, inforec );
            return inforec;
        end;
    fi;
    if IsBound( layer.select ) then
        SELECT_SMALL_GROUPS_FUNCS[ layer.func ] := layer.select;
    else
        SELECT_SMALL_GROUPS_FUNCS[ layer.func ] := SMALL_GROUPS_SELECT_GENERIC;
        COUNT_SMALL_GROUPS_FUNCS[ layer.func ] := SMALL_GROUPS_COUNT_GENERIC;
    fi;
    if IsBound( layer.count ) then
        COUNT_SMALL_GROUPS_FUNCS[ layer.func ] := layer.count;
    fi;
    if IsBound( layer.information ) then
        SMALL_GROUPS_INFORMATION[ layer.func ] := layer.information;
    else
        SMALL_GROUPS_INFORMATION[ layer.func ] := ReturnTrue;
    fi;

    SMALL_GROUPS_LAYERS.( layer.name ) := layer;
    SMALL_GROUPS_LAYER_INSTALL( order );
end );
