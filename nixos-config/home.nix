{ pkgs, lib, ... }: {
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # LSPs
    lua-language-server
    nil
    elixir-ls
    typescript-language-server
    gopls

    # Formatters
    nixpkgs-fmt
    nixfmt-rfc-style
    stylua
    selene
    nodePackages.prettier
    mdformat

    # CLI Tools
    fd
    ripgrep
    # Applications
    # bibletime
    ncdu
    exercism
    croc
    minigalaxy
    wineWowPackages.full
    ngrok
    jre8
    android-tools
    moonlight-qt
    xclip
    gnomecast
    lutris
    protonup-qt
    immersed

    winetricks
  ];

  programs.neovim.enable = true;

  programs.git =
    {
      enable = true;
      includes = [
        { path = "~/.gitlocalconfig"; }
      ];
      aliases = {
        st = "status";
        "; hist" = "log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all";
        df = "!git hist | peco | awk '{print $2}' | xargs -I {} git diff {}^ {}";
        br = "branch";
        open = "!hub browse";
        type = "cat-file -t";
        dump = "cat-file -p";
      };
      extraConfig = {
        user = {
          name = "Niko Birbilis";
          email = "nikob381@gmail.com";
        };
        init.defaultBranch = "main";
        color = {
          status = "auto";
          diff = "auto";
          branch = "auto";
          interactive = "auto";
          grep = "auto";
          ui = "auto";
        };
        core = {
          excludesFile = "~/.gitignore_global";
          editor = "nvim";
        };
        "diff \"lockb\"" = {
          textconv = "bun";
          binary = "true";
        };
      };
    };

  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_macchiato";

      editor = {
        scrolloff = 8;
        mouse = false;
        line-number = "relative";
        cursorline = true;
        bufferline = "multiple";
        color-modes = true;

        # Cursor shapes similar to Neovim
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        # File picker (similar to Telescope)
        # file-picker = {
        #   hidden = false;  # Enable to see hidden files
        # };

        # Status line configuration
        statusline = {
          left = [ "mode" "spinner" "file-name" "version-control" ];
          center = [ "diagnostics" ];
          right = [ "selections" "position-percentage" "file-type" ];
          separator = "|";
        };

        lsp = {
          display-inlay-hints = true;
        };

        inline-diagnostics = {
          cursor-line = "error";
        };
      };

      #   keys = {
      #     normal = {
      #       space = { 
      #         w = ":w";  # Save file with space-w
      #         q = ":q";  # Quit with space-q
      #       };
      #     };
      #   };
      # };
    };
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "catppuccin-macchiato";
      rounded_corners = true;
    };
  };

  # programs.nushell = {
  #   enable = false;
  #
  #   extraEnv = ''
  #     # Initialize zoxide
  #     zoxide init nushell | save -f ~/.zoxide.nu
  #     oh-my-posh init nu --config ~/.config/catppuccin.omp.json
  #   '';
  #
  #   extraConfig = ''
  #       # Basic alias
  #       alias ll = ls
  #       alias lla = ls -a
  #
  #       # For direnv integration
  #       def --env nuenv [] { direnv export json | from json | default {} | load-env }
  #       alias nue = nuenv
  #
  #       # Load zoxide
  #       source ~/.zoxide.nu
  #
  #       # Completions
  #       let carapace_completer = {|spans: list<string>|
  #         carapace $spans.0 nushell ...$spans
  #         | from json
  #         | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
  #       }
  #   
  #       $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
  #
  #       let zoxide_completer = {|spans|
  #         $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
  #       }
  #
  #       let multiple_completers = {|spans|
  #         let expanded_alias = scope aliases
  #         | where name == $spans.0
  #         | get -i 0.expansion
  #
  #         let spans = if $expanded_alias != null {
  #           $spans
  #           | skip 1
  #           | prepend ($expanded_alias | split row ' ' | take 1)
  #         } else {
  #           $spans
  #         }
  #
  #         match $spans.0 {
  #           __zoxide_z | __zoxide_zi => $zoxide_completer
  #           _ => $carapace_completer
  #         } | do $in $spans
  #       }
  #   
  #       # Disable welcome banner and configure UI
  #       $env.config = {
  #         show_banner: false
  #         render_right_prompt_on_last_line: true
  #         edit_mode: vi
  #         cursor_shape: {
  #           vi_insert: line  # Line shape in insert mode
  #           vi_normal: block # Block shape in normal mode
  #         }
  #         history: {
  #           max_size: 100000
  #           sync_on_enter: true
  #           file_format: "plaintext"
  #         }
  #         completions: {
  #           case_sensitive: false
  #           quick: true
  #           partial: true
  #           algorithm: "fuzzy"
  #           external: {
  #             enable: true
  #             max_results: 100
  #             completer: $multiple_completers
  #           }
  #         }
  #         hooks: {
  #           pre_prompt: [{
  #             code: "
  #               # Set custom prompt indicators
  #               $env.PROMPT_INDICATOR = ' '
  #               $env.PROMPT_INDICATOR_VI_INSERT = '  '
  #               $env.PROMPT_INDICATOR_VI_NORMAL = '· '
  #               $env.PROMPT_MULTILINE_INDICATOR = ' '
  #
  #               # Custom history search indicator (remove question mark)
  #               $env.HISTORY_SEARCH_INDICATOR = ' '
  #           "
  #         }]
  #       }
  #       menus: [
  #         {
  #             name: completion_menu
  #             only_buffer_difference: false
  #             marker: "| "
  #             type: {
  #                 layout: columnar
  #                 columns: 4
  #                 col_width: 20
  #                 col_padding: 2
  #             }
  #             style: {
  #                 text: green
  #                 selected_text: green_reverse
  #                 description_text: yellow
  #             }
  #         }
  #         {
  #             name: history_menu
  #             only_buffer_difference: true
  #             marker: "? "
  #             type: {
  #                 layout: list
  #                 page_size: 10
  #             }
  #             style: {
  #                 text: green
  #                 selected_text: { fg: "#24273A" bg: "#8AADF4" attr: b }
  #                 description_text: yellow
  #             }
  #         }
  #     ]
  #       color_config: {
  #         # Catppuccin Macchiato-inspired colors
  #         primitive_binary: "#f4dbd6"  # Pink
  #         primitive_boolean: "#f4dbd6"  # Pink
  #         primitive_date: "#f5bde6"     # Pink
  #         primitive_duration: "#f5bde6"  # Pink
  #         primitive_number: "#f5bde6"    # Pink
  #         primitive_string: "#a6da95"    # Green
  #         separator: "#8087a2"           # Gray
  #         leading_trailing_space_bg: "#363a4f"
  #         header: "#8aadf4"              # Blue
  #         empty: "#6e738d"              # Gray
  #         binary: "#f4dbd6"             # Pink
  #         bool: "#f4dbd6"               # Pink
  #         int: "#f5bde6"                # Pink
  #         filesize: "#f5bde6"           # Pink
  #         duration: "#f5bde6"           # Pink
  #         date: "#f5bde6"               # Pink
  #         range: "#f5bde6"              # Pink
  #         float: "#f5bde6"              # Pink
  #         string: "#a6da95"             # Green
  #         nothing: "#6e738d"            # Gray
  #         record: "#8aadf4"             # Blue
  #         list: "#8aadf4"               # Blue
  #         block: "#8aadf4"              # Blue
  #         hints: "#6e738d"              # Gray
  #         search_result: {
  #           fg: "#24273a"               # Base
  #           bg: "#f4dbd6"               # Pink
  #         }
  #       }
  #       keybindings: [
  #         {
  #             name: history_menu_down
  #             modifier: control
  #             keycode: char_j
  #             mode: [emacs, vi_normal, vi_insert]
  #             event: { send: menudown }
  #         }
  #         {
  #             name: history_menu_up
  #             modifier: control
  #             keycode: char_k
  #             mode: [emacs, vi_normal, vi_insert]
  #             event: { send: menuup }
  #         }
  #       ]
  #     }
  #   
  #     $env.PATH = ($env.PATH | 
  #       split row (char esep) |
  #       prepend /home/myuser/.apps |
  #       append /usr/bin/env
  #     )
  #
  #     source ~/.oh-my-posh.nu
  #   '';
  # };

  # programs.carapace.enable = true;
  # programs.carapace.enableNushellIntegration = true;

  programs.direnv = {
    enable = true;
    # enableNushellIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;

      format = ''
        $directory$git_branch$git_status
        $character '';

      # Prompt components
      directory = {
        style = "blue bold";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = " ";
        style = "green";
        format = "[$symbol$branch]($style) ";
      };

      git_status = {
        style = "yellow";
        format = "[$all_status$ahead_behind]($style) ";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
        vicmd_symbol = "[❮](bold yellow)";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f";
    defaultOptions = [ "--height 40%" "--border" ];
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [ "--preview 'ls -la {}'" "--preview-window right:60%" ];
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'cat {}'" "--preview-window right:60%" ];
    historyWidgetOptions = [ "--sort" "--exact" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
    ];

    shellAliases = {
      zshconfig = "nvim ~/.zshrc";
      ll = "eza -l -g --icons";
      lla = "eza -l -a -g --icons";
      icat = "kitty +kitten icat";
      tmuxfzf = ''tmux switch-client -n || tmux new-session -d -s $(fzf --prompt="Attach to or create session: " | awk "{print \\$1}" | sed s/:.*//)'';
      ssh = "[ \"$TERM\" = \"xterm-kitty\" ] && kitty +kitten ssh || ssh";
      d = "[ \"$TERM\" = \"xterm-kitty\" ] && kitty +kitten diff || diff";
    };

    # Pure prompt setup
    initContent = lib.mkBefore ''
      # shell

      eval "$(starship init zsh)"

      # Direnv hook
      eval "$(direnv hook zsh)"

      # Reset keymap correctly on mode change
      autoload -Uz add-zsh-hook

      function zle-line-init zle-keymap-select {
        VIMODE=""
        case $KEYMAP in
          vicmd) VIMODE="%F{yellow}[N]%f" ;;
          main|viins) VIMODE="" ;;
        esac
        zle reset-prompt
      }

      zle -N zle-line-init
      zle -N zle-keymap-select

      n () {
        [ "$''${NNNLVL:-0}" -eq 0 ] || {
          echo "nnn is already running"
          return
        }
        if [ -z "\$XDG_CONFIG_HOME" ]; then
          export NNN_TMPFILE="\$HOME/.config/nnn/.lastd"
        else
          export NNN_TMPFILE="\$XDG_CONFIG_HOME/nnn/.lastd"
        fi
        command nnn "\$@"
        [ ! -f "\$NNN_TMPFILE" ] || {
          . "\$NNN_TMPFILE"
          rm -f -- "\$NNN_TMPFILE" > /dev/null
        }
      }

      if [[ -z $${ZSH_HIGHLIGHT_STYLES+x} ]]; then
        typeset -A ZSH_HIGHLIGHT_STYLES
      fi
      # ZSH_HIGHLIGHT_STYLES[path]=none
      # ZSH_HIGHLIGHT_STYLES[path_prefix]=none
      
      # Configure key bindings for history search
      bindkey '^R' fzf-history-widget
      # Use up and down arrow keys for history navigation
      bindkey '^[[A' up-line-or-history
      bindkey '^[[B' down-line-or-history
    '';
  };

  programs.tmux = {
}
