{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.kde;
  kglobals = import ../../configs/kde/kdeglobals.nix;

  # Serialise a Nix attrset of sections into KDE-style INI text.
  toIni = sections:
    lib.concatStrings (
      lib.mapAttrsToList (section: kvs: ''
        [${section}]
        ${lib.concatStrings (lib.mapAttrsToList (k: v: "${k}=${toString v}\n") kvs)}
      '') sections
    );
in
{
  options.ricelin.kde = {
    enable = lib.mkEnableOption "Ricelin KDE colour scheme";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."kdeglobals".text = toIni kglobals;
  };
}
