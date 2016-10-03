#############################################################################
##
#W  read.g
##
##  GAP small groups library
##

ReadPackage("smallgrp", "gap/utils.gd");
ReadPackage("smallgrp", "gap/small.gi");

#############################################################################
##
#V  READ_SMALL_FUNCS[ ]
##
READ_SMALL_FUNCS := [ ];

#############################################################################
##
#V  READ_IDLIB_FUNCS[ ]
##
READ_IDLIB_FUNCS := [ ];

#############################################################################
##
#X  read the 3-primes-order stuff, which is placed in the 'small'-directory
##
ReadPackage( "smallgrp", "smlgp1.g" );
ReadPackage( "smallgrp", "idgrp1.g" );

#############################################################################
##
#X  read the information function
##
ReadPackage( "smallgrp", "smlinfo.gi" );

#############################################################################
##
#X   read the function-files of the small groups library
##
READ_SMALL_LIB := function()
    local i, s;

    s := 1;
    repeat
        s := s + 1;
        READ_SMALL_FUNCS[ s ] := ReadAndCheckFunc(
                               Concatenation( "small/small", String( s ) ) );
        READ_SMALL_FUNCS[ s ]( Concatenation( "smlgp", String( s ), ".g" ),
                           Concatenation( "small groups #", String( s ) ) );
    until not IsBound( SMALL_AVAILABLE_FUNCS[ s ] );

    for i in [ 2 .. Length( SMALL_AVAILABLE_FUNCS ) ] do
        READ_IDLIB_FUNCS[ i ] := ReadAndCheckFunc(
                               Concatenation( "small/id", String( i ) ) );
        READ_IDLIB_FUNCS[ i ]( Concatenation( "idgrp", String( i ), ".g" ),
                           Concatenation( "ids of groups #", String( i ) ) );
    od;
end;

READ_SMALL_LIB();

Unbind( READ_SMALL_LIB );
