{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true; # optimise at every build
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    daemon.settings = {
      userland-proxy = false;
    };
  };

  networking.hostName = "bitfenix";
  networking.networkmanager.enable = true;
  networking.interfaces.enp4s0.wakeOnLan = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    ethtool
  ];

  services = {
    thermald.enable = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  system.stateVersion = "24.11";
}
