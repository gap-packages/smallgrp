#
# SmallGrp: The GAP Small Groups Library
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "SmallGrp",
Subtitle := "The GAP Small Groups Library",
Version := "1.3",
Date := "09/04/2018", # dd/mm/yyyy format

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Bettina",
    LastName := "Eick",
    WWWHome := "http://www.icm.tu-bs.de/~beick",
    Email := "beick@tu-bs.de",
    PostalAddress := Concatenation(
               "Institut Computational Mathematics\n",
               "TU Braunschweig\n",
               "Pockelsstr. 14\n",
               " D-38106 Braunschweig\n",
               " Germany" ),
    Place := "TU Braunschweig",
    Institution := "TU Braunschweig",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Hans Ulrich",
    LastName := "Besche",
    WWWHome := "http://www-public.tu-bs.de/~hubesche/",
    Email := "hubesche@tu-bs.de",
    PostalAddress := Concatenation(
               "Institut Computational MathematicsTU Braunschweig\n",
               "Pockelsstr. 14\n",
               " D-38106 Braunschweig\n",
               " Germany" ),
    Place := "Braunschweig",
    Institution := "TU Braunschweig",
  ),
  rec(
    IsAuthor := true,
    IsMaintainer := false,
    FirstNames := "Eamonn",
    LastName := "O'Brien",
    WWWHome := "http://www.math.auckland.ac.nz/~obrien",
    Email := "obrien@math.auckland.ac.nz",
    PostalAddress := Concatenation(
               "Department of Mathematics\n",
               "University of Auckland\n",
               "Private Bag 92019\n",
               " Auckland\n",
               " New Zealand" ),
    Place := "Auckland",
    Institution := "University of Auckland",
  ),
  rec(
    LastName      := "GAP Team",
    FirstNames    := "The",
    IsAuthor      := false,
    IsMaintainer  := true,
    Email         := "support@gap-system.org",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := Concatenation( "https://github.com/gap-packages/", ~.PackageName ),
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
#SupportEmail   := "TODO",
PackageWWWHome  := "https://gap-packages.github.io/smallgrp/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "The <span class=\"smallgrp\">SmallGrp</span> package \
provides the library of groups of certain \"small\" orders. The groups are \
sorted by their orders and they are listed up to isomorphism; that is, for \
each of the available orders a complete and irredundant list of isomorphism \
type representatives of groups is given.",

PackageDoc := rec(
  BookName  := "smallgrp",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "The GAP Small Groups Library",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [ [ "GAPDoc", ">= 1.5" ] ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));


