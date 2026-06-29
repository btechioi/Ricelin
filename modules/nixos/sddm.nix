{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.sddm;
  themeData = import ../../configs/sddm/themes/torii/theme.nix;
  metadata = import ../../configs/sddm/themes/torii/metadata.nix;
in
{
  options.ricelin.sddm = {
    enable = lib.mkEnableOption "Torii SDDM theme";
    user = lib.mkOption {
      type = lib.types.str;
      default = "erik";
      description = "Owner of the theme files";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ pkgs.sddm ];
    services.displayManager.sddm = {
      enable = true;
      theme = "torii";
      themePackage = pkgs.stdenvNoCC.mkDerivation {
        name = "sddm-torii-theme";
        src = ../../configs/sddm/themes/torii;
        installPhase = ''
          mkdir -p $out/share/sddm/themes/torii
          cp -r ./* $out/share/sddm/themes/torii/
          chmod -R +rX $out/share/sddm/themes/torii/
        '';
      };
      settings = {
        Theme.Current = "torii";
      };
    };
  };
}
