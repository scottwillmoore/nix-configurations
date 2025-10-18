{
  lib,

  self,

  ...
}:
{
  imports = [
    # https://github.com/hercules-ci/flake-parts/issues/67
    (lib.mkAliasOptionModule [ "outputs" ] [ "flake" ])

    {
      _module.args.outputs = self.outputs;
    }
  ];
}
