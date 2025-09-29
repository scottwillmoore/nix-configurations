{
  nixpkgs = {
    config = {
      allowAliases = true;
      allowUnfree = true;
    };

    # TODO: This is device-specific.
    hostPlatform = "x86_64-linux";
  };
}
