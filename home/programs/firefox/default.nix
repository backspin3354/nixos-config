{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    policies = {
      DisablePocket = true; # Disable the built-in "Pocket" extension.
      OfferToSaveLogins = false; # Disable built-in password manager.
      Homepage.StartPage = "homepage-locked"; # Always open to the homepage.

      # Clear all of these things on shutdown.
      SanitizeOnShutdown = {
        Cookies = true;
        History = true;
        Sessions = true;
        Locked = true; # Don't allow the user to change these settings.
      };
      
      # Customize the homepage.
      FirefoxHome = {
        TopSites = false; # Disable top sites.
        SponsoredTopSites = false; # Disable sponsored sites.
        Locked = true; # Don't allow modifying the homepage.
      };

      # Install extensions.
      ExtensionSettings = let
        extension = shortId: uuid: {
          name = uuid;
          value = {
            install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      in builtins.listToAttrs [
        (extension "ublock-origin" "uBlock0@raymondhill.net") # uBlock Origin
        (extension "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me") # Proton Pass
        (extension "youtube-recommended-videos" "myallychou@gmail.com") # Unhook
      ];
    };
  };
}
