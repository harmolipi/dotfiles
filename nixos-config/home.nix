{ pkgs, ... }: {
  home.username = "niko";
  home.homeDirectory = "/home/niko";
  # home.stateVersion = "24.05";
  home.packages = [
    pkgs.nixpkgs-fmt
  ];
  programs.home-manager.enable = true;
}
