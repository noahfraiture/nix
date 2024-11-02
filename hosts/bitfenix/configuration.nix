# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan
    ./hardware-configuration.nix
    ./system.nix
    # ./nvidia.nix

    ../../modules/nixos/default.nix
    ../../modules/nixos/tailscale.nix
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
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      # inspiron
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDksZIDlMfNKEJdCc2l5gPb+r60jzmpn+//jHjK63H1x pro@noahcode.dev"
    ];
  };
  services.getty.autologinUser = "noah";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "prohibit-password";
    };
  };

  home-manager = {
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs;
    };
    users."noah" = {
      imports = [
        ./home.nix

        ../../modules/home-manager/helix.nix
        ../../modules/home-manager/nushell.nix
        ../../modules/home-manager/packages.nix
        ../../modules/home-manager/shell.nix
        ../../modules/home-manager/starship.nix
        ../../modules/home-manager/zellij.nix

      ];

      shell.enable = true;
      language.enable = true;
      wakatime.enable = true;
      lazygit.enable = true;
    };
  };
}
