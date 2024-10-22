{ pkgs, ... }:

{
  home.packages = with pkgs; [
    flatpak

    # Dev
    exegol
    quickemu
    wakatime

    # Gui
    bruno
    gparted
    obsidian
    onlyoffice-bin
    opera
    qbittorrent
    spotify
    vlc
    vscode
    zed-editor

    # Language
    python3
    cargo
    go
    deno
    texliveFull

    # Shell
    btop                     # Hardware tracker
    carapace                 # shell completion
    fastfetch                # Repo information
    gdu                      # Disk tracker
    lazydocker               # Docker manager
    lazygit                  # Git manager
    nvtopPackages.full       # GPU tracker
    onefetch                 # Information about git repo
    powertop                 # Power tracker
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      os.editPreset = "hx";
      services."github.com" = "github:github.com";
      notARepository = "skip";
    };
  };
}
