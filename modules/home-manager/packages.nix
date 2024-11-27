{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:

let

  gui = with pkgs; [
    # Gui

    bruno
    firefox-devedition
    gparted # FIXME ? 
    obsidian
    onlyoffice-bin
    opera
    qbittorrent
    quickemu
    spotify
    vlc
    vscode
    zed-editor

  ];

  shell = with pkgs; [
    # Shell
    btop # Hardware tracker
    carapace # shell completion
    fastfetch # Repo information
    gdu # Disk tracker
    lazydocker # Docker manager
    nvtopPackages.full # GPU tracker
    onefetch # Information about git repo
    powertop # Power tracker
    p7zip # zip tool
    rainfrog # db management tool
    ripgrep # Search for substring
    yazi # file explorer

  ];

  language = with pkgs; [
    # Language
    cargo
    deno
    go
    python3
    texliveFull
  ];

in
{

  options = {
    gui.enable = lib.mkEnableOption "GUI applications";
    shell.enable = lib.mkEnableOption "Shell tools";
    language.enable = lib.mkEnableOption "Language tools";
    exegol.enable = lib.mkEnableOption "Exegol tools";
    wakatime.enable = lib.mkEnableOption "Wakatime tools";
    lazygit.enable = lib.mkEnableOption "Lazygit";
  };

  config = {
    home.packages =
      [
        pkgs.flatpak
        pkgs.wol
        pkgs.wineWowPackages.waylandFull
      ]
      ++ (if config.gui.enable then gui else [ ])
      ++ (if config.shell.enable then shell else [ ])
      ++ (if config.language.enable then language else [ ])
      ++ (if config.exegol.enable then [ pkgs.exegol ] else [ ])
      ++ (if config.wakatime.enable then [ pkgs.wakatime ] else [ ])
      ++ (if config.lazygit.enable then [ pkgs.lazygit ] else [ ]);

    programs.lazygit = lib.mkIf config.lazygit.enable {
      enable = true;
      settings = {
        os.editPreset = "hx";
        services."github.com" = "github:github.com";
        notARepository = "skip";
      };
    };

    programs.gpg = lib.mkIf config.shell.enable {
      enable = true;
    };
  };

}
