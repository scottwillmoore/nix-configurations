lib:
let
  # Attrsets

  merge = lib.foldl' lib.recursiveUpdate { };

  # Mathematics

  lls =
    n: x:
    assert lib.isInt n;
    assert n >= 0;
    assert lib.isInt x;
    assert x >= 0;
    x * (pow2 n);

  lrs =
    n: x:
    assert lib.isInt n;
    assert n >= 0;
    assert lib.isInt x;
    assert x >= 0;
    x / (pow2 n);

  mod =
    n: q:
    assert lib.isInt n;
    assert n >= 0;
    assert lib.isInt q;
    assert q >= 0;
    n - n / q * q;

  pow2 =
    let
      pow2' = n: x: if n == 0 then x else pow2' (n - 1) (2 * x);
    in
    n:
    assert lib.isInt n;
    assert n >= 0;
    pow2' n 1;

in
{
  inherit
    lls
    lrs
    merge
    mod
    pow2
    ;
}
