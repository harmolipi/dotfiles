{ pkgs, lib, ... }: {
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # LSPs
    lua-language-server
    nil
    # elixir-ls
    typescript-language-server
    gopls
    # rPackages.languageserver
    # quarto

    # Formatters
    nixpkgs-fmt
    nixfmt-rfc-style
    stylua
    selene
    # nodePackages.prettier
    mdformat

    # CLI Tools
    fd
    ripgrep
    gemini-cli
    pandoc

    # Applications
    # bibletime
    ncdu
    # exercism
    croc
    # minigalaxy
    # wineWowPackages.full
    ngrok
    jre8
    # android-tools
    # moonlight-qt
    xclip
    google-fonts
    # gnomecast
    lutris
    # protonup-qt
    immersed
    tmux-sessionizer
    claude-code
    foliate
    calibre
    anki-bin
    mpv-unwrapped
    amfora
    flyctl
    gobang
    runescape
    bolt-launcher
    desmume
    htop-vim
    age
    sops
    inkscape

    # winetricks
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
    enable = false;
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

  # programs.zellij = {
  #   enable = true;
  #   enableZshIntegration = true;
  #   settings = {
  #     theme = "catppuccin-macchiato";
  #     rounded_corners = true;
  #   };
  # };

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

  # programs.starship = {
  #   enable = false;
  #   settings = {
  #     add_newline = true;
  #
  #     format = ''
  #       $directory$git_branch$git_status
  #       $character '';
  #
  #     # Prompt components
  #     directory = {
  #       style = "blue bold";
  #       truncation_length = 3;
  #       truncation_symbol = "…/";
  #     };
  #
  #     git_branch = {
  #       symbol = " ";
  #       style = "green";
  #       format = "[$symbol$branch]($style) ";
  #     };
  #
  #     git_status = {
  #       style = "yellow";
  #       format = "[$all_status$ahead_behind]($style) ";
  #     };
  #
  #     character = {
  #       success_symbol = "[❯](bold green)";
  #       error_symbol = "[❯](bold red)";
  #       vicmd_symbol = "[❮](bold yellow)";
  #     };
  #   };
  # };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # enableZshIntegration = false;
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
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "pure";
        src = pkgs.fetchFromGitHub {
          owner = "sindresorhus";
          repo = "pure";
          rev = "v1.23.0";
          sha256 = "1jcb5cg1539iy89vm9d59g8lnp3dm0yv88mmlhkp9zwx3bihwr06"; # `nix-prefetch-url --unpack https://github.com/sindresorhus/pure/archive/refs/tags/v1.23.0.tar.gz`
        };
      }
    ];
    # plugins = [
    #   {
    #     name = "zsh-syntax-highlighting";
    #     src = pkgs.zsh-syntax-highlighting;
    #   }
    #   {
    #     name = "zsh-autosuggestions";
    #     src = pkgs.zsh-autosuggestions;
    #   }
    # ];

    shellAliases = {
      zshconfig = "nvim ~/.zshrc";
      ll = "eza -l -g --icons";
      lla = "eza -l -a -g --icons";
      # icat = "kitty +kitten icat";
      tmuxfzf = ''tmux switch-client -n || tmux new-session -d -s $(fzf --prompt="Attach to or create session: " | awk "{print \\$1}" | sed s/:.*//)'';
      # ssh = "[ \"$TERM\" = \"xterm-kitty\" ] && kitty +kitten ssh || ssh";
      # d = "[ \"$TERM\" = \"xterm-kitty\" ] && kitty +kitten diff || diff";
    };

    initContent = lib.mkBefore ''
      # shell

      # Direnv hook
      # eval "$(direnv hook zsh)"
      direnv() {
        unfunction direnv
        eval "$(command direnv hook zsh)"
        direnv "$@"
      }

      # Reset keymap correctly on mode change
      autoload -Uz add-zsh-hook

      # function zle-line-init zle-keymap-select {
      #   VIMODE=""
      #   case $KEYMAP in
      #     vicmd) VIMODE="%F{yellow}[N]%f" ;;
      #     main|viins) VIMODE="" ;;
      #   esac
      #   zle reset-prompt
      # }
      #
      # zle -N zle-line-init
      # zle -N zle-keymap-select

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

      # bindkey '^I' autosuggest-accept
      bindkey "^H" backward-delete-char
      bindkey "^?" backward-delete-char

      eval "$(zoxide init zsh)"

      export PATH="$HOME/.config/emacs/bin:$PATH"
    '';
  };

  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    escapeTime = 10;
    baseIndex = 1;
    keyMode = "vi";
    mouse = false;

    # Prefix key
    prefix = "C-b";

    # Shell
    shell = "${pkgs.zsh}/bin/zsh";

    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      catppuccin
      yank
      {
        plugin = catppuccin;
        extraConfig = ''
          # More comprehensive terminal overrides for Ghostty
          # set -sa terminal-overrides ',xterm-ghostty:RGB'
          # set -sa terminal-overrides ',xterm-ghostty:Tc'
          # set -sa terminal-overrides ',xterm-ghostty:Ms=\\E]52;%p1%s;%p2%s\\007'
          # set -sa terminal-overrides ',xterm-ghostty:Cs=\\E]12;%p1%s\\007'
          # set -sa terminal-overrides ',xterm-ghostty:Cr=\\E]112\\007'
          # set -sa terminal-overrides ',xterm-ghostty:Ss=\\E[%p1%d q'
          # set -sa terminal-overrides ',xterm-ghostty:Se=\\E[2 q'
    
          # Disable BCE (background color erase) which can cause issues
          # set -ga terminal-overrides ',xterm-ghostty:bce@'
    
          # Focus events (can cause escape sequences with some autocomplete plugins)
          # set -g focus-events off
    
          # Alternative: if you need focus events, try:
          # set -g focus-events on
          # set -sa terminal-overrides ',xterm-ghostty:Tc:clipboard:cstyle'
          
          set -g @catppuccin_flavour 'macchiato'
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_status_modules_right "directory user host session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
    ];

    extraConfig = ''
      # Terminal overrides for Ghostty
      set -sa terminal-overrides ',xterm-ghostty:RGB'
      set -sa terminal-overrides ',xterm-ghostty:Tc'
      set -sa terminal-overrides ',ghostty:RGB'
      set -sa terminal-overrides ',ghostty:Tc'
      set -sa terminal-overrides ',xterm-256color:RGB'
      
      # Cursor shape support
      set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
      
      # Undercurl support
      set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'

      # Window options
      setw -g pane-base-index 1
      set-option -g status-justify "left"
      set-option -g status-fg cyan
      set-option -g status-bg black
      set -g pane-active-border-style fg=colour166,bg=default
      set -g window-style fg=colour10,bg=default
      set -g window-active-style fg=colour12,bg=default

      # Key bindings
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind -r e kill-pane -a
      bind-key -n C-S-Left swap-window -t -1 \; previous-window
      bind-key -n C-S-Right swap-window -t +1 \; next-window
      bind -r C-k resize-pane -U 5
      bind -r C-j resize-pane -D 5
      bind -r C-h resize-pane -L 5
      bind -r C-l resize-pane -R 5
      bind Space last-window
      bind ^ switch-client -l
      bind C-o display-popup -E "tms"
      
      # Vi mode bindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      
      # Open in current directory
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Sessionx
      # set -g @sessionx-bind 'o'
      # set -g @sessionx-zoxide-mode 'on'
      
      # Your other custom settings...
      bind-key -r f run-shell "tmux neww ~/bin/.local/scripts/tmux-sessionizer"
    '';
  };

  home.file.".config/tms/config.toml".text = ''
    [[search_dirs]]
    path = "/home/niko/Documents/coding"
    depth = 10

    [[search_dirs]]
    path = "/home/niko/dotfiles"
    depth = 10
  '';

  home.file.".config/amfora/config.toml".text = ''
    [a-general]
    # Press Ctrl-H to access it
    home = "gemini://geminiprotocol.net"

    # Follow up to 5 Gemini redirects without prompting.
    # A prompt is always shown after the 5th redirect and for redirects to protocols other than Gemini.
    # If set to false, a prompt will be shown before following redirects.
    auto_redirect = false

    # What command to run to open a HTTP(S) URL.
    # Set to "default" to try to guess the browser, or set to "off" to not open HTTP(S) URLs.
    # If a command is set, than the URL will be added (in quotes) to the end of the command.
    # A space will be prepended to the URL.
    #
    # The best way to define a command is using a string array.
    # Examples:
    # http = ['firefox']
    # http = ['custom-browser', '--flag', '--option=2']
    # http = ['/path/with spaces/in it/firefox']
    #
    # Note the use of single quotes, so that backslashes will not be escaped.
    # Using just a string will also work, but it is deprecated, and will degrade if
    # you use paths with spaces.

    http = 'default'

    # Any URL that will accept a query string can be put here
    search = "gemini://geminispace.info/search"

    # Whether colors will be used in the terminal
    color = true

    # Whether ANSI color codes from the page content should be rendered
    ansi = true

    # Whether or not to support source code highlighting in preformatted blocks based on alt text
    highlight_code = true

    # Which highlighting style to use (see https://xyproto.github.io/splash/docs/)
    highlight_style = "monokai"

    # Whether to replace list asterisks with unicode bullets
    bullets = true

    # Whether to show link after link text
    show_link = false

    # The max number of columns to wrap a page's text to. Preformatted blocks are not wrapped.
    max_width = 80

    # 'downloads' is the path to a downloads folder.
    # An empty value means the code will find the default downloads folder for your system.
    # If the path does not exist it will be created.
    # Note the use of single quotes, so that backslashes will not be escaped.
    downloads = '''

    # Max size for displayable content in bytes - after that size a download window pops up
    page_max_size = 2097152  # 2 MiB
    # Max time it takes to load a page in seconds - after that a download window pops up
    page_max_time = 10

    # When a scrollbar appears. "never", "auto", and "always" are the only valid values.
    # "auto" means the scrollbar only appears when the page is longer than the window.
    scrollbar = "auto"

    # Underline non-gemini URLs
    # This is done to help color blind users
    underline = true


    [auth]
    # Authentication settings
    # Note the use of single quotes for values, so that backslashes will not be escaped.

    [auth.certs]
    # Client certificates
    # Set URL equal to path to client cert file
    #
    # "example.com" = 'mycert.crt'      # Cert is used for all paths on this domain
    # "example.com/dir/"=  'mycert.crt' # Cert is used for /dir/ and everything below only
    #
    # See the comment at the beginning of this file for examples of all valid types of
    # URLs, ports and schemes can be used too

    [auth.keys]
    # Client certificate keys
    # Same as [auth.certs] but the path is to the client key file.


    [keybindings]
    # If you have a non-US keyboard, use bind_tab1 through bind_tab0 to
    # setup the shift-number bindings: Eg, for US keyboards (the default):
    # bind_tab1 = "!"
    # bind_tab2 = "@"
    # bind_tab3 = "#"
    # bind_tab4 = "$"
    # bind_tab5 = "%"
    # bind_tab6 = "^"
    # bind_tab7 = "&"
    # bind_tab8 = "*"
    # bind_tab9 = "("
    # bind_tab0 = ")"

    # Whitespace is not allowed in any of the keybindings! Use 'Space' and 'Tab' to bind to those keys.
    # Multiple keys can be bound to one command, just use a TOML array.
    # To add the Alt modifier, the binding must start with Alt-, should be reasonably universal
    # Ctrl- won't work on all keys, see this for a list:
    # https://github.com/gdamore/tcell/blob/cb1e5d6fa606/key.go#L83

    # An example of a TOML array for multiple keys being bound to one command is the default
    # binding for reload:
    # bind_reload = ["R","Ctrl-R"]
    # One thing to note here is that "R" is capitalization sensitive, so it means shift-r.
    # "Ctrl-R" means both ctrl-r and ctrl-shift-R (this is a quirk of what ctrl-r means on
    # an ANSI terminal)

    # The default binding for opening the bottom bar for entering a URL or link number is:
    # bind_bottom = "Space"
    # This is how to get the Spacebar as a keybinding, if you try to use " ", it won't work.
    # And, finally, an example of a simple, unmodified character is:
    # bind_edit = "e"
    # This binds the "e" key to the command to edit the current URL.

    # The bind_link[1-90] options are for the commands to go to the first 10 links on a page,
    # typically these are bound to the number keys:
    # bind_link1 = "1"
    # bind_link2 = "2"
    # bind_link3 = "3"
    # bind_link4 = "4"
    # bind_link5 = "5"
    # bind_link6 = "6"
    # bind_link7 = "7"
    # bind_link8 = "8"
    # bind_link9 = "9"
    # bind_link0 = "0"

    # All keybindings:
    #
    # bind_bottom
    # bind_edit
    # bind_home
    # bind_bookmarks
    # bind_add_bookmark
    # bind_save
    # bind_reload
    # bind_back
    # bind_forward
    # bind_moveup
    # bind_movedown
    # bind_moveleft
    # bind_moveright
    # bind_pgup
    # bind_pgdn
    # bind_new_tab
    # bind_close_tab
    # bind_next_tab
    # bind_prev_tab
    # bind_quit
    # bind_help
    # bind_sub: for viewing the subscriptions page
    # bind_add_sub
    # bind_copy_page_url
    # bind_copy_target_url
    # bind_beginning: moving to beginning of page (top left)
    # bind_end: same but the for the end (bottom left)
    # bind_url_handler_open: Open highlighted URL with URL handler (#143)

    [url-handlers]
    # Allows setting the commands to run for various URL schemes.
    # E.g. to open FTP URLs with FileZilla set the following key:
    #   ftp = ['filezilla']
    # You can set any scheme to 'off' or ''' to disable handling it, or
    # just leave the key unset.
    #
    # DO NOT use this for setting the HTTP command.
    # Use the http setting in the "a-general" section above.
    #
    # NOTE: These settings are overrided by the ones in the proxies section.
    #
    # The best way to define a command is using a string array.
    # Examples:
    # magnet = ['transmission']
    # foo = ['custom-browser', '--flag', '--option=2']
    # tel = ['/path/with spaces/in it/telephone']
    #
    # Note the use of single quotes, so that backslashes will not be escaped.
    # Using just a string will also work, but it is deprecated, and will degrade if
    # you use paths with spaces.

    # This is a special key that defines the handler for all URL schemes for which
    # no handler is defined.
    # It uses the special value 'default', which will try and use the default
    # application on your computer for opening this kind of URI.
    other = 'default'

    [url-prompts]
    # Specify whether a confirmation prompt should be shown before following URL schemes.
    # The special key 'other' matches all schemes that don't match any other key.
    #
    # Example: prompt on every non-gemini URL
    # other = true
    # gemini = false
    #
    # Example: only prompt on HTTP(S)
    # other = false
    # http = true
    # https = true

    # [[mediatype-handlers]] section
    # ---------------------------------
    #
    # Specify what applications will open certain media types.
    # By default your default application will be used to open the file when you select "Open".
    # You only need to configure this section if you want to override your default application,
    # or do special things like streaming.
    #
    # Note the use of single quotes for commands, so that backslashes will not be escaped.
    #
    #
    # To open jpeg files with the feh command:
    #
    # [[mediatype-handlers]]
    # cmd = ['feh']
    # types = ["image/jpeg"]
    #
    # Each command that you specify must come under its own [[mediatype-handlers]]. You may
    # specify as many [[mediatype-handlers]] as you want to setup multiple commands.
    #
    # If the subtype is omitted then the specified command will be used for the
    # entire type:
    #
    # [[mediatype-handlers]]
    # command = ['vlc', '--flag']
    # types = ["audio", "video"]
    #
    # A catch-all handler can by specified with "*".
    # Note that there are already catch-all handlers in place for all OSes,
    # that open the file using your default application. This is only if you
    # want to override that.
    #
    # [[mediatype-handlers]]
    # cmd = ['some-command']
    # types = [
    #         "application/pdf",
    #         "*",
    # ]
    #
    # You can also choose to stream the data instead of downloading it all before
    # opening it. This is especially useful for large video or audio files, as
    # well as radio streams, which will never complete. You can do this like so:
    #
    # [[mediatype-handlers]]
    # cmd = ['vlc', '-']
    # types = ["audio", "video"]
    # stream = true
    #
    # This uses vlc to stream all video and audio content.
    # By default stream is set to off for all handlers
    #
    #
    # If you want to always open a type in its viewer without the download or open
    # prompt appearing, you can add no_prompt = true
    #
    # [[mediatype-handlers]]
    # cmd = ['feh']
    # types = ["image"]
    # no_prompt = true
    #
    # Note: Multiple handlers cannot be defined for the same full media type, but
    # still there needs to be an order for which handlers are used. The following
    # order applies regardless of the order written in the config:
    #
    # 1. Full media type: "image/jpeg"
    # 2. Just type: "image"
    # 3. Catch-all: "*"


    [cache]
    # Options for page cache - which is only for text pages
    # Increase the cache size to speed up browsing at the expense of memory
    # Zero values mean there is no limit

    max_size = 0  # Size in bytes
    max_pages = 30 # The maximum number of pages the cache will store

    # How long a page will stay in cache, in seconds.
    timeout = 1800 # 30 mins

    [proxies]
    # Allows setting a Gemini proxy for different schemes.
    # The settings are similar to the url-handlers section above.
    # E.g. to open a gopher page by connecting to a Gemini proxy server:
    #   gopher = "example.com:123"
    #
    # Port 1965 is assumed if no port is specified.
    #
    # NOTE: These settings override any external handlers specified in
    # the url-handlers section.
    #
    # Note that HTTP and HTTPS are treated as separate protocols here.


    [subscriptions]
    # For tracking feeds and pages

    # Whether a pop-up appears when viewing a potential feed
    popup = true

    # How often to check for updates to subscriptions in the background, in seconds.
    # Set it to 0 to disable this feature. You can still update individual feeds
    # manually, or restart the browser.
    #
    # Note Amfora will check for updates on browser start no matter what this setting is.
    update_interval = 1800 # 30 mins

    # How many subscriptions can be checked at the same time when updating.
    # If you have many subscriptions you may want to increase this for faster
    # update times. Any value below 1 will be corrected to 1.
    workers = 3

    # The number of subscription updates displayed per page.
    entries_per_page = 20

    # Set to false to remove the explanatory text from the top of the subscription page
    header = true


    [theme]
    bg = "#303446"
    tab_num = "#ca9ee6"
    tab_divider = "#a5adce"
    bottombar_text = "#81c8be"
    bottombar_bg = "#51576d"
    scrollbar = "#51576d"

    hdg_1 = "#ca9ee6"
    hdg_2 = "#ca9ee6"
    hdg_3 = "#ca9ee6"
    amfora_link = "#e78284"
    foreign_link = "#ef9f76"
    link_number = "#81c8be"
    regular_text = "#c6d0f5"
    quote_text = "#e5c890"
    preformatted_text = "#ef9f76"
    list_text = "#c6d0f5"

    btn_bg = "#51576d"
    btn_text = "#c6d0f5"

    dl_choice_modal_bg = "#51576d"
    dl_choice_modal_text = "#c6d0f5"
    dl_modal_bg = "#51576d"
    dl_modal_text = "#c6d0f5"
    info_modal_bg = "#51576d"
    info_modal_text = "#c6d0f5"
    error_modal_bg = "#e78284"
    error_modal_text = "#292c3c"
    yesno_modal_bg = "#51576d"
    yesno_modal_text = "#c6d0f5"
    tofu_modal_bg = "#51576d"
    tofu_modal_text = "#c6d0f5"
    subscription_modal_bg = "#51576d"
    subscription_modal_text = "#c6d0f5"

    input_modal_bg = "#51576d"
    input_modal_text = "#c6d0f5"
    input_modal_field_bg = "#414559"
    input_modal_field_text = "#c6d0f5"

    bkmk_modal_bg = "#51576d"
    bkmk_modal_text = "#c6d0f5"
    bkmk_modal_label = "#c6d0f5"
    bkmk_modal_field_bg = "#414559"
    bkmk_modal_field_text = "#c6d0f5"
  '';

}
