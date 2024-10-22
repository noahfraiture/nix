{ pkgs, ... }:

{
  stylix.targets.helix.enable = false;

  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {

      theme = "catppuccin-mocha";

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

    themes = {
      catppuccin-mocha = let
        yellow = "#E5C07B";
        blue = "#61AFEF";
        red = "#E06C75";
        purple = "#C678DD";
        green = "#98C379";
        gold = "#D19A66";
        cyan = "#56B6C2";
        white = "#ABB2BF";
        bg = "#1E1E2F";
        light-bg = "#32324e";
        gray = "#3E4452";
        faint-gray = "#3B4048";
        light-gray = "#5C6370";
        linenr = "#4B5263";
      in {
        "tag" = { fg = red; };
        "attribute" = { fg = yellow; };
        "comment" = { fg = light-gray; modifiers = ["italic"]; };
        "constant" = { fg = cyan; };
        "constant.numeric" = { fg = gold; };
        "constant.builtin" = { fg = gold; };
        "constant.character.escape" = { fg = gold; };
        "constructor" = { fg = blue; };
        "function" = { fg = blue; };
        "function.builtin" = { fg = blue; };
        "function.macro" = { fg = purple; };
        "keyword" = { fg = purple; };
        "keyword.control" = { fg = purple; };
        "keyword.control.import" = { fg = red; };
        "keyword.directive" = { fg = purple; };
        "label" = { fg = purple; };
        "namespace" = { fg = blue; };
        "operator" = { fg = purple; };
        "keyword.operator" = { fg = purple; };
        "special" = { fg = blue; };
        "string" = { fg = green; };
        "type" = { fg = yellow; };
        # "variable" = { fg = blue; };
        "variable.builtin" = { fg = blue; };
        "variable.parameter" = { fg = red; };
        "variable.other.member" = { fg = cyan; };

        "markup.heading" = { fg = red; };
        "markup.raw.inline" = { fg = green; };
        "markup.bold" = { fg = gold; modifiers = ["bold"]; };
        "markup.italic" = { fg = purple; modifiers = ["italic"]; };
        "markup.strikethrough" = { modifiers = ["crossed_out"]; };
        "markup.list" = { fg = red; };
        "markup.quote" = { fg = yellow; };
        "markup.link.url" = { fg = cyan; modifiers = ["underlined"]; };
        "markup.link.text" = { fg = purple; };

        "diff.plus" = green;
        "diff.delta" = gold;
        "diff.minus" = red;

        "diagnostic.info.underline" = { color = blue; style = "curl"; };
        "diagnostic.hint.underline" = { color = green; style = "curl"; };
        "diagnostic.warning.underline" = { color = yellow; style = "curl"; };
        "diagnostic.error.underline" = { color = red; style = "curl"; };
        "diagnostic.unnecessary" = { modifiers = ["dim"]; };
        "diagnostic.deprecated" = { modifiers = ["crossed_out"]; };
        "info" = { fg = blue; modifiers = ["bold"]; };
        "hint" = { fg = green; modifiers = ["bold"]; };
        "warning" = { fg = yellow; modifiers = ["bold"]; };
        "error" = { fg = red; modifiers = ["bold"]; };

        "ui.background" = { bg = bg; };
        "ui.virtual" = { fg = faint-gray; };
        "ui.virtual.indent-guide" = { fg = faint-gray; };
        "ui.virtual.whitespace" = { fg = light-bg; };
        "ui.virtual.ruler" = { bg = gray; };
        "ui.virtual.inlay-hint" = { fg = light-gray; };
        "ui.virtual.jump-label" = { fg = light-gray; modifiers = ["bold"]; };

        "ui.cursor" = { fg = "#C3A2A2"; modifiers = ["reversed"]; };
        "ui.cursor.primary" = { fg = white; modifiers = ["reversed"]; };
        "ui.cursor.match" = { fg = blue; modifiers = ["underlined"]; };

        "ui.selection" = { bg = "#4f1717"; };
        "ui.selection.primary" = { bg = gray; };
        "ui.cursorline.primary" = { bg = light-bg; };

        "ui.highlight" = { bg = gray; };
        "ui.highlight.frameline" = { bg = "#97202a"; };

        "ui.linenr" = { fg = linenr; };
        "ui.linenr.selected" = { fg = white; };

        "ui.statusline" = { fg = white; bg = light-bg; };
        "ui.statusline.inactive" = { fg = light-gray; bg = light-bg; };
        "ui.statusline.normal" = { fg = light-bg; bg = blue; modifiers = ["bold"]; };
        "ui.statusline.insert" = { fg = light-bg; bg = green; modifiers = ["bold"]; };
        "ui.statusline.select" = { fg = light-bg; bg = purple; modifiers = [ "bold" ]; };
        "ui.bufferline" = { fg = light-gray; bg = light-bg; };
        "ui.bufferline.active" = { fg = light-bg; bg = blue; underline = { color = light-bg; style = "line"; }; };
        "ui.bufferline.background" = { bg = light-bg; };

        "ui.text" = { fg = white; };
        "ui.text.focus" = { fg = white; bg = light-bg; modifiers = ["bold"]; };

        "ui.help" = { fg = white; bg = gray; };
        "ui.popup" = { bg = gray; };
        "ui.window" = { fg = gray; };
        "ui.menu" = { fg = white; bg = gray; };
        "ui.menu.selected" = { fg = bg; bg = blue; };
        "ui.menu.scroll" = { fg = white; bg = light-gray; };

        "ui.debug" = { fg = red; };
      };
    };

    languages = {

      language-server.deno-lsp = {
        command = "deno";
        args = ["lsp"];
        config.deno.enable = true;
      };

      language-server.wakatime = {
        command = "wakatime-lsp";
      };

      language = [
        {
          name = "rust";
          auto-format = true;
          formatter.command = "rustfmt";
          language-servers = ["rust-analyzer" "wakatime"];
          # TODO : config check clippy
        }
        {
          name = "python";
          auto-format = true;
          language-servers = ["pyright" "wakatime"];
          formatter = {
            command = "black";
            args = ["--line-length" "100" "--quiet" "-"];
          };
        }
        {
          name = "bash";
          auto-format = true;
          formatter.command = "shfmt";
        }
        {
          name = "go";
          auto-format = true;
          formatter.command = "goimports";
          language-servers = ["golangci-lint-lsp" "gopls" "wakatime"];
        }
        {
          name = "svelte";
          auto-format = true;
          language-servers = ["svelteserve" "wakatime"];
        }
        {
          name = "markdown";
          auto-format = true;
          formatter.command = "marksman";
        }
        {
          name = "javascript";
          shebangs = ["deno"];
          roots = ["deno.json""deno.jsonc""package.json"];
          file-types = ["js"];
          language-servers = ["deno-lsp" "wakatime"];
          auto-format = true;
        }
        {
          name = "typescript";
          shebangs = ["deno"];
          roots = ["deno.json" "deno.jsonc" "package.json"];
          file-types = ["ts"];
          language-servers = ["deno-lsp" "wakatime"];
          auto-format = true;
        }
        {
          name = "jsx";
          shebangs = ["deno"];
          roots = ["deno.json" "deno.jsonc" "package.json"];
          file-types = ["jsx"];
          language-servers = ["deno-lsp" "wakatime"];
          auto-format = true;
        }
        {
          name = "tsx";
          shebangs = ["deno"];
          roots = ["deno.json" "deno.jsonc" "package.json"];
          file-types = ["tsx"];
          language-servers = ["deno-lsp" "wakatime"];
          auto-format = true;
        }
      ];
    };
  };

  home.packages = with pkgs; [
    helix
    clang-tools              # lsp C
    nil                      # lsp nix, NOTE: no formatter since it's ugly
    rust-analyzer            # lsp rust
    rustfmt                  # formatter rust
    pyright                  # lsp python
    black                    # formatter python
    bash-language-server     # formatter bash
    shfmt                    # formatter bash
    marksman                 # lsp markdown
    gopls                    # lsp go
    gotools                  # contains goimports formatter go
    golangci-lint            # linter go
    golangci-lint-langserver # lsp needed for the go linter
    texlab
    svelte-language-server

    # Add wakatime-lsp installation
    (rustPlatform.buildRustPackage {
      pname = "wakatime-lsp";
      version = "v0.1.1";
      src = fetchFromGitHub {
        owner = "mrnossiom";
        repo = "wakatime-lsp";
        rev = "552fbbcc5fc0f8cf3122daad63bb4eb1497bbc76";
        hash = "sha256-bvkig0TLiorNp7Lxer8ZRJQGB3C8lVJ96H2+SwYIT6s=";
      };
      cargoHash = "sha256-s1qmtykd2Jigx/+DtZLsPpl7lRm+d5EUI7cv5HyHr2c=";
    })
  ];
}
