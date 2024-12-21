{ pkgs, config, ... }:

let
  github = {
    # Chevron Glance

    "\$schema" = "https://starship.rs/config-schema.json";

    "format" =
      ""
      + "[](fg:sec)"
      + "$sudo"
      + "$os"
      + "$jobs"
      + "$username"
      + "$hostname"
      + "$localip"
      + "$env_var"
      + "$git_status"
      + "$directory"
      + "$git_commit$git_state$git_metrics"
      + "$git_branch"
      + "$memory_usage"
      + "$status"
      + "[ ](fg:prim)"
      + "$cmd_duration"
      + "$line_break$character";

    add_newline = false;

    palette = "chevron_glance";

    palettes.chevron_glance = {
      prim = "#${config.lib.stylix.colors.base05}"; # Primary/Directory Background
      sec = "#${config.lib.stylix.colors.base01}"; # Accents
      primt = "#${config.lib.stylix.colors.base01}"; # Primary text color (non-glyphic)
      sudo = "#${config.lib.stylix.colors.base08}";
      user = "#${config.lib.stylix.colors.base0B}";
      host = "#${config.lib.stylix.colors.base0D}";
      ip = "#${config.lib.stylix.colors.base0D}";
      duration = "#${config.lib.stylix.colors.base06}";

      # Git Colors
      tert = "#${config.lib.stylix.colors.base01}"; # Tertiary color, mostly used for GitHub text.
      conflicted = "#${config.lib.stylix.colors.base08}";
      ahead = "#${config.lib.stylix.colors.base0C}";
      behind = "#${config.lib.stylix.colors.base09}";
      diverged = "#${config.lib.stylix.colors.base0D}";
      uptodate = "#${config.lib.stylix.colors.base0B}";
      untracked = "#${config.lib.stylix.colors.base0E}";
      stashed = "#${config.lib.stylix.colors.base07}"; # light blue
      modified = "#${config.lib.stylix.colors.base0A}";
      staged = "#${config.lib.stylix.colors.base0B}"; # sage
      renamed = "#${config.lib.stylix.colors.base0E}"; # lilac
      deleted = "#${config.lib.stylix.colors.base08}"; # pink
    };

    sudo = {
      format = "[ ]($style)";
      style = "fg:sudo bg:sec";
      disabled = false;
    };

    os = {
      format = "[$symbol ]($style)";
      style = "fg:prim bg:sec";
      disabled = false;
      symbols = {
        Alpine = "";
        Amazon = "";
        Android = "";
        Arch = "";
        CentOS = "";
        Debian = "";
        DragonFly = "🐉"; # "";
        Emscripten = "🔗";
        EndeavourOS = ""; # "";
        Fedora = "";
        FreeBSD = "";
        Garuda = "";
        Gentoo = "";
        HardenedBSD = "聯";
        Illumos = "🐦";
        Linux = "";
        Macos = "";
        Manjaro = "";
        Mariner = "";
        MidnightBSD = "🌘";
        Mint = "";
        NetBSD = "";
        NixOS = "";
        OpenBSD = ""; # "";
        OpenCloudOS = "☁️";
        openEuler = "";
        openSUSE = "";
        OracleLinux = "⊂⊃";
        Pop = ""; # "";
        Raspbian = "";
        Redhat = "";
        RedHatEnterprise = "";
        Redox = "🧪";
        Solus = ""; # " ";
        SUSE = "";
        Ubuntu = "";
        Unknown = "";
        Windows = "";
      };
    };

    jobs = {
      format = "[]($style)[$symbol$number](fg:primt bg:prim)[]($style)";
      style = "fg:prim bg:sec";
      symbol = "󰇺 ";
      symbol_threshold = 1;
      number_threshold = 2;
      disabled = false;
    };

    username = {
      format = "[](fg:sec bg:user)[ $user ]($style)[](fg:user bg:sec)";
      style_user = "fg:primt bold bg:user";
      style_root = "fg:primt bold bg:sudo";
      show_always = false;
      disabled = false;
    };

    hostname = {
      format = "[ ](bg:sec)[@](fg:prim bold bg:sec)[ ](bg:sec)[](fg:sec bg:host)[$ssh_symbol](fg:primt bold bg:host)[ $hostname ](fg:primt bold bg:host)[](fg:host bg:sec)";
      ssh_only = true;
      ssh_symbol = " ";
      #trim_at = ".companyname.com";
      disabled = false;
    };

    localip = {
      format = "[](fg:sec bg:ip)[ $localipv4 ](fg:primt bold bg:ip)[](fg:ip bg:sec)";
      ssh_only = true;
      disabled = false;
    };

    git_status = {
      format = "([$all_status$ahead_behind]($style))[](fg:sec bg:prim)";
      style = "fg:prim bg:tert";
      conflicted = "[\${count}](fg:sec bold bg:conflicted)[](fg:conflicted bg:sec)";
      ahead = "[\${count}](fg:sec bold bg:ahead)[](fg:ahead bg:sec)";
      behind = "[\${count}](fg:sec bold bg:behind)[](fg:behind bg:behind)";
      diverged = "[\${count}](fg:sec bold bg:ahead)[](fg:ahead bg:sec)";
      up_to_date = "[\${count}](fg:sec bold bg:uptodate)[](fg:uptodate bg:sec)";
      untracked = "[\${count}](fg:sec bold bg:untracked)[](fg:untracked bg:sec)";
      stashed = "[\${count}](fg:sec bold bg:stashed)[](fg:stashed bg:sec)";
      modified = "[\${count}](fg:sec bold bg:modified)[](fg:modified bg:sec)";
      staged = "[\${count}](fg:sec bold bg:staged)[](fg:staged bg:sec)";
      renamed = "[\${count}](fg:sec bold bg:renamed)[](fg:renamed bg:sec)";
      deleted = "[\${count}](fg:sec bold bg:deleted)[](fg:deleted bg:sec)";
      disabled = false;
    };

    directory = {
      format = "[ ]($style)[$read_only](fg:primt bg:prim)[$repo_root]($repo_root_style)[$path](fg:primt bold bg:prim)";
      style = "fg:sec bg:prim";
      home_symbol = " ~";
      read_only = "󰉐 ";
      #read_only_style = "fg: bg:";
      truncation_length = 2;
      truncation_symbol = "…/";
      truncate_to_repo = true;
      repo_root_format = "[  ](fg:sec bg:prim)[$read_only]($read_only_style)[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[ ](bg:prim)";
      repo_root_style = "fg:sec bold bg:prim";
      use_os_path_sep = true;
      disabled = false;
    };

    directory.substitutions = {
      "Documents" = "󰈙 ";
      "Downloads" = " ";
      "Projects" = " ";
      "Music" = " ";
      "Pictures" = " ";
      "Videos" = "󰿎 ";
      "Nix" = "󱄅 ";
      ".config" = ". ";
    };

    git_branch = {
      format = "[](fg:tert bg:prim)[$symbol $branch(:$remote_branch)]($style)[](fg:tert bg:prim)";
      style = "fg:prim bold bg:tert";
      symbol = "";
    };

    memory_usage = {
      format = "[](fg:prim bg:sec)[$symbol]($style)[](fg:sec bg:prim)";
      style = "fg:sudo bg:sec";
      symbol = "  !";
      threshold = 75;
      disabled = false;
    };

    status = {
      format = "[$symbol]($style)[$status](fg:red bg:prim)";
      style = "fg:sudo bg:prim";
      symbol = "  ";
      disabled = false;
    };

    cmd_duration = {
      format = "[󰾨 $duration ]($style)";
      style = "fg:duration";
      min_time = 500;
      disabled = false;
    };

    line_break = {
      disabled = false;
    };

    character = {
      disabled = false;
      success_symbol = "[ 󱞩](bold fg:prim)";
      error_symbol = "[ 󱞩](bold fg:sudo)";
      vimcmd_symbol = "[ ](bold fg:prim)";
      vimcmd_replace_one_symbol = "[ ](bold fg:purple)";
      vimcmd_replace_symbol = "[ ](bold fg:purple)";
      vimcmd_visual_symbol = "[ ](bold fg:yellow)";
    };

    custom.nixshell = {
      disabled = false;
      shell = [
        "nu"
        "-c"
      ];
      when = # nu
        ''use std assert; let present = 'PKGS' in $env; assert true'';
      command = # nu
        ''let present = "PKGS" in $env; echo $present'';
      format = "[$symbol($output)]($style)";
      style = "fg:prim bg:sec";
    };

    env_var.NIXSHELL = {
      variable = "PKGS";
      default = "";
      format = "[$symbol($env_value)]($style)";
      style = "fg:prim bg:sec";
    };
  };

in
{
  home.packages = with pkgs; [
    starship
  ];

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = github;
  };
}
