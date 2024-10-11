{ pkgs, lib, ... }:

{
  imports = [
    ../../sway # Import the default sway config.
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
}
