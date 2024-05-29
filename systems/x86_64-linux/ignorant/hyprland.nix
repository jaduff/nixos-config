# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  nix.settings = {
    substituters = ["https://hyprland.cachix.org" "https://nixpkgs-wayland.cachix.org" "https://cache.nixos.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA=" ""cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=""];
  };
    programs.hyprland = {
    enable = true;
  };
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
  ];
}

