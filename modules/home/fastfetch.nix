{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.fastfetch;
in
{
  options.ricelin.fastfetch = {
    enable = lib.mkEnableOption "Ricelin Fastfetch config";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."fastfetch/config.jsonc.in".source = ../../configs/fastfetch/config.jsonc.in;
    xdg.configFile."fastfetch/lantern.txt".source = ../../configs/fastfetch/lantern.txt;
  };
}
