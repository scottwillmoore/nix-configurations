{ inputs, pkgs, ... }:
{
  nix.package = pkgs.nixVersions.latest;

  # Flakes

  nix.channel.enable = false;

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # Settings

  nix.gc.automatic = true;
  nix.gc.dates = "04:00";
  nix.gc.options = "--delete-older-than 30d";

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
    ];
  };

  # Substituters

  nix.settings = {
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "scottwillmoore.cachix.org-1:Ax41diG5shuUfRvFm3Ykv5ta8E8zPO0wYLOkAUDc910="
    ];

    extra-trusted-substituters = [
      "https://cache.numtide.com"
      "https://nix-community.cachix.org"
      "https://scottwillmoore.cachix.org"
    ];
  };
}
