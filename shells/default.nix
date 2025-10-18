{ packages, ... }:
packages.mkShellNoCC {
  packages = with packages; [
    nixd
    nixfmt-rfc-style
  ];
}
