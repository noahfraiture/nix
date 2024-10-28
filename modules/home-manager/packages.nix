{
  pkgs,
  config,
  lib,
  ...
}:

let

  gui = with pkgs; [
    # Gui
    bruno
    gparted
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

  ];

  language = with pkgs; [
    # Language
    python3
    cargo
    go
    deno
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
  };

}
