# Structure

- **flake.nix** - external inputs.
- **configuration.nix** - system configuration.
- **home.nix** - user configuration.
- **modules/** - nix modules(user or system).

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

**cd into cloned repo.** You need to generate your hardware configuration. 
You can change **hardware.nix** to any name, describing your machine.

```sh
sudo nixos-generate-config --show-hardware-config > hardware.nix
```

Change hardware configuration file import inside **configuration.nix** to filename from previous step. 
Change user variable to your username. Also change your git credentials.

```sh
export NIX_CONFIG="experimental-features = nix-command flakes"
```

```sh
sudo nixos-rebuild switch --flake .
home-manager switch --flake .
```

If downloading failed with a message about mirrors, try using a VPN.

Reboot. Done.

# TODO

- Hyprland and waybar config
