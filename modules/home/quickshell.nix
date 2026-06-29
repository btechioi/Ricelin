{ config, pkgs, lib, quickshell, ... }:

let
  cfg = config.ricelin.quickshell;
in
{
  options.ricelin.quickshell = {
    enable = lib.mkEnableOption "Ricelin Quickshell (the Pill)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      quickshell.packages.${pkgs.system}.quickshell
      (writeShellScriptBin "ricelin" (builtins.readFile ../../configs/hypr/scripts/ricelin))
    ];

    xdg.configFile."quickshell/pill" = {
      source = ../../configs/quickshell/pill;
      recursive = true;
    };

    xdg.configFile."quickshell/lock" = {
      source = ../../configs/quickshell/lock;
      recursive = true;
    };

    xdg.configFile."hypr/scripts/lock.sh".source = ../../configs/hypr/scripts/lock.sh;
    xdg.configFile."hypr/scripts/watchdog.sh".source = ../../configs/hypr/scripts/watchdog.sh;
  };
}
