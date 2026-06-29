{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.matugen;
in
{
  options.ricelin.matugen = {
    enable = lib.mkEnableOption "Ricelin Matugen colour templates";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."matugen/config.toml".source = ../../configs/matugen/config.toml;
    xdg.configFile."matugen/templates" = {
      source = ../../configs/matugen/templates;
      recursive = true;
    };
  };
}
