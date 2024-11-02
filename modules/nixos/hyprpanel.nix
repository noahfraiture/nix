{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    hyprpanel
  ];
}
