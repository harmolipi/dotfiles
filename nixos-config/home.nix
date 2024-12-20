{ pkgs, outPath ? "", ... }: {
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.nixpkgs-fmt
  ];

  # programs.neovim = {
  #   enable = true;
  #   extraConfig = "./nvim/init.lua";
  # };

  #home.file = {
  #".config/nvim" = {
  # source = toString (outPath + "/nvim");
  #source = ./nvim/lua;
  #recursive = true;
  #};
  #};

  programs.nushell = {
    enable = true;

    extraEnv = ''
      # Initialize zoxide
      zoxide init nushell | save -f ~/.zoxide.nu
    '';

    extraConfig = ''
      # Disable welcome banner
      $env.config = {
        show_banner: false
        render_right_prompt_on_last_line: true
        edit_mode: vi
        keybindings: []
      }

      # Set up starship prompt
      $env.PROMPT_COMMAND = { || starship prompt }
      $env.PROMPT_COMMAND_RIGHT = { || "" }
    
      # Basic alias
      alias ll = ls
      alias lla = ls -a
    
      # For direnv integration
      def --env nuenv [] { direnv export json | from json | default {} | load-env }
      alias nue = nuenv

      # Set up starship prompt correctly
      $env.STARSHIP_SHELL = "nu"
      $env.STARSHIP_SESSION_KEY = (random chars -l 16)
      $env.PROMPT_COMMAND = { || starship prompt }
      $env.PROMPT_COMMAND_RIGHT = { || "" }

      # Load zoxide
      source ~/.zoxide.nu
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      palette = "dracula";

      # format = "[╭](fg:separator)$status$directory$cmd_duration$line_break[╰](fg:separator)$character";
      format = "[╭](fg:current_line)$os$directory$git_branch$git_status$fill$nodejs$bun$deno$aws$cmd_duration$username$line_break$character";

      palettes.dracula = {
        foreground = "#F8F8F2";
        background = "#282A36";
        current_line = "#44475A";
        primary = "#1E1F29";
        box = "#44475A";
        blue = "#6272A4";
        cyan = "#8BE9FD";
        green = "#50FA7B";
        orange = "#FFB86C";
        pink = "#FF79C6";
        purple = "#BD93F9";
        red = "#FF5555";
        yellow = "#F1FA8C";
      };

      os = {
        format = "(fg:current_line)[](fg:red)[$symbol](fg:primary bg:red)[](fg:red)";
        disabled = false;
        symbols = {
          Alpine = "";
          Amazon = "";
          Android = "";
          Arch = "";
          CentOS = "";
          Debian = "";
          EndeavourOS = "";
          Fedora = "";
          FreeBSD = "";
          Garuda = "";
          Gentoo = "";
          Linux = "";
          Macos = "";
          Manjaro = "";
          Mariner = "";
          Mint = "";
          NetBSD = "";
          NixOS = "";
          OpenBSD = "";
          OpenCloudOS = "";
          openEuler = "";
          openSUSE = "";
          OracleLinux = "⊂⊃";
          Pop = "";
          Raspbian = "";
          Redhat = "";
          RedHatEnterprise = "";
          Solus = "";
          SUSE = "";
          Ubuntu = "";
          Unknown = "";
          Windows = "";
        };
      };

      character = {
        format = '' 
          [│](fg:current_line)
          [╰─$symbol](fg:current_line)'';
        success_symbol = "[](fg:bold green)";
        error_symbol = "[](fg:bold red)";
        # success_symbol = "[❯](fg:prompt_ok)";
        # error_symbol = "[❯](fg:prompt_err)";
      };

      directory = {
        format = "[─](fg:current_line)[](fg:pink)[󰷏 ](fg:primary bg:pink)[](fg:pink bg:box)[ $read_only$truncation_symbol$path](fg:foreground bg:box)[](fg:box)";
        # format = "[─](fg:separator)[](fg:directory)[](fg:icon bg:directory)[](fg:directory bg:background)[ $path](bg:background)[](fg:background)";
        home_symbol = " ~/";
        truncation_symbol = " ";
        truncation_length = 2;
        read_only = "󱧵 ";
        read_only_style = "";
        # truncate_to_repo = false;
        # truncation_length = 0;
      };

      git_branch = {
        format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $branch](fg:foreground bg:box)";
        symbol = " ";
      };

      git_status.format = "[( $all_status)](fg:foreground bg:box)[](fg:box)";

      nodejs =
        {
          format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
          detect_files = [ "package.json" ".node-version" "bunfig.toml" "bun.lock" ];
        };

      bun = {
        format = "[─](fg:current_line)[](fg:green)[$symbol](fg:primary bg:green)[](fg:green bg:box)[ $version](fg:foreground bg:box)[](fg:box)";
        symbol = "🥟";
      };

      fill = {
        symbol = "─";
        style = "fg:current_line";
      };

      cmd_duration = {
        min_time = 500;
        format = "[─](fg:current_line)[](fg:orange)[ ](fg:primary bg:orange)[](fg:orange bg:box)[ $duration ](fg:foreground bg:box)[](fg:box)";
        #   format = " [ ─ ]
        #     (fg:separator) [ ]
        #     (fg:duration) [ 󱐋 ]
        #     (fg:icon bg:duration) [ ]
        #     (fg:duration bg:background) [ $duration ]
        #     (bg:background) [ ]
        #     (fg:background) ";
        #   min_time = 1000;
      };

      shell = {
        format = "[─](fg:current_line)[](fg:blue)[](fg:primary bg:blue)[](fg:blue bg:box)[ $indicator](fg:foreground bg:box)[](fg:box)";
        disabled = false;
      };

      username = {
        format = "[─](fg:current_line)[](fg:yellow)[](fg:primary bg:yellow)[](fg:yellow bg:box)[ $user](fg:foreground bg:box)[](fg:box) ";
        show_always = true;
      };

      status = {
        format = " [ ─ ]
          (fg:separator) [ ]
          (fg:status) [ ]
          (fg:icon bg:status) [ ]
          (fg:status bg:background) [ $status ]
          (bg:background) [ ]
          (fg:background) ";
        pipestatus = true;
        pipestatus_separator = " - ";
        pipestatus_segment_format = "$status ";
        pipestatus_format = " [ ─ ]
          (fg:separator) [ ]
          (fg:status) [ ]
          (fg:icon bg:status) [ ]
          (fg:status bg:background) [ $pipestatus ]
          (bg:background) [ ]
          (fg:background) ";
        disabled = false;
      };

      time = {
        format = "[─](fg:current_line)[](fg:purple)[󰦖 ](fg:primary bg:purple)[](fg:purple bg:box)[ $time](fg:foreground bg:box)[](fg:box)";
        time_format = "%H:%M";
        disabled = false;
        # format = " [ ]
        #   (fg:duration) [ 󰥔 ]
        #   (fg:icon bg:duration) [ ]
        #   (fg:duration bg:background) [ $time ]
        #   (bg:background) [ ]
        #   (fg:background) ";
        # disabled = false;
      };
    };
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };
}
