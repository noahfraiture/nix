{ config, ... }:
{
  # TODO : add dual gpu handling
  hardware.graphics.enable = true;

  # hardware.nvidia-container-toolkit.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = true; # nvidia opti
    };

    # TODO : remove ?
    open = true;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    # Disable gpu when not needed.
    # NOTE: could change this with a clamshell mode and multiple boot
    # configuration.
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };
}
