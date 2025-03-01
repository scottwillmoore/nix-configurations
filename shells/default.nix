{ pkgs, ... }:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    nixd
    nixfmt-rfc-style
  ];
}
