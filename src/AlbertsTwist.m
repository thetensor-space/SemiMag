/* 
    Copyright 2018, Joshua Maglione.
    Distributed under GNU GPLv3.
*/


/*
  Given F of degree at least 3 over GF(p), integers alpha and beta, and j in 
  GF(p), return the tensor where 
    x * y = xy - j(x^alpha)(y^beta).
*/
__TwistedField := function(F, alpha, beta, j)
  p := Characteristic(F);
  exp_a := Round(Log(p, alpha));
  exp_b := Round(Log(p, beta));
  d := GCD(exp_a, exp_b);
  e := Degree(F) div d;
  K, pi := sub< F | d >;
  V := VectorSpace(K, e);

  phi := map< V -> F | x :-> F!Eltseq(x), y :-> V!Eltseq(y, K) >;

  /* Following notation from 
     W. M. Kantor, Finite Semifields, Finite geometries, groups, and 
     computation, 103–114, Walter de Gruyter, Berlin, 2006. */
  twist := func< x | ((x[1] @ phi)*(x[2] @ phi) - 
    j*(x[1] @ phi)^alpha*(x[2] @ phi)^beta) @@ phi >;
  Cat := TensorCategory([1, 1, 1], {{0, 1, 2}});
  t := Tensor([V, V, V], twist, Cat);

  return t;
end function;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                                  Intrinsics
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

intrinsic TwistedField( q::RngIntElt, alpha::RngIntElt, beta::RngIntElt, 
  j::RngIntElt ) -> AlgGen
{Returns the twisted field of GF(q) with parameters alpha, beta, and j.}
  require q ge 2 : "Argument 1 must be at least 2.";
  require IsPrimePower(q) : "Argument 1 must be a prime power.";
  p := Factorization(q)[1][1];
  require IsPrimePower(alpha) and IsDivisibleBy(alpha, p) : 
    "Argument 2 should be a prime power Galois automorphism.";
  require IsPrimePower(beta) and IsDivisibleBy(beta, p) : 
    "Argument 3 should be a prime power Galois automorphism.";
  return HeisenbergAlgebra(__TwistedField(GF(q), alpha, beta, j));
end intrinsic;
