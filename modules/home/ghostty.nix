{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.ghostty;
in
{
  options.ricelin.ghostty = {
    enable = lib.mkEnableOption "Ricelin Ghostty config";
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      package = pkgs.ghostty;
    };
    xdg.configFile."ghostty/config".source = ../../configs/ghostty/config;
  };
}
