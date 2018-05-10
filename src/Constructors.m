/* 
    Copyright 2018, Joshua Maglione.
    Distributed under GNU GPLv3.
*/


import "SmallSemifields.m" : __Semifields_2_4, __Semifields_2_5, 
  __Semifields_3_3, __Semifields_3_4;


// Returns the appropriate structure constants given the category of output.
__Interpreter := function(p, n, how)
  q := p^n;
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

  if how eq "Algebras" then
    for s in SC do
      Append(~L, Algebra< K, n | s >);
    end for;
  elif how eq "Tensors" then
    Cat := TensorCategory([1, 1, 1], {{0, 1, 2}});
    for s in SC do
      Append(~L, Tensor(s, [n, n, n], Cat));
    end for;
  else // matrices
    for s in SC do
      t := Tensor(s, [n, n, n], Cat);
      Append(~L, SystemOfForms(t));
    end for;
  end if;
end function;

intrinsic SemifieldsOfOrder( q::RngIntElt ) -> List
{Returns the known database of proper semifields of order q, as algebras, up to 
(anti-)isotopism.}
  require q ge 2 : "Order must be greater than 1.";
  isit, p, n := IsPrimePower(q);
  require isit : "Order must be a prime power";  

  return __Interpreter(p, n, "Algebras");
end intrinsic;

intrinsic SemifieldsOfOrder( p::RngIntElt, n::RngIntElt ) -> List
{Returns the known database of proper semifields of order p^n, as algebras, up 
to (anti-)isotopism.}
  require p ge 2 : "Argument 1 must be at least 2.";
  require IsPrime(p) : "Argument 1 must be prime.";
  require n ge 1 : "Argument 2 must be positive.";

  return __Interpreter(p, n, "Algebras");
end intrinsic;

intrinsic SemifieldsOfOrderAsTensors( q::RngIntElt ) -> List
{Returns the known database of proper semifields of order q, as tensors, up to 
(anti-)isotopism.}
  require q ge 2 : "Order must be greater than 1.";
  isit, p, n := IsPrimePower(q);
  require isit : "Order must be a prime power";  

  return __Interpreter(p, n, "Tensors");
end intrinsic;

intrinsic SemifieldsOfOrderAsTensors( p::RngIntElt, n::RngIntElt ) -> List
{Returns the known database of proper semifields of order p^n, as tensors, up to 
(anti-)isotopism.}
  require p ge 2 : "Argument 1 must be at least 2.";
  require IsPrime(p) : "Argument 1 must be prime.";
  require n ge 1 : "Argument 2 must be positive.";

  return __Interpreter(p, n, "Tensors");
end intrinsic;

intrinsic SemifieldsOfOrderAsMatrices( q::RngIntElt ) -> List
{Returns the known database of proper semifields of order q, as matrices, up to 
(anti-)isotopism.}
  require q ge 2 : "Order must be greater than 1.";
  isit, p, n := IsPrimePower(q);
  require isit : "Order must be a prime power";  

  return __Interpreter(p, n, "Matrices");
end intrinsic;

intrinsic SemifieldsOfOrderAsMatrices( p::RngIntElt, n::RngIntElt ) -> List
{Returns the known database of proper semifields of order p^n, as matrices, up 
to (anti-)isotopism.}
  require p ge 2 : "Argument 1 must be at least 2.";
  require IsPrime(p) : "Argument 1 must be prime.";
  require n ge 1 : "Argument 2 must be positive.";

  return __Interpreter(p, n, "Matrices");
end intrinsic;
