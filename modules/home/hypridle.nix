{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.hypridle;
in
{
  options.ricelin.hypridle = {
    enable = lib.mkEnableOption "Ricelin hypridle config";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/hypridle.conf".source = ../../configs/hypr/hypridle.conf;
  };
}
