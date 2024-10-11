{ pkgs, ... }:

{
  # Use tuigreet as the session manager.
  services.greetd = {
    enable = true;
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
      tofi
    ];
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

  # Install `polkit`.
  security.polkit.enable = true;

  # Enable `gnome-keyring` when logging in.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
