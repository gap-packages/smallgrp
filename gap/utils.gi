#
# smallgrp: The GAP Small Groups Library
#
# Utility functions, implementation part
#

InstallGlobalFunction(SmallGrpMakeDoc,
function()
    MakeGAPDocDoc(Concatenation(PackageInfo("smallgrp")[1]!.InstallationPath,
                                "/doc")
                 , "main.xml"
                 , []
                 , "smallgrp"
                 , "MathJax",
                 "../../..");
end);

