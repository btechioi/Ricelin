{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.grub;
  themeData = import ../../configs/grub/themes/torii/theme.nix;
in
{
  options.ricelin.grub = {
    enable = lib.mkEnableOption "Torii GRUB theme";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.grub = {
      theme = pkgs.stdenvNoCC.mkDerivation {
        name = "grub-torii-theme";
        src = ../../configs/grub/themes/torii;
        installPhase = ''
          mkdir -p $out
          cp -r ./* $out/
          chmod -R +rX $out/
        '';
      };
    };
  };
}
