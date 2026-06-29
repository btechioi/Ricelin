{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.cava;
in
{
  options.ricelin.cava = {
    enable = lib.mkEnableOption "Ricelin Cava config for Quickshell";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."cava/cava.conf".source = ../../configs/quickshell/lock/assets/cava.conf;
  };
}
