{ pkgs, ... }:

{
  programs.waybar= {
    enable = true;

    settings = [{
      mainBar = {
        modules-left = [
          "custom/arch-pill"
          "hyprland/workspaces"
          "cpu"
          "custom/cpuinfo"
          "memory"
          "disk"
          "temperature"
          "battery"
        ];
        modules-center = [
          "mpris"
          "custom/updates"
        ];
        modules-right = [
          "tray"
          "network"
          "bluetooth"
          "custom/notifications"
          "custom/keybindhint"
          "pulseaudio"
          "backlight"
          "custom/charge"
          "clock"
        ];

        "hyprland/workspaces" = {
          on-click = "activate";
          disable-scroll = true;
          on-scroll-up = "hyprctl dispatch workspace -1";
          on-scroll-down = "hyprctl dispatch workspace +1";
          persistent-workspaces = {};
        };
        cpu = {
          format = "<span foreground='#89b4fa'></span> {usage}%";
          interval = 21;
          on-click = "kitty btop";
        };
        memory = {
          states = {
            c = 90;
            h = 60;
            m = 30; 
          };
          interval = 31;
          format = "<span foreground='#39713F'>󰾆</span> {used}+{swapUsed}GB";
          format-m = "<span foreground='#39713F'>󰾅</span> {used}+{swapUsed}GB";
          format-h = "<span foreground='#39713F'>󰓅</span> {used}+{swapUsed}GB";
          format-c = "<span foreground='#39713F'></span> {used}+{swapUsed}GB";
          format-alt = "<span foreground='#39713F'>󰾆</span> {percentage}%";
          max-length = 20;
          tooltip = true;
          tooltip-format = "󰾆 {percentage}%\n {used =0.1f}GB/{total =0.1f}GB";
        };

        disk = {
          interval = 60;
          format = "<span foreground='#f4c542'></span> {percentage_used}%";
          thresholds = {
            warning = 80;
            critical = 90;
          };
          tooltip-format = "{used} / {total} ({percentage_used}%)";
          on-click = "kitty gdu";
        };
        temperature = {
          interval = 12;
          tooltip = false;
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          thermal-zone = 2;
          critical-threshold = 62;
          format-critical = "<span foreground='#ff5050'>{icon}</span> {temperatureC}°C";
          format = "<span foreground='#eba0ac'>{icon}</span> {temperatureC}°C";
          format-icons = [
            ""
          ];
          on-click = "kitty nvtop";
        };
        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "<span foreground='#a6e3a1'>{icon}</span> {capacity}%";
          format-charging = "<span foreground='#a6e3a1'></span> {capacity}%";
          format-plugged = "<span foreground='#a6e3a1'></span> {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };
        mpris = {
          format = "{player_icon} {dynamic} ";
          max-length = 60;
          format-paused = "{status_icon} <i>{dynamic}</i> ";
          player-icons = {
            default = "▶";
            mpv = "🎵";
          };
          status-icons = {
            paused = "⏸";
          };
          interval = 12;
        };

        "custom/updates" = {
          exec = "systemupdate.sh";
          return-type = "json";
          format = "{}";
          on-click = "hyprctl dispatch exec 'systemupdate.sh up'";
          interval = 3600;
          tooltip = true;
          signal = 20;
        };
        tray = {
          spacing = 5;
          reverse-direction = 1;
        };
        network = {
          tooltip = true;
          format-wifi = " ";
          format-ethernet = "󰈀 ";
          tooltip-format = "Network = <big><b>{essid}</b></big>\nSignal strength = <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency = <b>{frequency}MHz</b>\nInterface = <b>{ifname}</b>\nIP = <b>{ipaddr}/{cidr}</b>\nGateway = <b>{gwaddr}</b>\nNetmask = <b>{netmask}</b>";
          format-linked = "󰈀 {ifname} (No IP)";
          format-disconnected = "󰖪 ";
          tooltip-format-disconnected = "Disconnected";
          format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
          interval = 9;
          max-length = 40;
        };
        bluetooth = {
          format = "";
          format-disabled = "";
          format-connected = " {num_connections}";
          format-connected-battery = "{icon} {num_connections}";
          format-icons = [ "󰥇" "󰤾" "󰤿" "󰥀" "󰥁" "󰥂" "󰥃" "󰥄" "󰥅" "󰥆" "󰥈" ];
          tooltip-format = "{controller_alias}\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{icon} {device_battery_percentage}%";
        };
        "custom/notifications" = {
          format = "{icon} {}";
          format-icons = {
            email-notification = "<span foreground='white'><sup></sup></span>";
            chat-notification = "󱋊<span foreground='white'><sup></sup></span>";
            warning-notification = "󱨪<span foreground='yellow'><sup></sup></span>";
            error-notification = "󱨪<span foreground='red'><sup></sup></span>";
            network-notification = "󱂇<span foreground='white'><sup></sup></span>";
            battery-notification = "󰁺<span foreground='white'><sup></sup></span>";
            update-notification = "󰚰<span foreground='white'><sup></sup></span>";
            music-notification = "󰝚<span foreground='white'><sup></sup></span>";
            volume-notification = "󰕿<span foreground='white'><sup></sup></span>";
            notification = "<span foreground='white'><sup></sup></span>";
            none = "";
          };
          return-type = "json";
          exec-if = "which dunstctl";
          exec = "notifications.py";
          on-click = "sleep 0.1 && dunstctl history-pop";
          on-click-middle = "dunstctl history-clear";
          on-click-right = "dunstctl close-all";
          interval = 34;
          tooltip = true;
          escape = true;
        };
        pulseaudio = {
          format = "<span size='13000' foreground='#fab387'>{icon}</span> {volume}";
          format-muted = "婢";
          on-click = "pavucontrol -t 3";
          on-click-middle = "volumecontrol.sh -o m";
          on-scroll-up = "volumecontrol.sh -o i";
          on-scroll-down = "volumecontrol.sh -o d";
          tooltip-format = "{icon} {desc}";
          scroll-step = 5;
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "";
          format-source-muted = "";
          on-click = "pavucontrol -t 4";
          on-click-middle = "volumecontrol.sh -i m";
          on-scroll-up = "volumecontrol.sh -i i";
          on-scroll-down = "volumecontrol.sh -i d";
          tooltip-format = "{format_source} {source_desc}";
          scroll-step = 5;
        };
        backlight = {
          device = "intel_backlight";
          format = "<span foreground='#f9e2af'>{icon}</span> {percent}%";
          tooltip = false;
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
          min-length = 6;
        };
        "custom/keybindhint" = {
          format = "  ";
          on-click = "keybinds_hint.sh";
        };
        "custom/charge" = {
          format = "<span foreground='#6CBD63'>󱍼</span> {}% ";
          exec = "check_charge.sh";
          interval = "once";
          on-click = "change_charge.sh; pkill -SIGRTMIN+10 waybar";
          signal = 10;
          exec-on-event = false;
        };
        clock = {
          format = "<span foreground='#c098fd'>󰃭</span> { =%a %d %b   %H =%M}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };
      };
    }];
  };

  home.packages = with pkgs; [
    waybar
  ];
}
