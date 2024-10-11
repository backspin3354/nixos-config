{ config, pkgs, ... }:

{
  imports = [
    ../../nixos/sway
    ./hardware-configuration.nix
  ];

  # Use `systemd-boot` for the bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Install the driver for my desktop's WiFi adapter.
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ rtl88x2bu ];
    blacklistedKernelModules = [ "rtw88_8822bu" ];
  };

  # Use `networkmanager` for managing internet connections.
  networking.networkmanager.enable = true;

  system.stateVersion = "24.05";
}
