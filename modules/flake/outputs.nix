{
  lib,

  self,

  ...
}:
{
  imports = [
    (lib.mkAliasOptionModule [ "outputs" ] [ "flake" ])

    {
      _module.args.outputs = self.outputs;
    }
  ];
}
