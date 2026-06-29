{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.systemd;
in
{
  options.ricelin.systemd = {
    enable = lib.mkEnableOption "Hyprland session systemd target";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.targets.hyprland-session = {
      Unit = {
        Description = "Hyprland compositor session";
        Documentation = "man:systemd.special(7)";
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };
  };
}
