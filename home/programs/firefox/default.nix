{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    policies = {
      DisablePocket = true;
      OfferToSaveLogins = false;
      Homepage.StartPage = "homepage-locked";
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
