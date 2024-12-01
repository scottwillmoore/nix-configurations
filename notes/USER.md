# User Management

At the moment, I use [`home-manager`](https://github.com/nix-community/home-manager).

## Questions

What is bad and good about Home Manager?

What if it was built and tightly integrated with NixOS?

What if a new OS was created which combined ideas from NixOS and Home Manager?

What alternative strategies could be adopted? For example, see `wrapper-manager`.

How could tests be improved?

What could a Home Manager built on [Nickel] be like?

## Requirements

What is important:

- A user should be host agnostic, therefore also architecture agnostic.
- It should be responsible for packages, and also configuration.
- However, there is often an overlap in responsibility with the host configuration.

What is the minimal set of features that are required:

- Create directories, files and symlinks.
- Set environment variables.
- Run arbitrary scripts on activation, etc.

What additional features would be expected:

- Configure XDG directories.
- Create and manage `systemd` units.

What ideas would be unique:

- Create a cross-platform abstraction for `launchd` (MacOS) and `systemd` (Linux).
- Secret management with platforms such as Bitwarden.
- Encryption with tools such as `age`.
- Easily "diff" and "merge" changes.
- Easily manually override files for temporary changes and experiments.
- Integration with `nix-community/impermanence'.

## References

- https://github.com/nix-community/home-manager
- https://www.chezmoi.io/
- https://github.com/CyberShadow/aconfmgr
- https://ayats.org/blog/no-home-manager
- https://github.com/viperML/wrapper-manager
