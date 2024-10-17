{ ... }: {

  imports = [ ./variables-config.nix ];

  # TODO : use all from nixy config which is amazing

  config.var = {
    theme = {
      rounding = 15;
      gaps-in = 10;
      gaps-out = 10 * 2;
      active-opacity = 1;
      inactive-opacity = 0.89;
      blur = true;
      border-size = 3;
      animation-speed = "fast";
      fetch = "fastfetch";

      bar = {
        transparent = true;
        transparentButtons = false;
        floating = true;
      };
    };
  };
}
