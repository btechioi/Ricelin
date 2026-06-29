{ config, pkgs, lib, ... }:

let
  cfg = config.ricelin.imagemagick;
in
{
  options.ricelin.imagemagick = {
    enable = lib.mkEnableOption "restricted ImageMagick policy for Ricelin";
  };

  config = lib.mkIf cfg.enable {
    environment.etc."ImageMagick-7/policy.xml".source =
      ../../configs/hypr/scripts/magick-policy/policy.xml;
  };
}
