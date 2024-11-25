{ pkgs, outPath ? "", ... }: {
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.nixpkgs-fmt
  ];

  programs.neovim = {
    enable = true;
    extraConfig = "./nvim/init.lua";
  };

  #home.file = {
    #".config/nvim" = {
      # source = toString (outPath + "/nvim");
      #source = ./nvim/lua;
      #recursive = true;
    #};
  #};
}
