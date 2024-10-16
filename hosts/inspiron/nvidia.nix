{
  config,
  ...
}: {
  # TODO : add dual gpu handling
  config = {
    hardware.graphics.enable = true;

    # hardware.nvidia-container-toolkit.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;

      powerManagement = {
        enable = true;
        # finegrained = true; # nvidia opti
      };

      # TODO : remove ?
      open = true;

      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
}
