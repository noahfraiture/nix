{...}: {
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
    # storageDriver = "btrfs";
    daemon.settings = {
      userland-proxy = false;
    };
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true; # for gnome-bluetooth percentage
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
