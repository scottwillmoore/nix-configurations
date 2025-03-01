{ pkgs, ... }:
{
  imports = [ ./gpg.module.nix ];

  programs.gpg = {
    enable = true;

    config = {
      keyid-format = "long";
      no-greeting = true;
      with-fingerprint = true;
    };
  };

  services.gpg-agent = {
    enable = true;

    pinentryPackage = pkgs.pinentry-gnome3;

    config = {
      no-allow-external-cache = true;
    };

    ssh = {
      enable = true;

      keys = [ "6C560B0B5F2146329B7AC36992F7186F2EE51AD4" ];
    };
  };
}
