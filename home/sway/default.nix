{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
  };

  programs.tofi.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = {
      defaultWorkspace = "workspace number 1";
      modifier = "Mod4";
      terminal = "footclient";
      menu = "tofi-drun --terminal foot | xargs swaymsg exec --";
    };
  };
}
