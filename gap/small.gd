#############################################################################
##
#W  small.gd                 GAP group library             Hans Ulrich Besche
##                                               Bettina Eick, Eamonn O'Brien
##

DeclareInfoClass( "InfoIdgroup" );

##  <#GAPDoc Label="SMALL_GROUPS_OLD_ORDER">
##  <ManSection>
##  <Var Name="SMALL_GROUPS_OLD_ORDER"/>
##
##  <Description>
##  If set to <C>true</C>, then groups of order <M>3^7</M>, <M>5^7</M>,
##  <M>7^7</M>, and <M>11^7</M> are ordered in the way they were
##  ordered up to version 1.0 of the package. If this variable is
##  set to <C>false</C>, which is the default as of version 1.4,
##  then a different ordering, that agrees with the one in Magma version
##  2.23, is used.
##  The functions <C>SMALLGP_PERM</C><M>x</M>, with <M>x=3,5,7,11</M>, give
##  the old index position corresponding to a new index position.
##  In releases 1.1-1.3 a misunderstood ordering, based on the old ordering
##  and the permutations <M>(2,30083)(3,30084)(4,30085)(5,30086)</M>,
##  <M>(2,104599)(3,104600)(4,104601)(5,104602)</M>, and
##  <M>(2,721053)(3,721054)(4,721055)(5,721059)</M> respectively
##  were used.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
SMALL_GROUPS_OLD_ORDER := false;

# permutations
# AH: These are based on comparison with a list from Magma
BindGlobal("SMALLGP_PERM3",function(i)
  if i>7222 and i<7227 then return 14449-i;
  else return i;fi;
end);;

BindGlobal("SMALLGP_PERM5",function(i)
local k;
  if i=1 then return 1;
  elif i<6 then return i+30081;
  elif i<4156 then return i-4;
  elif i<4163 then return i+21;
  elif i<4171 then return i+36;
  elif i<4179 then return i+16;
  elif i<4198 then return i+53;
  elif i<4202 then return i-3;
  elif i<4212 then return i+65;
  elif i<4237 then return i-60;
  elif i<4243 then return i+24;
  elif i<4246 then return i-59;
  elif i<4256 then return i+5;
  elif i<4281 then return i-49;
  elif i<4299 then return i-4;
  elif i<4308 then return i+21;
  elif i<4323 then return i+37;
  elif i<4331 then return i+9;
  elif i<4361 then return i+54;
  elif i<4366 then return i-21;
  elif i<4406 then return i+95;
  elif i<4431 then return i-111;
  elif i<4437 then return i+24;
  elif i<4440 then return i-108;
  elif i<4455 then return i-25;
  elif i<4480 then return i-95;
  elif i<4505 then return i-50;
  elif i<30075 then return i-4;
  elif i<30087 then 
    k:=[30082, 30077, 30076, 30080, 30081, 30073,
        30079, 30072, 30074, 30071, 30078, 30075];
    return k[i-30074];
  elif i<30454 then return i+0;
  elif i<30455 then return i+15;
  elif i<30456 then return i+133;
  elif i<30482 then return i+36;
  elif i<30497 then return i-28;
  elif i<30498 then return i-23;
  elif i<30499 then return i-27;
  elif i<30539 then return i+49;
  elif i<30546 then 
    k:=[ 30534, 30600, 30472, 30599, 30470, 30518, 30536 ];
    return k[i-30538];
  elif i<30561 then return i-69;
  elif i<30562 then return i-88;
  elif i<30572 then return i+27;
  elif i<30573 then return i-37;
  elif i<30583 then return i-35;
  elif i<30584 then return i-46;
  elif i<30586 then return i-109;
  elif i<30601 then return i-67;
  elif i<30636 then return i+0;
  elif i<30640 then 
    k:=[ 30727, 30655, 30724, 30726 ];
    return k[i-30635];
  elif i<30656 then return i+43;
  elif i<30657 then return i-20;
  elif i<30682 then return i-1;
  elif i<30683 then return i-30;
  elif i<30684 then return i+45;
  elif i<30699 then return i-47;
  elif i<30700 then return i+26;
  elif i<30701 then return i-46;
  elif i<30726 then return i-2;
  elif i<30727 then return i-44;
  elif i<30728 then return i-46;
  elif i<30729 then return i-75;
  elif i<34298 then return i;
  else Error("invalid parameter");fi;
end);

BindGlobal("SMALLGP_PERM7",function(i)
  if i<2 then return i;
  elif i<6 then return i+104597;
  elif i<8925 then return i-4;
  elif i<8974 then return i+13;
  elif i<8984 then return i+60;
  elif i<8996 then return i+38;
  elif i<9004 then return i+107;
  elif i<9014 then return i+40;
  elif i<9028 then return i+97;
  elif i<9045 then return i-41;
  elif i<9049 then return i-121;
  elif i<9098 then return i+5;
  elif i<9101 then return i-177;
  elif i<9111 then return i-173;
  elif i<9125 then return i-103;
  elif i<9129 then return i-121;
  elif i<9132 then return i+213;
  elif i<9149 then return i+502;
  elif i<9155 then return i+178;
  elif i<9158 then return i-30;
  elif i<9207 then return i+232;
  elif i<9235 then return i-73;
  elif i<9244 then return i-14;
  elif i<9293 then return i+244;
  elif i<9321 then return i-63;
  elif i<9327 then return i-193;
  elif i<9337 then return i-116;
  elif i<9354 then return i-27;
  elif i<9382 then return i+235;
  elif i<9431 then return i+57;
  elif i<9440 then return i-98;
  elif i<9489 then return i-278;
  elif i<9492 then return i+48;
  elif i<9500 then return i+134;
  elif i<9549 then return i+40;
  elif i<9552 then return i-242;
  elif i<9601 then return i-294;
  elif i<9610 then return i+16;
  elif i<9655 then return i-265;
  elif i<104579 then return i-4;
  elif i<104580 then return i+6;
  elif i<104581 then return i+8;
  elif i<104582 then return i+5;
  elif i<104583 then return i+12;
  elif i<104584 then return i+10;
  elif i<104585 then return i-7;
  elif i<104586 then return i-6;
  elif i<104587 then return i-3;
  elif i<104588 then return i+5;
  elif i<104589 then return i+1;
  elif i<104590 then return i-8;
  elif i<104591 then return i+1;
  elif i<104592 then return i+5;
  elif i<104593 then return i-12;
  elif i<104594 then return i-11;
  elif i<104595 then return i-16;
  elif i<104596 then return i-11;
  elif i<104597 then return i-6;
  elif i<104598 then return i-22;
  elif i<104599 then return i-11;
  elif i<104600 then return i-23;
  elif i<104601 then return i-5;
  elif i<104602 then return i-3;
  elif i<104603 then return i-5;
  elif i<105124 then return i;
  elif i<105125 then return i+198;
  elif i<105174 then return i-1;
  elif i<105175 then return i+91;
  elif i<105224 then return i+95;
  elif i<105225 then return i+9;
  elif i<105226 then return i-51;
  elif i<105275 then return i-44;
  elif i<105276 then return i-13;
  elif i<105277 then return i-8;
  elif i<105278 then return i+43;
  elif i<105279 then return i-47;
  elif i<105280 then return i-99;
  elif i<105281 then return i+39;
  elif i<105282 then return i-49;
  elif i<105283 then return i-103;
  elif i<105284 then return i-106;
  elif i<105285 then return i-109;
  elif i<105313 then return i+38;
  elif i<105314 then return i-47;
  elif i<105315 then return i-50;
  elif i<105316 then return i+6;
  elif i<105317 then return i-49;
  elif i<105318 then return i-136;
  elif i<105319 then return i-142;
  elif i<105320 then return i-146;
  elif i<105321 then return i-57;
  elif i<105322 then return i-143;
  elif i<105350 then return i-88;
  elif i<105351 then return i-81;
  elif i<105432 then return i;
  elif i<105460 then return i+186;
  elif i<105461 then return i+89;
  elif i<105489 then return i-28;
  elif i<105517 then return i+98;
  elif i<105518 then return i+66;
  elif i<105546 then return i-53;
  elif i<105547 then return i+102;
  elif i<105548 then return i+70;
  elif i<105549 then return i+98;
  elif i<105550 then return i+66;
  elif i<105551 then return i-4;
  elif i<105552 then return i+30;
  elif i<105553 then return i-120;
  elif i<105554 then return i+29;
  elif i<105603 then return i-57;
  elif i<105604 then return i+144;
  elif i<105605 then return i-57;
  elif i<105606 then return i-25;
  elif i<105607 then return i-143;
  elif i<105608 then return i+9;
  elif i<105609 then return i-112;
  elif i<105610 then return i-115;
  elif i<105611 then return i-45;
  elif i<105612 then return i-118;
  elif i<105613 then return i-117;
  elif i<105614 then return i+34;
  elif i<105626 then return i-64;
  elif i<105627 then return i-162;
  elif i<105628 then return i+121;
  elif i<105629 then return i-42;
  elif i<105630 then return i-67;
  elif i<105631 then return i-46;
  elif i<105680 then return i+67;
  elif i<105681 then return i-132;
  elif i<105730 then return i-32;
  elif i<105744 then return i-164;
  elif i<105745 then return i-159;
  elif i<105746 then return i-284;
  elif i<105748 then return i-183;
  elif i<105749 then return i-286;
  else return i; fi;
end);

BindGlobal("SMALLGP_PERM11",function(i)
  if i<2 then return i;
  elif i<6 then return i+721051;
  elif i<30273 then return i-4;
  elif i<30277 then return i+60;
  elif i<30299 then return i+20;
  elif i<30420 then return i+184;
  elif i<30424 then return i+211;
  elif i<30446 then return i-84;
  elif i<30449 then return i-109;
  elif i<30463 then return i+168;
  elif i<30477 then return i-144;
  elif i<30502 then return i-205;
  elif i<30516 then return i+145;
  elif i<30519 then return i-247;
  elif i<30532 then return i+85;
  elif i<30544 then return i+103;
  elif i<30665 then return i-182;
  elif i<30731 then return i+629;
  elif i<30852 then return i+376;
  elif i<30973 then return i+629;
  elif i<31094 then return i+698;
  elif i<31102 then return i+1223;
  elif i<31344 then return i+832;
  elif i<31410 then return i-116;
  elif i<31531 then return i+766;
  elif i<31652 then return i-867;
  elif i<31664 then return i+645;
  elif i<31785 then return i-678;
  elif i<31793 then return i+524;
  elif i<31914 then return i-433;
  elif i<32035 then return i-101;
  elif i<32056 then return i-243;
  elif i<32059 then return i-388;
  elif i<32073 then return i-1274;
  elif i<32076 then return i-1412;
  elif i<32142 then return i-1156;
  elif i<32263 then return i-1343;
  elif i<32329 then return i-661;
  elif i<720997 then return i-4;
  elif i<720998 then return i+20;
  elif i<720999 then return i-3;
  elif i<721000 then return i+4;
  elif i<721002 then return i+46;
  elif i<721003 then return i+40;
  elif i<721004 then return i+49;
  elif i<721005 then return i+36;
  elif i<721006 then return i+24;
  elif i<721007 then return i-10;
  elif i<721008 then return i+41;
  elif i<721009 then return i+33;
  elif i<721010 then return i-10;
  elif i<721011 then return i+21;
  elif i<721012 then return i-18;
  elif i<721013 then return i+31;
  elif i<721014 then return i+32;
  elif i<721015 then return i+20;
  elif i<721016 then return i;
  elif i<721017 then return i-19;
  elif i<721018 then return i+15;
  elif i<721019 then return i+9;
  elif i<721020 then return i-5;
  elif i<721021 then return i;
  elif i<721022 then return i+30;
  elif i<721023 then return i+2;
  elif i<721024 then return i-23;
  elif i<721025 then return i-2;
  elif i<721026 then return i-14;
  elif i<721027 then return i-25;
  elif i<721028 then return i+1;
  elif i<721029 then return i-15;
  elif i<721030 then return i-20;
  elif i<721031 then return i+7;
  elif i<721032 then return i-10;
  elif i<721033 then return i+17;
  elif i<721034 then return i-21;
  elif i<721035 then return i+5;
  elif i<721036 then return i-30;
  elif i<721037 then return i+14;
  elif i<721038 then return i+7;
  elif i<721039 then return i-31;
  elif i<721040 then return i-41;
  elif i<721041 then return i-5;
  elif i<721042 then return i-8;
  elif i<721043 then return i-17;
  elif i<721044 then return i-49;
  elif i<721045 then return i-8;
  elif i<721046 then return i-39;
  elif i<721047 then return i-42;
  elif i<721048 then return i-21;
  elif i<721049 then return i-29;
  elif i<721050 then return i-19;
  elif i<721051 then return i-48;
  elif i<721052 then return i-35;
  elif i<721053 then return i-14;
  elif i<721054 then return i-43;
  elif i<721055 then return i-36;
  elif i<721056 then return i-32;
  elif i<721057 then return i-48;
  elif i<722036 then return i;
  elif i<722037 then return i+790;
  elif i<722038 then return i+396;
  elif i<722039 then return i+658;
  elif i<722040 then return i+665;
  elif i<722041 then return i+371;
  elif i<722042 then return i+393;
  elif i<722043 then return i+387;
  elif i<722044 then return i+648;
  elif i<722165 then return i+245;
  elif i<722166 then return i+258;
  elif i<722167 then return i+528;
  elif i<722168 then return i+263;
  elif i<722169 then return i+254;
  elif i<722235 then return i-133;
  elif i<722356 then return i+327;
  elif i<722357 then return i+63;
  elif i<722358 then return i+204;
  elif i<722359 then return i+81;
  elif i<722480 then return i+346;
  elif i<722481 then return i-63;
  elif i<722482 then return i+204;
  elif i<722483 then return i-45;
  elif i<722484 then return i+218;
  elif i<722485 then return i+349;
  elif i<722486 then return i+213;
  elif i<722487 then return i-55;
  elif i<722488 then return i+215;
  elif i<722489 then return i+342;
  elif i<722490 then return i-63;
  elif i<722556 then return i-267;
  elif i<722557 then return i+143;
  elif i<722558 then return i+135;
  elif i<722559 then return i+270;
  elif i<722561 then return i+127;
  elif i<722562 then return i-140;
  elif i<722564 then return i+121;
  elif i<722565 then return i-144;
  elif i<722566 then return i-147;
  elif i<722567 then return i+122;
  elif i<722688 then return i-127;
  elif i<722689 then return i-273;
  elif i<722690 then return i-251;
  elif i<722691 then return i-277;
  elif i<722692 then return i-256;
  elif i<722693 then return i-280;
  elif i<722694 then return i-261;
  elif i<722695 then return i+138;
  elif i<722697 then return i-268;
  elif i<722698 then return i-4;
  elif i<722699 then return i-288;
  elif i<722700 then return i-275;
  elif i<722701 then return i+131;
  elif i<722822 then return i-599;
  elif i<722823 then return i-397;
  elif i<722824 then return i-126;
  elif i<722825 then return i-135;
  elif i<722826 then return i-130;
  elif i<722827 then return i+1;
  elif i<722828 then return i+2;
  elif i<722829 then return i-138;
  elif i<722830 then return i-413;
  elif i<722831 then return i-127;
  elif i<722832 then return i-417;
  elif i<722833 then return i-396;
  elif i<722834 then return i-133;
  elif i<723001 then return i;
  elif i<723002 then return i+628;
  elif i<723003 then return i+823;
  elif i<723004 then return i+818;
  elif i<723005 then return i+263;
  elif i<723006 then return i+256;
  elif i<723007 then return i+818;
  elif i<723008 then return i+127;
  elif i<723009 then return i+967;
  elif i<723010 then return i+251;
  elif i<723131 then return i+262;
  elif i<723132 then return i+689;
  elif i<723133 then return i+694;
  elif i<723134 then return i+839;
  elif i<723135 then return i+125;
  elif i<723136 then return i+260;
  elif i<723137 then return i+127;
  elif i<723138 then return i+495;
  elif i<723204 then return i+691;
  elif i<723325 then return i-66;
  elif i<723326 then return i+643;
  elif i<723327 then return i+305;
  elif i<723328 then return i+235;
  elif i<723329 then return i-191;
  elif i<723330 then return i+637;
  elif i<723451 then return i-318;
  elif i<723452 then return i+110;
  elif i<723453 then return i-316;
  elif i<723454 then return i-442;
  elif i<723455 then return i+176;
  elif i<723456 then return i+105;
  elif i<723470 then return i-35;
  elif i<723471 then return i-460;
  elif i<723472 then return i-338;
  elif i<723473 then return i+87;
  elif i<723474 then return i-468;
  elif i<723540 then return i+159;
  elif i<723541 then return i+359;
  elif i<723542 then return i-532;
  elif i<723543 then return i+16;
  elif i<723664 then return i+156;
  elif i<723665 then return i-656;
  elif i<723666 then return i-108;
  elif i<723667 then return i-268;
  elif i<723668 then return i+231;
  elif i<723734 then return i-105;
  elif i<723735 then return i-727;
  elif i<723736 then return i+236;
  elif i<723857 then return i-300;
  elif i<723858 then return i-853;
  elif i<723859 then return i-856;
  elif i<723860 then return i-424;
  elif i<723861 then return i+37;
  elif i<723862 then return i+109;
  elif i<723863 then return i-861;
  elif i<723864 then return i+33;
  elif i<723886 then return i-465;
  elif i<723887 then return i-880;
  elif i<723888 then return i+82;
  elif i<723889 then return i-885;
  elif i<723890 then return i-492;
  elif i<723891 then return i-496;
  elif i<723892 then return i+83;
  elif i<723893 then return i+3;
  elif i<723894 then return i-627;
  elif i<723895 then return i-498;
  elif i<723896 then return i+81;
  elif i<723897 then return i+71;
  elif i<723898 then return i-504;
  elif i<723899 then return i+75;
  elif i<723965 then return i+1;
  elif i<723966 then return i-694;
  elif i<723967 then return i-143;
  elif i<723968 then return i-697;
  elif i<723969 then return i-140;
  elif i<723970 then return i-704;
  elif i<723971 then return i-701;
  elif i<723972 then return i-707;
  elif i<723973 then return i-145;
  elif i<723974 then return i-151;
  elif i<723975 then return i-839;
  elif i<723976 then return i-707;
  elif i<723977 then return i-714;
  else return i;fi;
end);

# These are (for documentation) the old, wrong in both ways, permutations 
# # Bettina's code:
# #    perm5  := [1];
# #    Append(perm5, [ 30083, 30084, 30085, 30086 ]);
# #    Append(perm5, [2..30082]);
# SMALL_GROUPS_PERM5 := function(i)
#     if i in [2..5] then
#         return 30081 + i;
#     elif i in [30083..30086] then
#         return i - 30081;
#     fi;
#     return i;
# end;
# #    perm7  := [1];
# #    Append(perm7, [ 104599, 104600, 104601, 104602 ]);
# #    Append(perm7, [2..104598]);
# SMALL_GROUPS_PERM7 := function(i)
#     if i in [2..5] then
#         return 104597 + i;
#     elif i in [104599..104602] then
#         return i - 104597;
#     fi;
#     return i;
# end;
# #    perm11 := [1];
# #    Append(perm11, [ 721053, 721054, 721055, 721056 ]);
# #    Append(perm11, [2..721053]);
# SMALL_GROUPS_PERM11 := function(i)
#     if i in [2..5] then
#         return 721051 + i;
#     elif i in [721053..721056] then
#         return i - 721051;
#     fi;
#     return i;
# end;

BindGlobal("READ_SMALL_FUNCS", [ ]);
BindGlobal("READ_IDLIB_FUNCS", [ ]);

#############################################################################
##
#F  SMALL_AVAILABLE( <order> )
##
##  <ManSection>
##  <Func Name="SMALL_AVAILABLE" Arg='order'/>
##
##  <Description>
##  returns fail if the library of groups of order <A>order</A> is not installed.
##  Otherwise a record with some information about the construction of the
##  groups of order <A>order</A> is returned.
##  </Description>
##  </ManSection>
##
UNBIND_GLOBAL( "SMALL_AVAILABLE" );
DeclareGlobalFunction( "SMALL_AVAILABLE" );

#############################################################################
##
#F  SmallGroupsAvailable( <order> )
##
##  <#GAPDoc Label="SmallGroupsAvailable">
##  <ManSection>
##  <Func Name="SmallGroupsAvailable" Arg='order'/>
##
##  <Description>
##  returns <C>true</C> if the library of groups of order <A>order</A> is
##  installed, and <C>false</C> otherwise.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "SmallGroupsAvailable" );

#############################################################################
##
#F  NumberSmallGroupsAvailable( <order> )
##
##  <#GAPDoc Label="NumberSmallGroupsAvailable">
##  <ManSection>
##  <Func Name="NumberSmallGroupsAvailable" Arg='order'/>
##
##  <Description>
##  returns <C>true</C> if the number of groups of order <A>order</A> is known, and
##  <C>false</C> otherwise.
##  <Example><![CDATA[
##  gap> NumberSmallGroupsAvailable( 100 );
##  true
##  gap> NumberSmallGroups( 100 );
##  16
##  gap> NumberSmallGroupsAvailable( 4096 );
##  false
##  gap> NumberSmallGroups( 4096 );
##  Error, the library of groups of size 4096 is not available
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "NumberSmallGroupsAvailable" );

#############################################################################
##
#F  SmallGroup( <order>, <i> )
#F  SmallGroup( [<order>, <i>] )
##
##  <#GAPDoc Label="SmallGroup">
##  <ManSection>
##  <Func Name="SmallGroup" Arg='order, i'
##   Label="for group order and index"/>
##  <Func Name="SmallGroup" Arg='pair' Label="for a pair [ order, index ]"/>
##
##  <Description>
##  returns the <A>i</A>-th group of order <A>order</A> in the catalogue.
##  If the group is solvable, it will be given as a PcGroup;
##  otherwise it will be given as a permutation group.
##  If the groups of order <A>order</A> are not installed,
##  the function reports an error and enters a break loop.
##  <Example><![CDATA[
##  gap> G := SmallGroup( 60, 4 );
##  <pc group of size 60 with 4 generators>
##  gap> StructureDescription( G );
##  "C60"
##  gap> G := SmallGroup( 60, 5 );
##  Group([ (1,2,3,4,5), (1,2,3) ])
##  gap> StructureDescription( G );
##  "A5"
##  gap> G := SmallGroup( 768, 1000000 );
##  <pc group of size 768 with 9 generators>
##  gap> G := SmallGroup( [768, 1000000] );
##  <pc group of size 768 with 9 generators>
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
UNBIND_GLOBAL( "SmallGroup" );
DeclareGlobalFunction( "SmallGroup" );

#############################################################################
##
#F  SelectSmallGroups( <argl>, <all>, <id> )
##
##  <#GAPDoc Label="SelectSmallGroups">
##  <ManSection>
##  <Func Name="SelectSmallGroups" Arg='argl, all, id'/>
##
##  <Description>
##  universal function for 'AllSmallGroups', 'OneSmallGroup' and 'IdsOfAllSmallGroups'.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "SelectSmallGroups" );

#############################################################################
##
#F  AllSmallGroups( <arg> )
##
##  <#GAPDoc Label="AllSmallGroups">
##  <ManSection>
##  <Func Name="AllSmallGroups" Arg='arg'/>
##
##  <Description>
##  returns all groups with certain properties as specified by <A>arg</A>.
##  If <A>arg</A> is a number <M>n</M>, then this function returns all groups
##  of order <M>n</M>.
##  However, the function can also take several arguments which then
##  must be organized in pairs <C>function</C> and <C>value</C>.
##  In this case the first function must be <Ref BookName="ref" Func="Size"/>
##  and the first value an order or a range of orders.
##  If value is a list then it is considered a list of possible function
##  values to include. 
##  The function returns those groups of the specified orders having those
##  properties specified by the remaining functions and their values.
##  <P/>
##  Precomputed information is stored for the properties
##  <Ref BookName="ref" Func="IsAbelian"/>, <Ref BookName="ref" Func="IsNilpotentGroup"/>,
##  <Ref BookName="ref" Func="IsSupersolvableGroup"/>, <Ref BookName="ref" Func="IsSolvableGroup"/>, 
##  <Ref BookName="ref" Func="RankPGroup"/>, <Ref BookName="ref" Func="PClassPGroup"/>,
##  <Ref BookName="ref" Func="LGLength"/>, <C>FrattinifactorSize</C> and 
##  <C>FrattinifactorId</C> for the groups of order at most
##  <M>2000</M> which have  more than three prime factors,
##  except those of order <M>512</M>, <M>768</M>, 
##  <M>1024</M>, <M>1152</M>, <M>1536</M>, <M>1920</M> and those of order
##  <M>p^n \cdot q > 1000</M> 
##  with <M>n > 2</M>. 
##  <Example><![CDATA[
##  gap> AllSmallGroups( 6 );
##  [ <pc group of size 6 with 2 generators>, 
##    <pc group of size 6 with 2 generators> ]
##  gap> AllSmallGroups( 60, IsNilpotentGroup );
##  [ <pc group of size 60 with 4 generators>, 
##    <pc group of size 60 with 4 generators> ]
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
UNBIND_GLOBAL( "AllGroups" );
BindGlobal( "AllSmallGroups", function( arg )
    return SelectSmallGroups( arg, true, false );
end );
DeclareObsoleteSynonym( "AllGroups", "AllSmallGroups" );

#############################################################################
##
#F  OneSmallGroup( <arg> )
##
##  <#GAPDoc Label="OneSmallGroup">
##  <ManSection>
##  <Func Name="OneSmallGroup" Arg='arg'/>
##
##  <Description>
##  returns one group with certain properties as specified by <A>arg</A>.
##  The permitted arguments are those supported by
##  <Ref Func="AllSmallGroups"/>.
##  <Example><![CDATA[
##  gap> G := OneSmallGroup( 6, IsAbelian );
##  <pc group of size 6 with 2 generators>
##  gap> StructureDescription( G );
##  "C6"
##  gap> G := OneSmallGroup( 6, IsAbelian, false );
##  <pc group of size 6 with 2 generators>
##  gap> StructureDescription( G );
##  "S3"
##  gap> G := OneSmallGroup( Size, [1..1000], IsSolvableGroup, false );
##  Group([ (1,2,3,4,5), (1,2,3) ])
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
UNBIND_GLOBAL( "OneGroup" );
BindGlobal( "OneSmallGroup", function( arg )
    return SelectSmallGroups( arg, false, false );
end );
DeclareObsoleteSynonym( "OneGroup", "OneSmallGroup" );

#############################################################################
##
#F  IdsOfAllSmallGroups( <arg> )
##
##  <#GAPDoc Label="IdsOfAllSmallGroups">
##  <ManSection>
##  <Func Name="IdsOfAllSmallGroups" Arg='arg'/>
##
##  <Description>
##  similar to <C>AllSmallGroups</C> but returns ids instead of groups. This may
##  prevent workspace overflows, if a large number of groups are expected in 
##  the output.
##  <Example><![CDATA[
##  gap> IdsOfAllSmallGroups( 60, IsNilpotentGroup );
##  [ [ 60, 4 ], [ 60, 13 ] ]
##  gap> IdsOfAllSmallGroups( 60, IsNilpotentGroup, false );
##  [ [ 60, 1 ], [ 60, 2 ], [ 60, 3 ], [ 60, 5 ], [ 60, 6 ], [ 60, 7 ], 
##    [ 60, 8 ], [ 60, 9 ], [ 60, 10 ], [ 60, 11 ], [ 60, 12 ] ]
##  gap> IdsOfAllSmallGroups( Size, 60, IsSupersolvableGroup, true );
##  [ [ 60, 1 ], [ 60, 2 ], [ 60, 3 ], [ 60, 4 ], [ 60, 6 ], [ 60, 7 ], 
##    [ 60, 8 ], [ 60, 10 ], [ 60, 11 ], [ 60, 12 ], [ 60, 13 ] ]
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
UNBIND_GLOBAL( "IdsOfAllGroups" );
BindGlobal( "IdsOfAllSmallGroups", function( arg )
    return SelectSmallGroups( arg, true, true );
end );
DeclareSynonym( "IdsOfAllGroups", IdsOfAllSmallGroups );

#############################################################################
##
#F  NumberSmallGroups( <order> )
##
##  <#GAPDoc Label="NumberSmallGroups">
##  <ManSection>
##  <Func Name="NumberSmallGroups" Arg='order'/>
##  <Func Name="NrSmallGroups" Arg='order'/>
##
##  <Description>
##  returns the number of groups of order <A>order</A>.
##  <Example><![CDATA[
##  gap> NumberSmallGroups( 512 );
##  10494213
##  gap> NumberSmallGroups( 2^8 * 23 );
##  1083472
##  gap> NumberSmallGroups( 4096 );
##  Error, the library of groups of size 4096 is not available
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
UNBIND_GLOBAL( "NumberSmallGroups" );
DeclareGlobalFunction( "NumberSmallGroups" );
DeclareSynonym( "NrSmallGroups", NumberSmallGroups );

#############################################################################
##
#F  UnloadSmallGroupsData( )
##
##  <#GAPDoc Label="UnloadSmallGroupsData">
##  <ManSection>
##  <Func Name="UnloadSmallGroupsData" Arg=''/>
##
##  <Description>
##  &GAP; loads all necessary data from the library automatically,
##  but it does not delete the data from the workspace again.
##  Usually, this will be not necessary, since the data is stored in a
##  compressed format. However, if 
##  a large number of groups from the library have been loaded, then the user 
##  might wish to remove the data from the workspace and this can be done by 
##  the above function call.
##  <Example><![CDATA[
##  gap> UnloadSmallGroupsData();
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "UnloadSmallGroupsData" );

#############################################################################
##
#F  ID_AVAILABLE( <order> )
##
##  <ManSection>
##  <Func Name="ID_AVAILABLE" Arg='order'/>
##
##  <Description>
##  returns false, if the identification routines for groups of order
##  <A>order</A> is not installed. Otherwise a record with some information
##  about the identification of groups of order <A>order</A> is returned.
##  </Description>
##  </ManSection>
##
UNBIND_GLOBAL( "ID_AVAILABLE" );
DeclareGlobalFunction( "ID_AVAILABLE" );

#############################################################################
##
#F  IdGroupsAvailable( <order> )
##
##  <#GAPDoc Label="IdGroupsAvailable">
##  <ManSection>
##  <Func Name="IdGroupsAvailable" Arg='order'/>
##
##  <Description>
##  returns <C>true</C>, if the identification routines for groups of
##  order <A>order</A> are installed, otherwise returns <C>false</C>. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "IdGroupsAvailable");

#############################################################################
##
#A  IdSmallGroup( <G> )
#A  IdGroup( <G> )
##
##  <#GAPDoc Label="IdSmallGroup">
##  <ManSection>
##  <Attr Name="IdSmallGroup" Arg='G'/>
##  <Attr Name="IdGroup" Arg='G'/>
##
##  <Description>
##  returns the library number of <A>G</A>; that is, the function returns a pair
##  <C>[<A>order</A>, <A>i</A>]</C> where <A>G</A> is isomorphic to <C>SmallGroup( <A>order</A>, <A>i</A> )</C>.
##  <Example><![CDATA[
##  gap> IdSmallGroup( GL( 2,3 ) );
##  [ 48, 29 ]
##  gap> IdSmallGroup( Group( (1,2,3,4),(4,5) ) );
##  [ 120, 34 ]
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
UNBIND_GLOBAL( "IdGroup" );
DeclareAttribute( "IdGroup", IsGroup );
DeclareSynonym( "IdSmallGroup",IdGroup );

#############################################################################
##
#F  IdStandardPresented512Group( <G> )
#F  IdStandardPresented512Group( <pcgs> )
##
##  <ManSection>
##  <Func Name="IdStandardPresented512Group" Arg='G'/>
##  <Func Name="IdStandardPresented512Group" Arg='pcgs'/>
##
##  <Description>
##  returns the catalogue number of a group <A>G</A> of order 512 if <C>Pcgs(<A>G</A>)</C> 
##  or <C>pcgs</C> is a pcgs corresponding to a power-commutator presentation 
##  which forms an ANUPQ-standard presentation of <A>G</A>. If the input is not
##  corresponding to a standard presentation, then a warning is printed 
##  and <K>fail</K> is returned.
##  </Description>
##  </ManSection>
##
UNBIND_GLOBAL( "IdStandardPresented512Group" );
DeclareGlobalFunction( "IdStandardPresented512Group" );

#############################################################################
##
#F  SmallGroupsInformation( <order> )
##
##  <#GAPDoc Label="SmallGroupsInformation">
##  <ManSection>
##  <Func Name="SmallGroupsInformation" Arg='order'/>
##
##  <Description>
##  prints information on the groups of the specified order.
##  <Example><![CDATA[
##  gap> SmallGroupsInformation( 32 );
##  
##    There are 51 groups of order 32.
##    They are sorted by their ranks. 
##       1 is cyclic. 
##       2 - 20 have rank 2.
##       21 - 44 have rank 3.
##       45 - 50 have rank 4.
##       51 is elementary abelian. 
##  
##    For the selection functions the values of the following attributes 
##    are precomputed and stored:
##       IsAbelian, PClassPGroup, RankPGroup, FrattinifactorSize and 
##       FrattinifactorId. 
##  
##    This size belongs to layer 2 of the SmallGroups library. 
##    IdSmallGroup is available for this size. 
##   
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareGlobalFunction( "SmallGroupsInformation" );

#############################################################################
##  
#A  IdGap3SolvableGroup( <G> )
#A  Gap3CatalogueIdGroup( <G> )
##
##  <#GAPDoc Label="IdGap3SolvableGroup">
##  <ManSection>
##  <Attr Name="IdGap3SolvableGroup" Arg='G'/>
##  <Attr Name="Gap3CatalogueIdGroup" Arg='G'/>
##
##  <Description>
##  returns the catalogue number of <A>G</A> in the &GAP;&nbsp;3 catalogue
##  of solvable groups;
##  that is, the function returns a pair <C>[<A>order</A>, <A>i</A>]</C> meaning that
##  <A>G</A> is isomorphic to the group
##  <C>SolvableGroup( <A>order</A>, <A>i</A> )</C> in &GAP;&nbsp;3.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
UNBIND_GLOBAL( "Gap3CatalogueIdGroup" );
DeclareAttribute( "Gap3CatalogueIdGroup", IsGroup );
DeclareSynonym( "IdGap3SolvableGroup", Gap3CatalogueIdGroup );

#############################################################################
##  
#F  Gap3CatalogueGroup( <order>, <i> )
##
##  <ManSection>
##  <Func Name="Gap3CatalogueGroup" Arg='order, i'/>
##
##  <Description>
##  returns the <A>i</A>-th group of order <A>order</A> in the &GAP;&nbsp;3
##  catalogue of solvable groups.
##  This group is isomorphic to the group returned by
##  <C>SolvableGroup( <A>order</A>, <A>i</A> )</C> in &GAP;&nbsp;3.
##  </Description>
##  </ManSection>
##
DeclareGlobalFunction( "Gap3CatalogueGroup" );

#############################################################################
##  
#A  FrattinifactorSize( <G> )
##
##  <ManSection>
##  <Attr Name="FrattinifactorSize" Arg='G'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##
DeclareAttribute( "FrattinifactorSize", IsGroup );

#############################################################################
##  
#A  FrattinifactorId( <G> )
##
##  <ManSection>
##  <Attr Name="FrattinifactorId" Arg='G'/>
##
##  <Description>
##  </Description>
##  </ManSection>
##
DeclareAttribute( "FrattinifactorId", IsGroup );
