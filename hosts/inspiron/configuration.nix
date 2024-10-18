# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./system.nix # DONE:
    ./nvidia.nix # TODO : add double gpu
    ./hyprland.nix # TODO clean once choose what to keep

    ../../modules/nixos/default.nix
    ../../modules/nixos/stylix.nix
  ];

  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.noah = {
    isNormalUser = true;
    description = "noah";
    shell = pkgs.nushell;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  services.getty.autologinUser = "noah";

  # SSH
  services.openssh.enable = true;

  # GnuPG
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Man page completion
  documentation.man.generateCaches = true;

  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs; };
    users."noah" = {
      imports = [
        ./home.nix
        ./variables.nix
        ../../modules/home-manager/ags.nix
        ../../modules/home-manager/helix.nix
        ../../modules/home-manager/hyprland.nix
        ../../modules/home-manager/hyprpanel.nix
        ../../modules/home-manager/kitty.nix
        ../../modules/home-manager/shell.nix
        ../../modules/home-manager/starship.nix
        ../../modules/home-manager/packages.nix
      ];
    };
  };
}
