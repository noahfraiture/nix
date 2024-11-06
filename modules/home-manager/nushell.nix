{ lib, config, ... }:
{

  programs.zoxide.enableNushellIntegration = true;
  # programs.atuin.enableNushellIntegration = true;
  programs.direnv.enableNushellIntegration = true;

  # Man page completion
  programs.man.generateCaches = true;

  # Completion multi-shell
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    configFile.text = ''
      $env.config = {
        show_banner: false
        edit_mode: vi
      }
      $env.EDITOR = "hx"
      $env.VISUAL = "hx"

      def rebuild [name] = {sudo nixos-rebuild switch --flake $"/etc/nixos/#($name)"}

      def awake [name] = {
        match $name {
          "bitfenix" => { wol d8:bb:c1:52:6c:f0 }
          _ => "MAC not known"
        }
      }
    '';

    extraConfig = ''
        $env.config = {
        hooks: {
          pre_prompt: [{ ||
            if (which direnv | is-empty) {
              return
            }

            direnv export json | from json | default {} | load-env
          }]
        }
      }
    '';

    shellAliases = {
      lg = lib.mkIf config.lazygit.enable "lazygit";
      ld = "lazydocker";
      cd = "__zoxide_z";
      cdi = "__zoxide_zi";
      icat = "kitten icat";
      ssh = "kitten ssh";
      develop = "nix develop -c nu";
    };

    environmentVariables = {
      DIRENV_LOG_FORMAT = "''";
    };
  };
}
