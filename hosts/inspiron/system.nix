{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true; # optimise at every build
  };

  environment.systemPackages = [
    pkgs.dell-command-configure
  ];

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
    # storageDriver = "btrfs";
    daemon.settings = {
      userland-proxy = false;
    };
  };

  networking.hostName = "inspiron";
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_TRESH_BAT0 = 40;
        STOP_CHARGE_TRESH_BAT0 = 80;
      };
    };
    blueman.enable = true;
    upower.enable = true;
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
