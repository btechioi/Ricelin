{
  description = ''
    Thumbnail decode cage: clipboard bytes and wallpaper files are untrusted
    input to ImageMagick. Only plain raster coders may run; delegates, the
    MVG/MSL/PS/text family and indirect @file reads are the historical RCE
    vectors and stay off. Activated via MAGICK_CONFIGURE_PATH in
    cliphist-thumbs.sh and wallpaper-thumbs.sh.
  '';
  policymap = [
    { domain = "delegate"; rights = "none"; pattern = "*"; }
    { domain = "filter"; rights = "none"; pattern = "*"; }
    { domain = "coder"; rights = "none"; pattern = "*"; }
    { domain = "coder"; rights = "read | write"; pattern = "{PNG,JPEG,JPG,GIF,WEBP,BMP,TIFF}"; }
    { domain = "path"; rights = "none"; pattern = "@*"; }
    { domain = "resource"; name = "memory"; value = "256MiB"; }
    { domain = "resource"; name = "map"; value = "512MiB"; }
    { domain = "resource"; name = "disk"; value = "1GiB"; }
    { domain = "resource"; name = "time"; value = "30"; }
  ];
}
