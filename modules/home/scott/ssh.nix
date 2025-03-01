{ ... }:
{
  imports = [ ./ssh.module.nix ];

  programs.ssh.enable = true;
}
