/* 
    Copyright 2018, Joshua Maglione.
    Distributed under GNU GPLv3.
*/

__DicksonKnuthSemifield := function(q, sigma)
  K := GF(q);
  V := VectorSpace(K, 2);
  k := PrimitiveElement(K);
  prod := func< x | 
    V![x[1][1]*x[2][1] + k*x[1][2]^sigma*x[2][2]^sigma, 
    x[1][1]*x[2][2] + x[1][2]*x[2][1]] >;
  Cat := TensorCategory([1, 1, 1], {{0, 1, 2}});
  t := Tensor([V, V, V], prod, Cat);
  A := HeisenbergAlgebra(t);
  return A;
end function;

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//                                  Intrinsics
// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

intrinsic DicksonKnuthSemifield( q::RngIntElt, sigma::RngIntElt ) -> AlgGen
{Returns the Dickson-Knuth commutative semifield on the set GF(q)^2 with 
parameter sigma, a Galois automorphism of GF(q).}
  require IsOdd(q) and IsPrimePower(q) : 
    "Argument 1 must be an odd prime power.";
  p := Factorization(q)[1][1];
  require IsPrimePower(sigma) and IsDivisibleBy(sigma, p) : 
    "Argument 2 must be a prime power.";
  return __DicksonKnuthSemifield(q, sigma);
end intrinsic;
