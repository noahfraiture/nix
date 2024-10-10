{ pkgs, lib, config, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {

    # Theme is handled by stylix

      editor = {
        line-number = "relative";
        rulers = [100];
        color-modes = true;
        completion-timeout = 100;

        soft-wrap.enable = true;
        whitespace.render.newline = "all";
        file-picker.hidden = false;
        smart-tab.enable = false;
      };

      keys = {
        insert = {
          "C-s" = [":w" "normal_mode"];
        };
      
        normal = {
          "C-s" = [":w"];
          "C-j" = "jump_view_down";
          "C-k" = "jump_view_up";
          "C-h" = "jump_view_left";
          "C-l" = "jump_view_right";

          "ret" = ["open_below" "normal_mode"];
          "S-ret" = ["open_above" "normal_mode"];

          "'" = ["expand_selection"];
          "C-'" = ["shrink_selection"];

          "backspace" = ["move_char_left" "delete_selection_noyank"];

          "x" = "select_line_below";
          "X" = "select_line_above";

          "space" = {
            "v" = "vsplit";
            "h" = "hsplit";
            "n" = "select_references_to_symbol_under_cursor";
            "W" = [":toggle-option soft-wrap.enable" ":redraw"];
            "f" = "file_picker_in_current_directory";
            "F" = "file_picker";
          };
        };
      };
    };

    languages = {

      language = [
        {
          name = "rust";
          auto-format = true;
          formatter.command = "rustfmt";
          # TODO : config check clippy
        }
        {
          name = "python";
          auto-format = true;
          language-servers = ["pyright"];
          formatter = {
            command = "black";
            args = ["--line-length" "100" "--quiet" "-"];
          };
        }
        {
          name = "bash";
          formatter = {
            command = "shfmt";
            args = ["-l" "-w"];
          };
        }
        {
          name = "go";
          formatter.command = "goimports";
        }
        {
          name = "markdown";
          auto-format = true;
          formatter.command = "marksman";
        }
      ];

    };
  };

  home.packages = with pkgs; [
    helix
    # TODO : install go
    jdt-language-server # lsp java
    clang-tools         # lsp C
    nil                 # lsp nix, NOTE: no formatter since it's ugly
    rust-analyzer       # lsp rust
    rustfmt             # formatter rust
    pyright             # lsp python
    black               # formatter python
    shfmt               # formatter bash
    marksman            # lsp markdown
  ];
}
