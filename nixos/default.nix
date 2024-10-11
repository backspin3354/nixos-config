{ pkgs, lib, ... }:

{
  # Enable the `nix` command and flake support.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Run garbage collection daily by default.
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "daily";
    options = lib.mkDefault "--delete-older-than 1d";
  };

  # Allow "unfree" packages to be installed.
  nixpkgs.config.allowUnfree = true;

  # Set timezone.
  time.timeZone = "America/New_York";

  # Setup locale.
  i18n =
    let
      locale = "en_US.UTF-8";
    in
    {
      defaultLocale = locale;
      extraLocaleSettings = {
        LC_ADDRESS = locale;
        LC_IDENTIFICATION = locale;
        LC_MEASUREMENT = locale;
        LC_MONETARY = locale;
        LC_NAME = locale;
        LC_NUMERIC = locale;
        LC_PAPER = locale;
        LC_TELEPHONE = locale;
        LC_TIME = locale;
      };
    };

  # Install default packages.
  environment.systemPackages = with pkgs; [
    helix
    wget
    curl
    git
    fastfetch
    nix-tree
  ];
}
