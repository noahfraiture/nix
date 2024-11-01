{
  config,
  lib,
  pkgs,
  ...
}:
let

  # Bonus not handled by stylix only for gruvbox
  # Other theme would require other value so it might not be convenient
  # WARN : every color is slightly different :) as stylix only use base16 colors

  base = "#${config.lib.stylix.colors.base00}";
  mantle = "#${config.lib.stylix.colors.base01}";
  surface0 = "#${config.lib.stylix.colors.base02}";
  surface1 = "#${config.lib.stylix.colors.base03}";

  surface2 = "#${config.lib.stylix.colors.base04}";
  text = "#${config.lib.stylix.colors.base05}";
  rosewater = "#${config.lib.stylix.colors.base06}";
  lavender = "#${config.lib.stylix.colors.base07}";

  red = "#${config.lib.stylix.colors.base08}";
  peach = "#${config.lib.stylix.colors.base09}";
  yellow = "#${config.lib.stylix.colors.base0A}";
  green = "#${config.lib.stylix.colors.base0B}";
  teal = "#${config.lib.stylix.colors.base0C}";
  blue = "#${config.lib.stylix.colors.base0D}";
  purple = "#${config.lib.stylix.colors.base0E}";
  flamingo = "#${config.lib.stylix.colors.base0F}";

  font = "${config.stylix.fonts.monospace.name}";
  fontSize = "${toString config.stylix.fonts.sizes.desktop}";
in
{

  home.packages = with pkgs; [
    ## Resource monitoring modules
    libgtop

    ## Bluetooth menu utilities
    bluez
    bluez-tools

    ## Copy/Paste utilities
    wl-clipboard

    ## Compiler for sass/scss
    dart-sass

    ## Brightness module for OSD
    brightnessctl

    ## Used for Tracking GPU Usage in your Dashboard (NVidia only)
    python312Packages.gpustat

    ## To switch between power profiles in the battery module
    power-profiles-daemon

    ## To take snapshots with the default snapshot shortcut in the dashboard
    grimblast

    ## To record screen through the dashboard record shortcut
    gpu-screen-recorder

    ## To enable the eyedropper color picker with the default snapshot shortcut in the dashboard
    hyprpicker

    ## To click resource/stat bars in the dashboard and open btop
    btop
  ];

  home.activation = {
    downloads = lib.hm.dag.entryAfter [
      "writeBoundary"
    ] ''run mkdir -p ${config.home.homeDirectory}/Downloads'';
    documents = lib.hm.dag.entryAfter [
      "writeBoundary"
    ] ''mkdir -p ${config.home.homeDirectory}/Documents'';
    pictures = lib.hm.dag.entryAfter [
      "writeBoundary"
    ] ''mkdir -p ${config.home.homeDirectory}/Pictures'';
    projects = lib.hm.dag.entryAfter [
      "writeBoundary"
    ] ''mkdir -p ${config.home.homeDirectory}/Projects'';
    videos = lib.hm.dag.entryAfter [
      "writeBoundary"
    ] ''mkdir -p ${config.home.homeDirectory}/Videos'';
  };

  # wayland.windowManager.hyprland.settings.exec-once = [ "${pkgs.hyprpanel}/bin/hyprpanel" ];
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprpanel" ];

  # "*" mean : all monitors. We cna provide specific monitors with its number.
  # e.g. "2": {"left": []}
  home.file.".cache/ags/hyprpanel/options.json" = {
    text = # json
      ''
        {
          "bar.layouts": {
            "*": {
              "left": ["dashboard", "workspaces", "windowtitle", "battery", "ram", "cpu", "storage", "netstat"],
              "center": ["media", "update"],
              "right": ["volume", "network", "bluetooth", "systray", "clock", "notifications"]
            }
          },
          
          "bar.workspaces": {
            "windowtitle.label": true,
            "volume.label": true,
            "network.truncation_size": 12,
            "bluetooth.label": true,
            "clock.format": "%a %b %e  %H:%M",
            "notifications.show_total": true,

            "monitorSpecific": true,
            "hideUnoccupied": true,
            "workspaces": 5,
            "numbered_active_indicator": "highlight",
            "showWsIcons": true,
            "workspaceIconMap": {
              "[dD]iscord": "󰙯",
              "title:YouTube": "",
              "class:kitty": "󰄛",
              "class:Opera": ""
            }
          },

          "bar.customModules.storage.leftClick": "gdu",
          "bar.customModules.cpu.leftClick": "btop",
          "bar.customModules.ram.leftClick": "btop",
          "bar.customModules.netstat.leftClick": "btop",
          "bar.customModules.updates.leftClick": "rebuild",

          "menus.dashboard.stats.enable_gpu": true,

          "menus.dashboard.shortcuts.left.shortcut1.icon": "",
          "menus.dashboard.shortcuts.left.shortcut1.command": "opera",
          "menus.dashboard.shortcuts.left.shortcut1.tooltip": "Opera",
          "menus.dashboard.shortcuts.left.shortcut4.icon": "",
          "menus.dashboard.shortcuts.left.shortcut4.command": "ags -t applauncher",
          "menus.dashboard.shortcuts.left.shortcut4.tooltip": "Search Apps",

          "menus.dashboard.directories.left.directory1.label": "󰉍 Downloads",
          "menus.dashboard.directories.left.directory1.command": "kitty ${config.home.homeDirectory}/Downloads/",
          "menus.dashboard.directories.left.directory2.label": "󱧶 Documents",
          "menus.dashboard.directories.left.directory2.command": "kitty ${config.home.homeDirectory}/Documents/",
          "menus.dashboard.directories.left.directory3.label": "󰉏 Pictures",
          "menus.dashboard.directories.left.directory3.command": "kitty ${config.home.homeDirectory}/Pictures/",
          "menus.dashboard.directories.right.directory1.label": "󱂵 Home",
          "menus.dashboard.directories.right.directory1.command": "kitty ${config.home.homeDirectory}/",
          "menus.dashboard.directories.right.directory2.label": "󰚝 Projects",
          "menus.dashboard.directories.right.directory2.command": "kitty ${config.home.homeDirectory}/Projects/",
          "menus.dashboard.directories.right.directory3.label": "󰉏 Videos",
          "menus.dashboard.directories.right.directory3.command": "kitty ${config.home.homeDirectory}/Videos/",


          "theme.font.name": "${font}",
          "theme.font.size": "${fontSize}px",
          "bar.launcher.icon": "",
          "wallpaper.enable": false,
          
          "theme": {
            "bar.buttons.dashboard.enableBorder": true,
            "bar.menus.menu.notifications.scrollbar.color"                 : "${blue}",
            "bar.menus.menu.notifications.pager.label"                     : "${surface2}",
            "bar.menus.menu.notifications.pager.button"                    : "${blue}",
            "bar.menus.menu.notifications.pager.background"                : "${base}",
            "bar.menus.menu.notifications.switch.puck"                     : "${surface0}",
            "bar.menus.menu.notifications.switch.disabled"                 : "${mantle}",
            "bar.menus.menu.notifications.switch.enabled"                  : "${blue}",
            "bar.menus.menu.notifications.clear"                           : "${blue}",
            "bar.menus.menu.notifications.switch_divider"                  : "${surface0}",
            "bar.menus.menu.notifications.border"                          : "${mantle}",
            "bar.menus.menu.notifications.card"                            : "${mantle}",
            "bar.menus.menu.notifications.background"                      : "${base}",
            "bar.menus.menu.notifications.no_notifications_label"          : "${mantle}",
            "bar.menus.menu.notifications.label"                           : "${blue}",
            "bar.menus.menu.power.buttons.sleep.icon"                      : "${mantle}",
            "bar.menus.menu.power.buttons.sleep.text"                      : "${blue}",
            "bar.menus.menu.power.buttons.sleep.icon_background"           : "${blue}",
            "bar.menus.menu.power.buttons.sleep.background"                : "${base}",
            "bar.menus.menu.power.buttons.logout.icon"                     : "${mantle}",
            "bar.menus.menu.power.buttons.logout.text"                     : "${green}",
            "bar.menus.menu.power.buttons.logout.icon_background"          : "${green}",
            "bar.menus.menu.power.buttons.logout.background"               : "${base}",
            "bar.menus.menu.power.buttons.restart.icon"                    : "${mantle}",
            "bar.menus.menu.power.buttons.restart.text"                    : "${peach}",
            "bar.menus.menu.power.buttons.restart.icon_background"         : "${peach}",
            "bar.menus.menu.power.buttons.restart.background"              : "${base}",
            "bar.menus.menu.power.buttons.shutdown.icon"                   : "${mantle}",
            "bar.menus.menu.power.buttons.shutdown.text"                   : "${red}",
            "bar.menus.menu.power.buttons.shutdown.icon_background"        : "${red}",
            "bar.menus.menu.power.buttons.shutdown.background"             : "${base}",
            "bar.menus.menu.power.border.color"                            : "${mantle}",
            "bar.menus.menu.power.background.color"                        : "${base}",
            "bar.menus.menu.dashboard.monitors.disk.label"                 : "${purple}",
            "bar.menus.menu.dashboard.monitors.disk.bar"                   : "${purple}",
            "bar.menus.menu.dashboard.monitors.disk.icon"                  : "${purple}",
            "bar.menus.menu.dashboard.monitors.gpu.label"                  : "${green}",
            "bar.menus.menu.dashboard.monitors.gpu.bar"                    : "${green}",
            "bar.menus.menu.dashboard.monitors.gpu.icon"                   : "${green}",
            "bar.menus.menu.dashboard.monitors.ram.label"                  : "${yellow}",
            "bar.menus.menu.dashboard.monitors.ram.bar"                    : "${yellow}",
            "bar.menus.menu.dashboard.monitors.ram.icon"                   : "${yellow}",
            "bar.menus.menu.dashboard.monitors.cpu.label"                  : "${red}",
            "bar.menus.menu.dashboard.monitors.cpu.bar"                    : "${red}",
            "bar.menus.menu.dashboard.monitors.cpu.icon"                   : "${red}",
            "bar.menus.menu.dashboard.directories.right.bottom.color"      : "${blue}",
            "bar.menus.menu.dashboard.directories.right.top.color"         : "${teal}",
            "bar.menus.menu.dashboard.directories.left.bottom.color"       : "${red}",
            "bar.menus.menu.dashboard.directories.left.middle.color"       : "${yellow}",
            "bar.menus.menu.dashboard.directories.left.top.color"          : "${purple}",
            "bar.menus.menu.dashboard.controls.input.text"                 : "${mantle}",
            "bar.menus.menu.dashboard.controls.input.background"           : "${purple}",
            "bar.menus.menu.dashboard.controls.volume.text"                : "${mantle}",
            "bar.menus.menu.dashboard.controls.volume.background"          : "${red}",
            "bar.menus.menu.dashboard.controls.notifications.text"         : "${mantle}",
            "bar.menus.menu.dashboard.controls.notifications.background"   : "${yellow}",
            "bar.menus.menu.dashboard.controls.bluetooth.text"             : "${mantle}",
            "bar.menus.menu.dashboard.controls.wifi.text"                  : "${mantle}",
            "bar.menus.menu.dashboard.controls.disabled"                   : "${surface1}",
            "bar.menus.menu.dashboard.shortcuts.recording"                 : "${green}",
            "bar.menus.menu.dashboard.shortcuts.text"                      : "${mantle}",
            "bar.menus.menu.dashboard.shortcuts.background"                : "${blue}",
            "bar.menus.menu.dashboard.powermenu.confirmation.button_text"  : "${base}",
            "bar.menus.menu.dashboard.powermenu.confirmation.deny"         : "${purple}",
            "bar.menus.menu.dashboard.powermenu.confirmation.confirm"      : "${teal}",
            "bar.menus.menu.dashboard.powermenu.confirmation.body"         : "${rosewater}",
            "bar.menus.menu.dashboard.powermenu.confirmation.label"        : "${blue}",
            "bar.menus.menu.dashboard.powermenu.confirmation.border"       : "${mantle}",
            "bar.menus.menu.dashboard.powermenu.confirmation.background"   : "${base}",
            "bar.menus.menu.dashboard.powermenu.confirmation.card"         : "${mantle}",
            "bar.menus.menu.dashboard.powermenu.sleep"                     : "${blue}",
            "bar.menus.menu.dashboard.powermenu.logout"                    : "${green}",
            "bar.menus.menu.dashboard.powermenu.restart"                   : "${peach}",
            "bar.menus.menu.dashboard.powermenu.shutdown"                  : "${red}",
            "bar.menus.menu.dashboard.profile.name"                        : "${purple}",
            "bar.menus.menu.dashboard.border.color"                        : "${mantle}",
            "bar.menus.menu.dashboard.background.color"                    : "${base}",
            "bar.menus.menu.dashboard.card.color"                          : "${mantle}",
            "bar.menus.menu.clock.weather.hourly.temperature"              : "${purple}",
            "bar.menus.menu.clock.weather.hourly.icon"                     : "${purple}",
            "bar.menus.menu.clock.weather.hourly.time"                     : "${purple}",
            "bar.menus.menu.clock.weather.thermometer.extremelycold"       : "${blue}",
            "bar.menus.menu.clock.weather.thermometer.cold"                : "${teal}",
            "bar.menus.menu.clock.weather.thermometer.moderate"            : "${yellow}",
            "bar.menus.menu.clock.weather.thermometer.hot"                 : "${peach}",
            "bar.menus.menu.clock.weather.thermometer.extremelyhot"        : "${red}",
            "bar.menus.menu.clock.weather.stats"                           : "${purple}",
            "bar.menus.menu.clock.weather.status"                          : "${teal}",
            "bar.menus.menu.clock.weather.temperature"                     : "${rosewater}",
            "bar.menus.menu.clock.weather.icon"                            : "${purple}",
            "bar.menus.menu.clock.calendar.contextdays"                    : "${surface1}",
            "bar.menus.menu.clock.calendar.days"                           : "${rosewater}",
            "bar.menus.menu.clock.calendar.currentday"                     : "${purple}",
            "bar.menus.menu.clock.calendar.paginator"                      : "${purple}",
            "bar.menus.menu.clock.calendar.weekdays"                       : "${purple}",
            "bar.menus.menu.clock.calendar.yearmonth"                      : "${teal}",
            "bar.menus.menu.clock.time.timeperiod"                         : "${teal}",
            "bar.menus.menu.clock.time.time"                               : "${purple}",
            "bar.menus.menu.clock.text"                                    : "${rosewater}",
            "bar.menus.menu.clock.border.color"                            : "${mantle}",
            "bar.menus.menu.clock.background.color"                        : "${base}",
            "bar.menus.menu.clock.card.color"                              : "${mantle}",
            "bar.menus.menu.battery.slider.puck"                           : "${surface1}",
            "bar.menus.menu.battery.slider.backgroundhover"                : "${surface0}",
            "bar.menus.menu.battery.slider.background"                     : "${surface1}",
            "bar.menus.menu.battery.slider.primary"                        : "${yellow}",
            "bar.menus.menu.battery.icons.active"                          : "${yellow}",
            "bar.menus.menu.battery.icons.passive"                         : "${surface2}",
            "bar.menus.menu.battery.listitems.active"                      : "${yellow}",
            "bar.menus.menu.battery.listitems.passive"                     : "${rosewater}",
            "bar.menus.menu.battery.text"                                  : "${rosewater}",
            "bar.menus.menu.battery.label.color"                           : "${yellow}",
            "bar.menus.menu.battery.border.color"                          : "${mantle}",
            "bar.menus.menu.battery.background.color"                      : "${base}",
            "bar.menus.menu.battery.card.color"                            : "${mantle}",
            "bar.menus.menu.systray.dropdownmenu.divider"                  : "${base}",
            "bar.menus.menu.systray.dropdownmenu.text"                     : "${rosewater}",
            "bar.menus.menu.systray.dropdownmenu.background"               : "${base}",
            "bar.menus.menu.bluetooth.iconbutton.active"                   : "${blue}",
            "bar.menus.menu.bluetooth.iconbutton.passive"                  : "${rosewater}",
            "bar.menus.menu.bluetooth.icons.active"                        : "${blue}",
            "bar.menus.menu.bluetooth.icons.passive"                       : "${surface2}",
            "bar.menus.menu.bluetooth.listitems.active"                    : "${blue}",
            "bar.menus.menu.bluetooth.listitems.passive"                   : "${rosewater}",
            "bar.menus.menu.bluetooth.switch.puck"                         : "${surface0}",
            "bar.menus.menu.bluetooth.switch.disabled"                     : "${mantle}",
            "bar.menus.menu.bluetooth.switch.enabled"                      : "${blue}",
            "bar.menus.menu.bluetooth.switch_divider"                      : "${surface0}",
            "bar.menus.menu.bluetooth.status"                              : "${surface1}",
            "bar.menus.menu.bluetooth.text"                                : "${rosewater}",
            "bar.menus.menu.bluetooth.label.color"                         : "${blue}",
            "bar.menus.menu.bluetooth.border.color"                        : "${mantle}",
            "bar.menus.menu.network.icons.passive"                         : "${surface2}",
            "bar.menus.menu.network.listitems.passive"                     : "${rosewater}",
            "bar.menus.menu.network.text"                                  : "${rosewater}",
            "bar.menus.menu.network.border.color"                          : "${mantle}",
            "bar.menus.menu.network.background.color"                      : "${base}",
            "bar.menus.menu.network.card.color"                            : "${mantle}",
            "bar.menus.menu.volume.input_slider.puck"                      : "${surface1}",
            "bar.menus.menu.volume.input_slider.backgroundhover"           : "${surface0}",
            "bar.menus.menu.volume.input_slider.background"                : "${surface1}",
            "bar.menus.menu.volume.input_slider.primary"                   : "${peach}",
            "bar.menus.menu.volume.audio_slider.puck"                      : "${surface1}",
            "bar.menus.menu.volume.audio_slider.backgroundhover"           : "${surface0}",
            "bar.menus.menu.volume.audio_slider.background"                : "${surface1}",
            "bar.menus.menu.volume.audio_slider.primary"                   : "${peach}",
            "bar.menus.menu.volume.icons.active"                           : "${peach}",
            "bar.menus.menu.volume.icons.passive"                          : "${surface2}",
            "bar.menus.menu.volume.iconbutton.active"                      : "${peach}",
            "bar.menus.menu.volume.iconbutton.passive"                     : "${rosewater}",
            "bar.menus.menu.volume.listitems.active"                       : "${peach}",
            "bar.menus.menu.volume.listitems.passive"                      : "${rosewater}",
            "bar.menus.menu.volume.text"                                   : "${rosewater}",
            "bar.menus.menu.volume.label.color"                            : "${peach}",
            "bar.menus.menu.volume.border.color"                           : "${mantle}",
            "bar.menus.menu.volume.background.color"                       : "${base}",
            "bar.menus.menu.volume.card.color"                             : "${mantle}",
            "bar.menus.menu.media.slider.puck"                             : "${surface1}",
            "bar.menus.menu.media.slider.backgroundhover"                  : "${surface0}",
            "bar.menus.menu.media.slider.background"                       : "${surface1}",
            "bar.menus.menu.media.slider.primary"                          : "${purple}",
            "bar.menus.menu.media.buttons.text"                            : "${base}",
            "bar.menus.menu.media.buttons.background"                      : "${blue}",
            "bar.menus.menu.media.buttons.enabled"                         : "${teal}",
            "bar.menus.menu.media.buttons.inactive"                        : "${surface1}",
            "bar.menus.menu.media.border.color"                            : "${mantle}",
            "bar.menus.menu.media.card.color"                              : "${mantle}",
            "bar.menus.menu.media.background.color"                        : "${base}",
            "bar.menus.menu.media.album"                                   : "${purple}",
            "bar.menus.menu.media.artist"                                  : "${teal}",
            "bar.menus.menu.media.song"                                    : "${blue}",
            "bar.menus.tooltip.text"                                       : "${rosewater}",
            "bar.menus.tooltip.background"                                 : "${base}",
            "bar.menus.dropdownmenu.divider"                               : "${base}",
            "bar.menus.dropdownmenu.text"                                  : "${rosewater}",
            "bar.menus.dropdownmenu.background"                            : "${base}",
            "bar.menus.slider.puck"                                        : "${surface1}",
            "bar.menus.slider.backgroundhover"                             : "${surface0}",
            "bar.menus.slider.background"                                  : "${surface1}",
            "bar.menus.slider.primary"                                     : "${blue}",
            "bar.menus.progressbar.background"                             : "${surface0}",
            "bar.menus.progressbar.foreground"                             : "${blue}",
            "bar.menus.iconbuttons.active"                                 : "${blue}",
            "bar.menus.iconbuttons.passive"                                : "${rosewater}",
            "bar.menus.buttons.text"                                       : "${mantle}",
            "bar.menus.buttons.disabled"                                   : "${surface1}",
            "bar.menus.buttons.active"                                     : "${purple}",
            "bar.menus.buttons.default"                                    : "${blue}",
            "bar.menus.check_radio_button.active"                          : "${blue}",
            "bar.menus.check_radio_button.background"                      : "${mantle}",
            "bar.menus.switch.puck"                                        : "${surface0}",
            "bar.menus.switch.disabled"                                    : "${mantle}",
            "bar.menus.switch.enabled"                                     : "${blue}",
            "bar.menus.icons.active"                                       : "${blue}",
            "bar.menus.icons.passive"                                      : "${surface1}",
            "bar.menus.listitems.active"                                   : "${blue}",
            "bar.menus.listitems.passive"                                  : "${rosewater}",
            "bar.menus.popover.border"                                     : "${mantle}",
            "bar.menus.popover.background"                                 : "${mantle}",
            "bar.menus.popover.text"                                       : "${blue}",
            "bar.menus.label"                                              : "${blue}",
            "bar.menus.feinttext"                                          : "${mantle}",
            "bar.menus.dimtext"                                            : "${surface1}",
            "bar.menus.text"                                               : "${rosewater}",
            "bar.menus.border.color"                                       : "${mantle}",
            "bar.menus.cards"                                              : "${mantle}",
            "bar.menus.background"                                         : "${base}",
            "bar.buttons.modules.power.icon_background"                    : "${base}",
            "bar.buttons.modules.power.icon"                               : "${red}",
            "bar.buttons.modules.power.background"                         : "${mantle}",
            "bar.buttons.modules.weather.icon_background"                  : "${mantle}",
            "bar.buttons.modules.weather.icon"                             : "${peach}",
            "bar.buttons.modules.weather.text"                             : "${peach}",
            "bar.buttons.modules.updates.icon_background"                  : "${mantle}",
            "bar.buttons.modules.updates.background"                       : "${mantle}",
            "bar.buttons.modules.kbLayout.icon_background"                 : "${mantle}",
            "bar.buttons.modules.kbLayout.icon"                            : "${blue}",
            "bar.buttons.modules.kbLayout.text"                            : "${blue}",
            "bar.buttons.modules.kbLayout.background"                      : "${mantle}",
            "bar.buttons.modules.netstat.icon_background"                  : "${mantle}",
            "bar.buttons.modules.netstat.icon"                             : "${green}",
            "bar.buttons.modules.netstat.text"                             : "${green}",
            "bar.buttons.modules.netstat.background"                       : "${mantle}",
            "bar.buttons.modules.storage.icon_background"                  : "${mantle}",
            "bar.buttons.modules.storage.icon"                             : "${blue}",
            "bar.buttons.modules.storage.text"                             : "${blue}",
            "bar.buttons.modules.storage.background"                       : "${mantle}",
            "bar.buttons.modules.cpu.icon_background"                      : "${mantle}",
            "bar.buttons.modules.cpu.icon"                                 : "${purple}",
            "bar.buttons.modules.cpu.text"                                 : "${purple}",
            "bar.buttons.modules.cpu.background"                           : "${mantle}",
            "bar.buttons.modules.ram.icon_background"                      : "${mantle}",
            "bar.buttons.modules.ram.icon"                                 : "${yellow}",
            "bar.buttons.modules.ram.text"                                 : "${yellow}",
            "bar.buttons.modules.ram.background"                           : "${mantle}",
            "bar.buttons.notifications.total"                              : "${blue}",
            "bar.buttons.notifications.icon_background"                    : "${blue}",
            "bar.buttons.notifications.icon"                               : "${blue}",
            "bar.buttons.notifications.background"                         : "${mantle}",
            "bar.buttons.clock.icon_background"                            : "${purple}",
            "bar.buttons.clock.icon"                                       : "${purple}",
            "bar.buttons.clock.text"                                       : "${purple}",
            "bar.buttons.clock.background"                                 : "${mantle}",
            "bar.buttons.battery.icon_background"                          : "${yellow}",
            "bar.buttons.battery.icon"                                     : "${yellow}",
            "bar.buttons.battery.text"                                     : "${yellow}",
            "bar.buttons.battery.background"                               : "${mantle}",
            "bar.buttons.systray.background"                               : "${mantle}",
            "bar.buttons.bluetooth.icon_background"                        : "${blue}",
            "bar.buttons.bluetooth.icon"                                   : "${blue}",
            "bar.buttons.bluetooth.background"                             : "${mantle}",
            "bar.buttons.network.background"                               : "${mantle}",
            "bar.buttons.volume.icon_background"                           : "${peach}",
            "bar.buttons.volume.icon"                                      : "${peach}",
            "bar.buttons.volume.text"                                      : "${peach}",
            "bar.buttons.volume.background"                                : "${mantle}",
            "bar.buttons.media.icon_background"                            : "${blue}",
            "bar.buttons.media.icon"                                       : "${blue}",
            "bar.buttons.media.text"                                       : "${blue}",
            "bar.buttons.media.background"                                 : "${mantle}",
            "bar.buttons.windowtitle.icon_background"                      : "${purple}",
            "bar.buttons.windowtitle.icon"                                 : "${purple}",
            "bar.buttons.windowtitle.text"                                 : "${purple}",
            "bar.buttons.windowtitle.background"                           : "${mantle}",
            "bar.buttons.workspaces.numbered_active_underline_color"       : "${text}",
            "bar.buttons.workspaces.numbered_active_highlighted_text_color": "${base}",
            "bar.buttons.workspaces.active"                                : "${purple}",
            "bar.buttons.workspaces.occupied"                              : "${red}",
            "bar.buttons.workspaces.available"                             : "${blue}",
            "bar.buttons.workspaces.hover"                                 : "${surface0}",
            "bar.buttons.workspaces.background"                            : "${mantle}",
            "bar.buttons.dashboard.icon"                                   : "${yellow}",
            "bar.buttons.dashboard.background"                             : "${mantle}",
            "bar.buttons.icon"                                             : "${blue}",
            "bar.buttons.text"                                             : "${blue}",
            "bar.buttons.hover"                                            : "${surface0}",
            "bar.buttons.icon_background"                                  : "${mantle}",
            "bar.buttons.background"                                       : "${mantle}",
            "bar.buttons.style"                                            : "default",
            "bar.background"                                               : "${base}",
            "osd.label"                                                    : "${blue}",
            "osd.icon"                                                     : "${base}",
            "osd.bar_overflow_color"                                       : "${red}",
            "osd.bar_empty_color"                                          : "${mantle}",
            "osd.bar_color"                                                : "${blue}",
            "osd.icon_container"                                           : "${blue}",
            "osd.bar_container"                                            : "${base}",
            "notification.close_button.label"                              : "${base}",
            "notification.close_button.background"                         : "${blue}",
            "notification.labelicon"                                       : "${blue}",
            "notification.text"                                            : "${rosewater}",
            "notification.time"                                            : "${surface2}",
            "notification.border"                                          : "${mantle}",
            "notification.label"                                           : "${blue}",
            "notification.actions.text"                                    : "${mantle}",
            "notification.actions.background"                              : "${blue}",
            "notification.background"                                      : "${mantle}",
            "bar.buttons.modules.weather.border"                           : "${peach}",
            "bar.buttons.modules.kbLayout.border"                          : "${blue}",
            "bar.buttons.modules.netstat.border"                           : "${green}",
            "bar.buttons.modules.storage.border"                           : "${blue}",
            "bar.buttons.modules.cpu.border"                               : "${purple}",
            "bar.buttons.modules.ram.border"                               : "${yellow}",
            "bar.buttons.notifications.border"                             : "${blue}",
            "bar.buttons.clock.border"                                     : "${purple}",
            "bar.buttons.battery.border"                                   : "${yellow}",
            "bar.buttons.bluetooth.border"                                 : "${blue}",
            "bar.buttons.volume.border"                                    : "${peach}",
            "bar.buttons.media.border"                                     : "${blue}",
            "bar.buttons.windowtitle.border"                               : "${purple}",
            "bar.buttons.workspaces.border"                                : "${text}",
            "bar.buttons.dashboard.border"                                 : "${yellow}",
            "bar.buttons.modules.submap.background"                        : "${mantle}",
            "bar.buttons.modules.submap.text"                              : "${teal}",
            "bar.buttons.modules.submap.border"                            : "${teal}",
            "bar.buttons.modules.submap.icon"                              : "${teal}",
            "bar.buttons.modules.submap.icon_background"                   : "${mantle}"
          }
        }
      '';
  };
}
