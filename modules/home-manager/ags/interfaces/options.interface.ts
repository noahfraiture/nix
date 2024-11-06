interface HyprlandSetting {
  value: any;
  type: string;
  min: number;
  max: number;
}

interface Settings {
  hyprland: {
    decoration: {
      rounding: HyprlandSetting;
      active_opacity: HyprlandSetting;
      inactive_opacity: HyprlandSetting;
      blur: {
        enabled: HyprlandSetting;
        size: HyprlandSetting;
        passes: HyprlandSetting;
      };
    };
  };
  globalOpacity: number;
}
