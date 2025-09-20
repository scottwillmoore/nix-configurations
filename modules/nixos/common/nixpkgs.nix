{
  nixpkgs = {
    config = {
      allowAliases = true;
      allowUnfree = true;
    };

    hostPlatform = "x86_64-linux";
  };
}
