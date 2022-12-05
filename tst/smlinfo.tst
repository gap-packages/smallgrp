# Test file by Wilf A. Wilson
#
gap> START_TEST("smlinfo.tst");

# SMALL_GROUPS_INFORMATION
gap> Length(SMALL_GROUPS_INFORMATION) >= 26;
true
gap> Number(SMALL_GROUPS_INFORMATION) >= 21;
true
gap> ForAll(SMALL_GROUPS_INFORMATION, IsFunction);
true
gap> Filtered([1 .. 26],
>             i -> not IsBound(SMALL_GROUPS_INFORMATION[i]));
[ 13, 15, 16, 22, 23 ]

# SmallGroupsInformation, errors
gap> SmallGroupsInformation();
Error, Function: number of arguments must be 1 (not 0)
gap> SmallGroupsInformation(-1);
Error, usage: SmallGroupsInformation( size )
gap> SmallGroupsInformation(0);
Error, usage: SmallGroupsInformation( size )

# SmallGroupsInformation, not available
gap> SmallGroupsInformation(1024);
The groups of size 1024 are not available. 
gap> SmallGroupsInformation(4000);
The groups of size 4000 are not available. 

# SmallGroupsInformation, examples with func = 1
gap> SmallGroupsInformation(1);

  There is 1 group of order 1.

  The groups whose order factorises in at most 3 primes 
  have been classified by O. Hoelder. This classification is 
  used in the SmallGroups library. 

  This size belongs to layer 1 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(16);

  There are 14 groups of order 16.
  They are sorted by their ranks. 
     1 is cyclic. 
     2 - 9 have rank 2.
     10 - 13 have rank 3.
     14 is elementary abelian. 

  For the selection functions the values of the following attributes 
  are precomputed and stored:
     IsAbelian, PClassPGroup, RankPGroup, FrattinifactorSize and 
     FrattinifactorId. 

  This size belongs to layer 2 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(4);

  There are 2 groups of order 4.

  The groups whose order factorises in at most 3 primes 
  have been classified by O. Hoelder. This classification is 
  used in the SmallGroups library. 

  This size belongs to layer 1 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(6);

  There are 2 groups of order 6.

  The groups whose order factorises in at most 3 primes 
  have been classified by O. Hoelder. This classification is 
  used in the SmallGroups library. 

  This size belongs to layer 1 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 4
gap> SmallGroupsInformation(8);

  There are 5 groups of order 8.

  The groups whose order factorises in at most 3 primes 
  have been classified by O. Hoelder. This classification is 
  used in the SmallGroups library. 

  This size belongs to layer 1 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 5
gap> SmallGroupsInformation(12);

  There are 5 groups of order 12.

  The groups whose order factorises in at most 3 primes 
  have been classified by O. Hoelder. This classification is 
  used in the SmallGroups library. 

  This size belongs to layer 1 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 6
gap> SmallGroupsInformation(18);

  There are 5 groups of order 18.

  The groups whose order factorises in at most 3 primes 
  have been classified by O. Hoelder. This classification is 
  used in the SmallGroups library. 

  This size belongs to layer 1 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 7
gap> SmallGroupsInformation(30);

  There are 4 groups of order 30.

  The groups whose order factorises in at most 3 primes 
  have been classified by O. Hoelder. This classification is 
  used in the SmallGroups library. 

  This size belongs to layer 1 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 8
gap> SmallGroupsInformation(64);

  There are 267 groups of order 64.
  They are sorted by their ranks. 
     1 is cyclic. 
     2 - 54 have rank 2.
     55 - 191 have rank 3.
     192 - 259 have rank 4.
     260 - 266 have rank 5.
     267 is elementary abelian. 

  For the selection functions the values of the following attributes 
  are precomputed and stored:
     IsAbelian, PClassPGroup, RankPGroup, FrattinifactorSize and 
     FrattinifactorId. 

  This size belongs to layer 2 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(96);

  There are 231 groups of order 96.
  They are sorted by their Frattini factors. 
     1 has Frattini factor [ 6, 1 ].
     2 has Frattini factor [ 6, 2 ].
     3 has Frattini factor [ 12, 3 ].
     4 - 44 have Frattini factor [ 12, 4 ].
     45 - 63 have Frattini factor [ 12, 5 ].
     64 - 67 have Frattini factor [ 24, 12 ].
     68 - 74 have Frattini factor [ 24, 13 ].
     75 - 160 have Frattini factor [ 24, 14 ].
     161 - 184 have Frattini factor [ 24, 15 ].
     185 - 195 have Frattini factor [ 48, 48 ].
     196 - 202 have Frattini factor [ 48, 49 ].
     203 - 204 have Frattini factor [ 48, 50 ].
     205 - 219 have Frattini factor [ 48, 51 ].
     220 - 225 have Frattini factor [ 48, 52 ].
     226 - 231 have trivial Frattini subgroup.

  For the selection functions the values of the following attributes 
  are precomputed and stored:
     IsAbelian, IsNilpotentGroup, IsSupersolvableGroup, IsSolvableGroup, 
     LGLength, FrattinifactorSize and FrattinifactorId. 

  This size belongs to layer 2 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 10
gap> SmallGroupsInformation(256);

  There are 56092 groups of order 256.
  They are sorted by their ranks. 
     1 is cyclic. 
     2 - 541 have rank 2.
     542 - 6731 have rank 3.
     6732 - 26972 have rank 4.
     26973 - 55625 have rank 5.
     55626 - 56081 have rank 6.
     56082 - 56091 have rank 7.
     56092 is elementary abelian. 

  For the selection functions the values of the following attributes 
  are precomputed and stored:
     IsAbelian, PClassPGroup, RankPGroup, FrattinifactorSize and 
     FrattinifactorId. 

  This size belongs to layer 2 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 11
gap> SmallGroupsInformation(768);

  There are 1090235 groups of order 768.
  They are sorted by normal Sylow subgroups. 
     1 - 56092 are the nilpotent groups.
     56093 - 1083472 have a normal Sylow 3-subgroup 
                     with centralizer of index 2.
     1083473 - 1085323 have a normal Sylow 2-subgroup. 
     1085324 - 1090235 have no normal Sylow subgroup. 

  This size belongs to layer 3 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 12
gap> SmallGroupsInformation(1152);

  There are 157877 groups of order 1152.
  They are sorted using Sylow subgroups. 
     1 - 2328 are nilpotent with Sylow 3-subgroup c9.
     2329 - 4656 are nilpotent with Sylow 3-subgroup 3^2.
     4657 - 153312 are non-nilpotent with normal Sylow 3-subgroup.
     153313 - 157877 have no normal Sylow 3-subgroup.

  This size belongs to layer 6 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(1920);

  There are 241004 groups of order 1920.
  They are sorted using Hall subgroups. 
     1 - 2328 are the nilpotent groups.
     2329 - 236344 have a normal Hall (3,5)-subgroup.
     236345 - 240416 are solvable without normal Hall (3,5)-subgroup.
     240417 - 241004 are not solvable.

  This size belongs to layer 6 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 14
gap> SmallGroupsInformation(1536);

  There are 408641062 groups of order 1536.
     1 - 10494213 are the nilpotent groups.
     10494214 - 408526597 have a normal Sylow 3-subgroup.
     408526598 - 408544625 have a normal Sylow 2-subgroup.
     408544626 - 408641062 have no normal Sylow subgroup.

  This size belongs to layer 8 of the SmallGroups library. 
  IdSmallGroup is not available for this size. 
 

# SmallGroupsInformation, examples with func = 17
gap> SmallGroupsInformation(1029);

  There are 19 groups of order 1029.
  They are sorted by normal Sylow subgroups. 
     1 - 5 are the nilpotent groups.
     6 - 19 have a normal Sylow 7-subgroup. 

  This size belongs to layer 4 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 18
gap> SmallGroupsInformation(512);

  There are 10494213 groups of order 512.
     1 is cyclic. 
     2 - 10 have rank 2 and p-class 3.
     11 - 386 have rank 2 and p-class 4.
     387 - 444 have rank 2 and p-class 5.
     445 - 858 have rank 2 and p-class 4.
     859 - 1698 have rank 2 and p-class 5.
     1699 - 2008 have rank 2 and p-class 6.
     2009 - 2039 have rank 2 and p-class 7.
     2040 - 2044 have rank 2 and p-class 8.
     2045 has rank 3 and p-class 2.
     2046 - 29398 have rank 3 and p-class 3.
     29399 - 30617 have rank 3 and p-class 4.
     30618 - 31239 have rank 3 and p-class 3.
     31240 - 56685 have rank 3 and p-class 4.
     56686 - 60615 have rank 3 and p-class 5.
     60616 - 60894 have rank 3 and p-class 6.
     60895 - 60903 have rank 3 and p-class 7.
     60904 - 67612 have rank 4 and p-class 2.
     67613 - 387088 have rank 4 and p-class 3.
     387089 - 419734 have rank 4 and p-class 4.
     419735 - 420500 have rank 4 and p-class 5.
     420501 - 420514 have rank 4 and p-class 6.
     420515 - 6249623 have rank 5 and p-class 2.
     6249624 - 7529606 have rank 5 and p-class 3.
     7529607 - 7532374 have rank 5 and p-class 4.
     7532375 - 7532392 have rank 5 and p-class 5.
     7532393 - 10481221 have rank 6 and p-class 2.
     10481222 - 10493038 have rank 6 and p-class 3.
     10493039 - 10493061 have rank 6 and p-class 4.
     10493062 - 10494173 have rank 7 and p-class 2.
     10494174 - 10494200 have rank 7 and p-class 3.
     10494201 - 10494212 have rank 8 and p-class 2.
     10494213 is elementary abelian.

  This size belongs to layer 7 of the SmallGroups library. 
  IdSmallGroup is not available for this size. 
 
gap> SmallGroupsInformation(14641);

  There are 15 groups of order 14641.
  They are sorted by their ranks. 
     1 is cyclic. 
     2 - 10 have rank 2. 
     11 - 14 have rank 3. 
     15 is elementary abelian. 

  This size belongs to layer 9 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 20
gap> SmallGroupsInformation(16807);

  There are 83 groups of order 16807.
  They are sorted by their ranks.
     1 is cyclic.
     2 - 42 have rank 2. 
     43 - 76 have rank 3. 
     77 - 82 have rank 4. 
     83 is elementary abelian. 

  This size belongs to layer 9 of the SmallGroups library. 
  IdSmallGroup is not available for this size. 
 

# SmallGroupsInformation, examples with func = 21
gap> SmallGroupsInformation(15625);

  There are 684 groups of order 15625.
 
      Easterfield (1940) constructed a list of the groups of
      order p^6 for p >= 5.
 
      The database of parametrised presentations for the groups 
      with order p^6 for p >= 5 is based on the Easterfield 
      list, corrected by Newman, O'Brien and Vaughan-Lee (2004).
      It differs only in the addition of groups in isoclinism 
      family $\Phi_{13}$, in using the James (1980) presentations 
      for the groups in $\Phi_{19}$, and a small number of 
      typographical amendments. The linear ordering employed is 
      very close to that of Easterfield. 
 
      Each group with order $p^6$ is described by a power- 
      commutator presentation on 6 generators and 21 relations:
      15 are commutator relations and 6 are power relations. 
      Each presentation has the prime $p$ as a parameter. 
      The database contains about 500 parametrised 
      presentations, most of these have $p$ as the only 
      parameter. 

  This size belongs to layer 9 of the SmallGroups library. 
  IdSmallGroup is not available for this size. 
 

# SmallGroupsInformation, examples with func = 24
gap> SmallGroupsInformation(2002);

  There are 8 groups of order 2002.

  The groups of squarefree order have a cyclic socle and a cyclic socle factor\
.

    1 is abelian
    2 - 8 have socle C_1001 and factor C_2

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(2010);

  There are 12 groups of order 2010.

  The groups of squarefree order have a cyclic socle and a cyclic socle factor\
.

    1 is abelian
    2 has socle C_670 and factor C_3
    3 - 9 have socle C_1005 and factor C_2
    10 - 12 have socle C_335 and factor C_6

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 25
gap> SmallGroupsInformation(2004);

  There are 10 groups of order 2004.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 - 4 are solvable with Frattini factor of size 1002
    5 - 10 are solvable and Frattini free

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(2028);

  There are 88 groups of order 2028.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 - 6 are solvable with Frattini factor of size 78
    7 - 18 are solvable with Frattini factor of size 156
    19 - 35 are solvable with Frattini factor of size 1014
    36 - 88 are solvable and Frattini free

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(2100);

  There are 165 groups of order 2100.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 - 12 are solvable with Frattini factor of size 210
    13 - 40 are solvable with Frattini factor of size 420
    41 - 68 are solvable with Frattini factor of size 1050
    69 - 164 are solvable and Frattini free
    165 is PSL( 2, 5 ) x F, F solvable and Frattini free of order 35

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(2115);

  There are 2 groups of order 2115.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 is solvable with Frattini factor of size 705
    2 is solvable and Frattini free

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(2340);

  There are 167 groups of order 2340.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 - 12 are solvable with Frattini factor of size 390
    13 - 52 are solvable with Frattini factor of size 780
    53 - 72 are solvable with Frattini factor of size 1170
    73 - 165 are solvable and Frattini free
    166 - 167 are PSL( 2, 5 ) x F_i, F_i solvable Frattini free of order 39

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(2940);

  There are 187 groups of order 2940.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 - 12 are solvable with Frattini factor of size 210
    13 - 40 are solvable with Frattini factor of size 420
    41 - 74 are solvable with Frattini factor of size 1470
    75 - 185 are solvable and Frattini free
    186 is PSL( 2, 5 ) x G, G solvable of order 49 with a Frattini factor
      of order 7
    187 is PSL( 2, 5 ) x F, F solvable and Frattini free of order 49

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(3420);

  There are 144 groups of order 3420.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 - 12 are solvable with Frattini factor of size 570
    13 - 40 are solvable with Frattini factor of size 1140
    41 - 64 are solvable with Frattini factor of size 1710
    65 - 141 are solvable and Frattini free
    142 - 143 are PSL( 2, 5 ) x F_i, F_i solvable Frattini free of order 57
    144 is PSL( 2, 19 )

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 
gap> SmallGroupsInformation(8820);

  There are 672 groups of order 8820.

  The groups of cubefree order are either solvable or a direct product of 
  the form PSL( 2, p ) x solvable group. The cubefree solvable groups are 
  determined by their Frattini factor.

    1 - 12 are solvable with Frattini factor of size 210
    13 - 40 are solvable with Frattini factor of size 420
    41 - 60 are solvable with Frattini factor of size 630
    61 - 129 are solvable with Frattini factor of size 1260
    130 - 163 are solvable with Frattini factor of size 1470
    164 - 274 are solvable with Frattini factor of size 2940
    275 - 344 are solvable with Frattini factor of size 4410
    345 - 666 are solvable and Frattini free
    667 - 668 are PSL( 2, 5 ) x G_i, G_i solvable of order 147 with a
      Frattini factor of order 21
    669 - 672 are PSL( 2, 5 ) x F_i, F_i solvable Frattini free of order 147

  This size belongs to layer 10 of the SmallGroups library. 
  IdSmallGroup is available for this size. 
 

# SmallGroupsInformation, examples with func = 26
gap> SmallGroupsInformation(2187);

  There are 9310 groups of order 2187.
 
      E.A. O'Brien and M.R. Vaughan-Lee determined presentations
      of the groups with order p^7. A preprint of their paper is
      available at
      http://www.math.auckland.ac.nz/%7Eobrien/research/p7/paper-p7.pdf

      For p in { 3, 5, 7, 11 } explicit lists of groups of order
      p^7 have been produced and stored into the database.

      Giving the power commutator presentations of any of these
      groups using a standard notation they might be reduced to 35
      elements of the group or a 245 p-digit number.

      Only 56 of these digits may be unlike 0 for any group and
      even these 56 digits are mostly like 0. Further on these
      digits are often quite likely for sequences of subsequent
      groups. Thus storage of groups was done by finding a so
      called head group and a so called tail. Along the tail
      only the different digits compared to the head are relevant.
      Even the tails occur more or less often and this is used
      to improve storage too. Since p^7 is too big the data is
      stored into some remaining holes of SMALL_GROUP_LIB at
      Primes[ p + 10 ].

  This size belongs to layer 11 of the SmallGroups library. 
  IdSmallGroup is not available for this size. 
 

#
gap> STOP_TEST("smlinfo.tst");
