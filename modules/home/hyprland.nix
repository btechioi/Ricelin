{ config, pkgs, lib, hyprland, ... }:

let
  cfg = config.ricelin.hyprland;
in
{
  options.ricelin.hyprland = {
    enable = lib.mkEnableOption "Ricelin Hyprland config";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
      systemdIntegration = true;
      xwayland.enable = true;

      # Reference the existing Lua config from the repo.
      extraConfig = ''
        # Loaded by require() in hyprland.lua — paths are relative to the config dir.
      '';
    };

    xdg.configFile."hypr/hyprland.lua".source = ../../configs/hypr/hyprland.lua;
    xdg.configFile."hypr/rishot.lua".source = ../../configs/hypr/rishot.lua;
    xdg.configFile."hypr/modules" = {
      source = ../../configs/hypr/modules;
      recursive = true;
    };
    xdg.configFile."hypr/scripts" = {
      source = ../../configs/hypr/scripts;
      recursive = true;
    };

    # Place default wallpaper so the Ricelin wallpaper script has something to show.
    home.file."Ricelin/wallpapers/default.jpg".source = ../../configs/wallpapers/default.jpg;
  };
}
