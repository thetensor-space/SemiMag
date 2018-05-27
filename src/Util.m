/* 
    Copyright 2018, Joshua Maglione.
    Distributed under GNU GPLv3.
*/

import "GlobalVars.m" : __VERSION;

intrinsic SemiMagVersion() -> MonStgElt
{Returns the version number of SemiMag.}
  return __VERSION;
end intrinsic;
