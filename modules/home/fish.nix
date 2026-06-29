{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.fish;
in
{
  options.ricelin.fish = {
    enable = lib.mkEnableOption "Ricelin Fish config";
  };

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = {
        ff = "fastfetch";
      };
      functions = {
        fish_greeting = ''
          ${pkgs.fastfetch}/bin/fastfetch
        '';
      };
    };

    programs.zoxide.enableFishIntegration = true;

    xdg.configFile."fish/config.fish".source = ../../configs/fish/config.fish;
  };
}
