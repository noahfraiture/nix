{ pkgs, lib, config, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''

    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1
        

  '';
in {
  config = {

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        exec-once = ''${startupScript}/bin/start'';
      
        input = {
          kb_options = "caps:swapescape";
          kb_layout = "us";
          kb_variant = "altgr-intl";

          touchpad = {
            natural_scroll = true;
            scroll_factor = 0.7;
            disable_while_typing = false;
          };
        };

        gestures = {
          workspace_swipe = true;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
          smart_split = true;
          no_gaps_when_only = 1;
        };

        misc = {
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          force_default_wallpaper = 0;
        };

        xwayland.force_zero_scaling = true;
       
        # TODO : replace kitty by env variable
        "$mod" = "ALT";
        bind = [
          "$mod, T, exec, kitty"
          "$mod, A, exec, rofi -show drun -show-icons"
          "$mod, Q, killactive"
          "$mod, mouse:272, movewindow"
          # "$mod, mouse:273, resizewindow"
        ];

      };
    };
  };
}
