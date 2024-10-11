{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "monospace:size=10";
      };
    };
  };
  
  programs.tofi.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = {
      defaultWorkspace = "workspace number 1";
      modifier = "Mod4";
      terminal = "footclient";
      menu = "tofi-drun | xargs swaymsg exec --";
    };
  };
}
