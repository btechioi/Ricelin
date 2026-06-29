{
  description = "Ricelin — Warm vermilion-on-dark-brown Hyprland rice (modules for NixOS)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:Qwicky/Quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, hyprland, quickshell }:
    let
      forSystem = system: {
        inherit hyprland quickshell;
        pkgs = import nixpkgs { inherit system; };
      };
    in
    {
      nixosModules = {
        ricelin = import ./modules/nixos;
        sddm = import ./modules/nixos/sddm.nix;
        grub = import ./modules/nixos/grub.nix;
        imagemagick = import ./modules/nixos/imagemagick.nix;
        packages = import ./modules/nixos/packages.nix;
      };

      homeModules = {
        ricelin = import ./modules/home;
        hyprland = import ./modules/home/hyprland.nix;
        hypridle = import ./modules/home/hypridle.nix;
        ghostty = import ./modules/home/ghostty.nix;
        fish = import ./modules/home/fish.nix;
        fastfetch = import ./modules/home/fastfetch.nix;
        kde = import ./modules/home/kde.nix;
        systemd = import ./modules/home/systemd.nix;
        cava = import ./modules/home/cava.nix;
        quickshell = import ./modules/home/quickshell.nix;
        matugen = import ./modules/home/matugen.nix;
      };
    };
}
