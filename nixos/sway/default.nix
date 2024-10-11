{ pkgs, ... }:

{
  # Use tuigreet as the session manager.
  services.greetd = {
    enable = true;
    vt = 2;
    settings = {
      default_session.command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --remember-session \
          --greeting "Welcome to NixOS!"
      '';
    };
  };

  # Install the Sway window manager.
  programs.sway = {
    enable = true;
    xwayland.enable = false;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };
    extraPackages = with pkgs; [
      foot
    ];
  };

  # Set environment variables on login.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = 1; # Lets electron apps run on wayland.
  };

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # Install fonts.
  fonts = {
    packages = with pkgs; [
      # Icon fonts.
      material-design-icons

      # Normal fonts.
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # Nerdfonts.
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    # Only install the specified fonts.
    enableDefaultPackages = false;

    # Set the default fonts.
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };


  # Install `polkit`.
  security.polkit.enable = true;

  # Enable `gnome-keyring` when logging in.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
