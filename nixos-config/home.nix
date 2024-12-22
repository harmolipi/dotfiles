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
      oh-my-posh init nu --config ~/.config/catppuccin.omp.json
    '';

    extraConfig = ''
      # Disable welcome banner
      $env.config = {
        show_banner: false
        render_right_prompt_on_last_line: true
        edit_mode: vi
        keybindings: []
      }

        # Completions
        let carapace_completer = {|spans: list<string>|
          carapace $spans.0 nushell ...$spans
          | from json
          | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
        }
    
      # Basic alias
      alias ll = ls
      alias lla = ls -a
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
    
      # For direnv integration
      def --env nuenv [] { direnv export json | from json | default {} | load-env }
      alias nue = nuenv


      # Load zoxide
      source ~/.zoxide.nu
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
