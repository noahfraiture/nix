{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+shift+esc" = "no_op";
      "ctrl+shift+t" = "no_op";
      "ctrl+equal" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+backspace" = "send_text all \\x17";
    };
  };

  home.packages = with pkgs; [
    kitty
  ];
}
