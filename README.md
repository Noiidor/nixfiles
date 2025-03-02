# Structure

- flake.nix - external inputs.
- configuration.nix - system configuration.
- home.nix - user configuration
- modules/ - nix modules(user or system)

# How to install?

```sh
nix shell nixpkgs#git
# Or, if first is unavailable
nix-shell -p git
```

Navigate to the directory, where you want to keep your configuration. I suggest using user home directory.

```sh
git clone this-repo
```

Change user variable to your username. Also change your git credentials.

```sh
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
```

If downloading failed with a message about mirrors, try using a VPN.

Reboot. Done.

# TODO

- Hyprland and waybar config
