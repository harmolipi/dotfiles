{ pkgs, ... }: {
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # LSPs
    lua-language-server
    nil
    elixir-ls

    # Formatters
    nixpkgs-fmt
    stylua
    selene
    nodePackages.prettier
    mdformat
  ];

  programs.nushell = {
    enable = true;

    extraEnv = ''
      # Initialize zoxide
      zoxide init nushell | save -f ~/.zoxide.nu
      oh-my-posh init nu --config ~/.config/catppuccin.omp.json
    '';

    extraConfig = ''
        # Basic alias
        alias ll = ls
        alias lla = ls -a

        # For direnv integration
        def --env nuenv [] { direnv export json | from json | default {} | load-env }
        alias nue = nuenv

        # Load zoxide
        source ~/.zoxide.nu

        # Completions
        let carapace_completer = {|spans: list<string>|
          carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
        }
    
        $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

        let zoxide_completer = {|spans|
          $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
        }

        let multiple_completers = {|spans|
          let expanded_alias = scope aliases
          | where name == $spans.0
          | get -i 0.expansion

          let spans = if $expanded_alias != null {
            $spans
            | skip 1
            | prepend ($expanded_alias | split row ' ' | take 1)
          } else {
            $spans
          }

          match $spans.0 {
            __zoxide_z | __zoxide_zi => $zoxide_completer
            _ => $carapace_completer
          } | do $in $spans
        }
    
        # Disable welcome banner and configure UI
        $env.config = {
          show_banner: false
          render_right_prompt_on_last_line: true
          edit_mode: vi
          cursor_shape: {
            vi_insert: line  # Line shape in insert mode
            vi_normal: block # Block shape in normal mode
          }
          history: {
            max_size: 100000
            sync_on_enter: true
            file_format: "plaintext"
          }
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
            external: {
              enable: true
              max_results: 100
              completer: $multiple_completers
            }
          }
          hooks: {
            pre_prompt: [{
              code: "
                # Set custom prompt indicators
                $env.PROMPT_INDICATOR = ' '
                $env.PROMPT_INDICATOR_VI_INSERT = '  '
                $env.PROMPT_INDICATOR_VI_NORMAL = '· '
                $env.PROMPT_MULTILINE_INDICATOR = ' '

                # Custom history search indicator (remove question mark)
                $env.HISTORY_SEARCH_INDICATOR = ' '
            "
          }]
        }
        menus: [
          {
              name: completion_menu
              only_buffer_difference: false
              marker: "| "
              type: {
                  layout: columnar
                  columns: 4
                  col_width: 20
                  col_padding: 2
              }
              style: {
                  text: green
                  selected_text: green_reverse
                  description_text: yellow
              }
          }
          {
              name: history_menu
              only_buffer_difference: true
              marker: "? "
              type: {
                  layout: list
                  page_size: 10
              }
              style: {
                  text: green
                  selected_text: { fg: "#24273A" bg: "#8AADF4" attr: b }
                  description_text: yellow
              }
          }
      ]
        color_config: {
          # Catppuccin Macchiato-inspired colors
          primitive_binary: "#f4dbd6"  # Pink
          primitive_boolean: "#f4dbd6"  # Pink
          primitive_date: "#f5bde6"     # Pink
          primitive_duration: "#f5bde6"  # Pink
          primitive_number: "#f5bde6"    # Pink
          primitive_string: "#a6da95"    # Green
          separator: "#8087a2"           # Gray
          leading_trailing_space_bg: "#363a4f"
          header: "#8aadf4"              # Blue
          empty: "#6e738d"              # Gray
          binary: "#f4dbd6"             # Pink
          bool: "#f4dbd6"               # Pink
          int: "#f5bde6"                # Pink
          filesize: "#f5bde6"           # Pink
          duration: "#f5bde6"           # Pink
          date: "#f5bde6"               # Pink
          range: "#f5bde6"              # Pink
          float: "#f5bde6"              # Pink
          string: "#a6da95"             # Green
          nothing: "#6e738d"            # Gray
          record: "#8aadf4"             # Blue
          list: "#8aadf4"               # Blue
          block: "#8aadf4"              # Blue
          hints: "#6e738d"              # Gray
          search_result: {
            fg: "#24273a"               # Base
            bg: "#f4dbd6"               # Pink
          }
        }
        keybindings: [
          {
              name: history_menu_down
              modifier: control
              keycode: char_j
              mode: [emacs, vi_normal, vi_insert]
              event: { send: menudown }
          }
          {
              name: history_menu_up
              modifier: control
              keycode: char_k
              mode: [emacs, vi_normal, vi_insert]
              event: { send: menuup }
          }
        ]
      }
    
      $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
      )

      source ~/.oh-my-posh.nu
    '';
  };

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };
}
