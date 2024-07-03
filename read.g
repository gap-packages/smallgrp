#
# GAP small groups library
#
ReadPackage("smallgrp", "gap/small.gi");

# read the 3-primes-order stuff, which is placed in the 'small'-directory
ReadPackage( "smallgrp", "gap/smlgp1.g" );
ReadPackage( "smallgrp", "gap/idgrp1.g" );

# read the information function
ReadPackage( "smallgrp", "gap/smlinfo.gi" );

# read the function-files of the small groups library
READ_SMALL_LIB := function()
    local i, s, LoadFunc;

    LoadFunc := path ->
                function(args...)
                    local relpath, filename;
                    relpath := Concatenation(path, "/", args[1]);
                    filename:= Filename( DirectoriesPackageLibrary( "smallgrp", "" ), relpath );
                    if filename <> fail and IsReadableFile( filename ) then
                      Read( filename );
                      return true;
                    else
                      return false;
                    fi;
                end;
    s := 1;
    repeat
        s := s + 1;
        # These functions are used in ReadSmallLib to load data on demand
        READ_SMALL_FUNCS[s] := LoadFunc(Concatenation("small", String(s)));
        READ_SMALL_FUNCS[s]( Concatenation( "smlgp", String(s), ".g" ),
                             Concatenation( "small groups #", String( s ) ) );
    until not IsBound( SMALL_AVAILABLE_FUNCS[ s ] );

    for i in [ 2 .. Length( SMALL_AVAILABLE_FUNCS ) ] do
        # These functions are used in ReadSmallLib to load data on demand
        READ_IDLIB_FUNCS[ i ] := LoadFunc(Concatenation("id", String(i)));
        READ_IDLIB_FUNCS[ i ]( Concatenation( "idgrp", String( i ), ".g" ),
                               Concatenation( "ids of groups #", String( i ) ) );
    od;
end;
READ_SMALL_LIB();
Unbind( READ_SMALL_LIB );
