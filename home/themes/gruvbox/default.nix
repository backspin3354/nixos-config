{ pkgs, ... }:

{
  # Cursor
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
  
  # GTK
  gtk = {
    enable = true;
    theme = {
      package = pkgs.gruvbox-gtk-theme;
      name = "Gruvbox-Dark";
    };
    iconTheme = {
      package = pkgs.gruvbox-plus-icons;
      name = "Gruvbox-Plus-Dark";
    };
  };

  # Sway
  wayland.windowManager.sway.config.fonts = {
    names = [ "monospace" ];
    size = 10.0;
  };
  
  # Foot
  programs.foot.settings = {
    colors = {
      alpha = 0.8;
      background = "1d2021";
      foreground = "ebdbb2";
      regular0 = "282828";
      regular1 = "cc241d";
      regular2 = "98971a";
      regular3 = "d79921";
      regular4 = "458588";
      regular5 = "b16286";
      regular6 = "689d6a";
      regular7 = "a89984";
      bright0 = "928374";
      bright1 = "fb4934";
      bright2 = "b8bb26";
      bright3 = "fabd2f";
      bright4 = "83a598";
      bright5 = "d3869b";
      bright6 = "8ec07c";
      bright7 = "ebdbb2";
    };
  };

  # Helix
  programs.helix = {
    settings = {
      theme = "gruvbox_dark_hard_transparent";
    };
    themes = {
      gruvbox_dark_hard_transparent = {
        inherits = "gruvbox_dark_hard";
        "ui.background" = {};
      };
    };
  };

  # BTOP++
  programs.btop.settings = {
    color_theme = "gruvbox_dark";
    theme_background = false;
    rounded_corners = false;
  };

  # Firefox
  programs.firefox.policies = {
    ExtensionSettings = let
      extension = shortId: uuid: {
        name = uuid;
        value = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    in builtins.listToAttrs [
      (extension "gruvbox-dark-theme" "{eb8c4a94-e603-49ef-8e81-73d3c4cc04ff}")
    ];
  };
}
