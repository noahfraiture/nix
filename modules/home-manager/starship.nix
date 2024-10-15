{ pkgs, ... }:
{
  home.packages = with pkgs; [
    starship
  ];

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      right_format = ''$time'';
      battery = true;
      character = {
        success_symbol = ''[\$](bold green)'';
      };
      directory = {
        fish_style_pwd_dir_length = 3;
        truncate_to_repo = true;
      };
      time = {
        disabled = false;
      };
      cmd_duration = {
        min_time = 1000;
      };
      git_status = {
        format = "([\$ahead_behind\$staged\$modified\$untracked\$conflicted\$stashed\$deleted\$renamed\$typechanged](\$style))";
        style = "bold green";
        conflicted = "";
        deleted = "\${count} ";
        staged = "[+\($count\)](bold yellow) ";
        ahead = "⇡\${count} ";
        diverged = "⇣\${behind_count}⇡\${ahead_count} ";
        behind = "⇣\${count} ";
        modified = "[!\${count}](bold yellow) ";
        untracked = "[?\${count}](bold cyan) ";
      };

      git_branch = {
        symbol = "";
      };
    };
  }; 
}
