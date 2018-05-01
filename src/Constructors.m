import "SmallSemifields.m" : __Semifields_2_4, __Semifields_2_5, 
  __Semifields_3_3, __Semifields_3_4;

intrinsic SemifieldsOfOrder( q::RngIntElt ) -> List
{Returns the known database of proper semifields of order q, as AlgGen, up to 
(anti-)isotopism.}
  require q ge 2 : "Order must be greater than 1.";
  isit, p, n := IsPrimePower(q);
  require isit : "Order must be a prime power";  

  if p eq 2 and n le 3 then
    return [**];
  end if;

  if p gt 2 and n le 2 then
    return [**];
  end if;

  SC := [];

  if q eq 16 then
    K := GF(2);
    n := 4;
    SC := __Semifields_2_4;
  elif q eq 32 then
    K := GF(2);
    n := 5;
    SC := __Semifields_2_5;
  elif q eq 27 then
    K := GF(3);
    n := 3;
    SC := __Semifields_3_3;
  elif q eq 81 then
    K := GF(3);
    n := 4;
    SC := __Semifields_3_4;
  end if;

  L := [**];

  for s in SC do
    Append(~L, Algebra< K, n | s >);
  end for;

  return L;
end intrinsic;
