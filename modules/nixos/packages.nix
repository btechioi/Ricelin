{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.packages;
  pkgData = import ../../installer/packages.nix;

  # Map package IDs to nixpkgs attribute paths.
  # null means the package is handled differently (flake input, flatpak, etc.).
  nixPkg = id: {
    hyprland = pkgs.hyprland;
    hyprpicker = pkgs.hyprpicker;
    hyprpolkitagent = pkgs.hyprpolkitagent;
    hypridle = pkgs.hypridle;
    cava = pkgs.cava;
    ghostty = pkgs.ghostty;
    fish = pkgs.fish;
    zoxide = pkgs.zoxide;
    cliphist = pkgs.cliphist;
    wl-clipboard = pkgs.wl-clipboard;
    imagemagick = pkgs.imagemagick;
    jq = pkgs.jq;
    brightnessctl = pkgs.brightnessctl;
    playerctl = pkgs.playerctl;
    pamixer = pkgs.pamixer;
    kde-cli-tools = pkgs.kde-cli-tools;
    kdialog = pkgs.kdialog;
    fastfetch = pkgs.fastfetch;
    grim = pkgs.grim;
    slurp = pkgs.slurp;
    dolphin = pkgs.dolphin;
    keepassxc = pkgs.keepassxc;
    zathura = pkgs.zathura;
    imv = pkgs.imv;
    brave = pkgs.brave;
    dotool = pkgs.dotool;
    swww = pkgs.swww;
    matugen = pkgs.matugen;
    networkmanager = pkgs.networkmanager;
    bluez = pkgs.bluez;
    "bluez-utils" = pkgs.bluez-tools;
    pipewire = pkgs.pipewire;
    wireplumber = pkgs.wireplumber;
    "ttf-jetbrains-mono-nerd" = pkgs.nerdfonts.jetbrains-mono;
    "inter-font" = pkgs.inter;
    "noto-fonts" = pkgs.noto-fonts;
    "noto-fonts-cjk" = pkgs.noto-fonts-cjk-sans;
    "noto-fonts-emoji" = pkgs.noto-fonts-emoji;
    "papirus-icon-theme" = pkgs.papirus-icon-theme;
    "bibata-cursor-theme" = pkgs.bibata-cursor-theme;
    "zathura-pdf-mupdf" = pkgs.zathura-pdf-mupdf;
  }.${id} or null;

  # Filter packages matching the selected profile and map to nixpkgs.
  selected = builtins.filter (p: p.group == cfg.profile || p.group == "core") pkgData.packages;
  toInstall = lib.catAttrs "id" (builtins.filter (p: nixPkg p.id != null) selected);
in
{
  options.ricelin.packages = {
    enable = lib.mkEnableOption "Ricelin package installation";
    profile = lib.mkOption {
      type = lib.types.enum [ "core" "full" "extra" ];
      default = "core";
      description = "Which package group to install";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = map (id: nixPkg id) toInstall;
    services.pipewire.enable = true;
    services.pipewire.wireplumber.enable = true;
    networking.networkmanager.enable = true;
    services.bluetooth.enable = true;
    programs.fish.enable = true;
    programs.zathura.enable = true;
  };
}
