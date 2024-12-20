{ lib, config, ... }: {

  programs.zoxide.enableNushellIntegration = true;
  programs.atuin.enableNushellIntegration = true;
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
    configFile.text = # nu
      ''
        $env.config = {
          show_banner: false
          edit_mode: vi
        }
        $env.EDITOR = "hx"
        $env.VISUAL = "hx"

        def rebuild [name] = {sudo nixos-rebuild switch --flake $"/etc/nixos/#($name)"}

        # use wlan on local network to awake bitfenix server.
        # Must be on same local network
        def awake [name] = {
          match $name {
            "bitfenix" => { wol d8:bb:c1:52:6c:f0 }
            _ => "MAC not known"
          }
        }

        # yazi search
        def --env y [...args] {
        	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
        	yazi ...$args --cwd-file $tmp
        	let cwd = (open $tmp)
        	if $cwd != "" and $cwd != $env.PWD {
        		cd $cwd
        	}
        	rm -fp $tmp
        }

        # Function to launch a new Zellij session with the 'welcome' layout
        def zh [] {
            zellij -l welcome
        }

        # Function to run a command in Zellij with a named pane
        def zr [...args] {
            let name = $args.0
            let command = ($args | skip 1 | str join ' ')
            zellij run --name $name -- zsh -ic $command
        }

        # Function to run a command in Zellij with a floating pane
        def zrf [...args] {
            let name = $args.0
            let command = ($args | skip 1 | str join ' ')
            zellij run --name $name --floating -- zsh -ic $command
        }

        # Function to run a command in Zellij in place
        def zri [...args] {
            let name = $args.0
            let command = ($args | skip 1 | str join ' ')
            zellij run --name $name --in-place -- zsh -ic $command
        }

        # Function to edit a file in Zellij
        def ze [...args] {
            zellij edit ($args | str join ' ')
        }

        # Function to edit a file in Zellij with a floating pane
        def zef [...args] {
            zellij edit --floating ($args | str join ' ')
        }

        # Function to edit a file in Zellij in place
        def zei [...args] {
            zellij edit --in-place ($args | str join ' ')
        }
      '';

    extraConfig = # nu
      ''
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

    environmentVariables = { DIRENV_LOG_FORMAT = "''"; };
  };
}
