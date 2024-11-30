{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  nix.package = pkgs.nixVersions.latest;

  # Flakes

  nix.channel.enable = false;

  nix.settings.flake-registry =
    let
      inherit (builtins) toFile toJSON;
    in
    toFile "flake-registry.json" (toJSON {
      flakes = [ ];
      version = 2;
    });

  nix.registry =
    let
      inherit (lib) filterAttrs isType mapAttrs;

      isFlake = isType "flake";
      flakes = filterAttrs (_: isFlake) inputs;

      toEntry = flake: { inherit flake; };
      entries = mapAttrs (_: toEntry) flakes;
    in
    entries;

  # Settings

  nix.distributedBuilds = true;

  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";
  nix.daemonIOSchedPriority = 7;

  nix.gc = {
    automatic = true;
    dates = "04:00";
    options = "--delete-older-than 7d";
  };

  nix.settings = {
    auto-allocate-uids = true;
    auto-optimise-store = true;
    builders-use-substitutes = true;
    keep-outputs = true;
    use-cgroups = true;
    use-xdg-base-directories = true;

    experimental-features = [
      "auto-allocate-uids"
      "ca-derivations"
      "cgroups"
      "flakes"
      "nix-command"
      "no-url-literals"
    ];
  };

  # Substitutors

  nix.settings = {
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "scottwillmoore.cachix.org-1:Ax41diG5shuUfRvFm3Ykv5ta8E8zPO0wYLOkAUDc910="
    ];

    extra-trusted-substituters = [
      "https://nix-community.cachix.org"
      "https://scottwillmoore.cachix.org"
    ];
  };
}
