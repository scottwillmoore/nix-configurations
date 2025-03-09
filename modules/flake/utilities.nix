{ inputs, ... }:
let
  utilities = inputs.nixpkgs.lib.extend (
    _: previous:
    let
      # Attrsets

      merge = previous.foldl' previous.recursiveUpdate { };

      # Mathematics

      lls =
        n: x:
        assert previous.isInt n;
        assert n >= 0;
        assert previous.isInt x;
        assert x >= 0;
        x * (pow2 n);

      lrs =
        n: x:
        assert previous.isInt n;
        assert n >= 0;
        assert previous.isInt x;
        assert x >= 0;
        x / (pow2 n);

      mod =
        n: q:
        assert previous.isInt n;
        assert n >= 0;
        assert previous.isInt q;
        assert q >= 0;
        n - n / q * q;

      pow2 =
        let
          pow2' = n: x: if n == 0 then x else pow2' (n - 1) (2 * x);
        in
        n:
        assert previous.isInt n;
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
  );
in
{
  _module.args = {
    inherit utilities;
  };

  outputs = {
    inherit utilities;
  };
}
