{ pkgs, lib, ... }:

{
  imports = [
    ../../sway # Load default sway config.

    ../../programs/firefox # Load default firefox config.

    ../../themes/gruvbox # Load some config for theming.
  ];

  programs.btop.enable = true;

  programs.git = {
    userName = "Luke J Willis";
    userEmail = "backspin3354@proton.me";
  };

  programs.helix = {
    enable = true;
    settings.editor = {
      line-number = "relative";
      lsp.display-messages = true;
    };
  };

  home.packages = with pkgs; [
    github-desktop
    aseprite
  ];

  services.wlsunset = {
    enable = true;
    sunrise = "06:00";
    temperature.day = 6500;
    sunset = "19:00";
    temperature.night = 2000;
  };

  # Setp sway wallpaper
  wayland.windowManager.sway = {
    config.output =
      let
        wallpaper = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/AngelJumbo/gruvbox-wallpapers/refs/heads/main/wallpapers/irl/forest.jpg";
          hash = "sha256-mqrwRvJmRLK3iyEiXmaw5UQPftEaqg33NhwzpZvyXws=";
        };
      in
      {
        "*" = {
          bg = "${wallpaper} fill";
        };
      };

  };
}
