#############################################################################
##
#W  read.g
##
##  GAP small groups library
##

ReadPackage("smallgrp", "gap/utils.gi");
ReadPackage("smallgrp", "gap/small.gi");


#############################################################################
##
#X  read the 3-primes-order stuff, which is placed in the 'small'-directory
##
ReadPackage( "smallgrp", "gap/smlgp1.g" );
ReadPackage( "smallgrp", "gap/idgrp1.g" );

#############################################################################
##
#X  read the information function
##
ReadPackage( "smallgrp", "gap/smlinfo.gi" );

#############################################################################
##
#X   read the function-files of the small groups library
##
READ_SMALL_LIB := function()
    local i, s, path;

    s := 1;
    repeat
        s := s + 1;
        path := DirectoriesPackageLibrary("smallgrp",
                                          Concatenation("small", String(s)));
        if path <> [] then
            # These functions are used in ReadSmallLib to load data on demand
            READ_SMALL_FUNCS[s] := ReadAndCheckFunc(Filename(path, ""));
            READ_SMALL_FUNCS[s]( Concatenation( "smlgp", String( s ), ".g" ),
                                 Concatenation( "small groups #", String( s ) ) );
        fi;
    until not IsBound( SMALL_AVAILABLE_FUNCS[ s ] );

    for i in [ 2 .. Length( SMALL_AVAILABLE_FUNCS ) ] do
        path := DirectoriesPackageLibrary("smallgrp",
                                          Concatenation("id", String(i)));
        if path <> [] then
            # These functions are used in ReadSmallLib to load data on demand
            READ_IDLIB_FUNCS[ i ] := ReadAndCheckFunc(Filename(path, ""));
            READ_IDLIB_FUNCS[ i ]( Concatenation( "idgrp", String( i ), ".g" ),
                                   Concatenation( "ids of groups #", String( i ) ) );
        fi;
    od;
end;

READ_SMALL_LIB();

Unbind( READ_SMALL_LIB );
