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

    
      # Basic alias
      alias ll = ls
      alias lla = ls -a
    
      # For direnv integration
      def --env nuenv [] { direnv export json | from json | default {} | load-env }
      alias nue = nuenv


      # Load zoxide
      source ~/.zoxide.nu
      source ~/.oh-my-posh.nu
    '';
  };


  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };
}
