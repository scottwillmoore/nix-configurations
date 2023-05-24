# Nix Configuration

Scott's experiment with [Nix](https://github.com/NixOS/nix) and [Home Manager](https://github.com/nix-community/home-manager).

## Goals

- [x] Use Nix flakes
- [x] Setup basic environment
- [ ] Configure GnuPG
- [ ] Install common utilities
- [ ] Refine configuration
- [ ] Ensure the setup is reproducible

## References

### Basics

- [Nix](https://github.com/NixOS/nix)
- [Nix Packages](https://github.com/NixOS/nixpkgs)

### Modules

- [Home Manager](https://github.com/nix-community/home-manager)
- [Impermanence](https://github.com/nix-community/impermanence)

### Examples

- [Misterio77/nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [Xe/nixos-configs](https://github.com/Xe/nixos-configs)
- [gvolpe/nix-config](https://github.com/gvolpe/nix-config)
- [hlissner/dotfiles](https://github.com/hlissner/dotfiles)
- [malob/nixpkgs](https://github.com/malob/nixpkgs)
- [rxyhn/yuki](https://github.com/rxyhn/yuki)

### Secrets

- [GnuPG](https://gnupg.org/)
- [SSH](https://www.openssh.com/)

#### Git

- [Age](https://github.com/FiloSottile/age)
- [Git Crypt](https://github.com/AGWA/git-crypt)
- [Git Secret](https://github.com/sobolevn/git-secret)
- [Git Secrets](https://github.com/awslabs/git-secrets)
- [SOPS](https://github.com/mozilla/sops)
- [Transcrypt](https://github.com/elasticdog/transcrypt)

#### Nix

- [Age Nix](https://github.com/ryantm/agenix)
- [Sops Nix](https://github.com/Mic92/sops-nix)

##### Discussions

- https://nixos.wiki/wiki/Comparison_of_secret_managing_schemes
- https://www.reddit.com/r/NixOS/comments/116juq9/starting_point_with_secrets/
- https://www.reddit.com/r/NixOS/comments/j6nqbe/declarative_secrets/
- https://www.reddit.com/r/NixOS/comments/mvy86q/how_do_you_manage_your_private_keys/
- https://xeiaso.net/blog/nixos-encrypted-secrets-2021-01-20

- https://medium.com/@chrispisano/ssh-authentication-with-gpg-411676781647
- https://gist.github.com/mcattarinussi/834fc4b641ff4572018d0c665e5a94d3
