{ pkgs, config, ... }:

with pkgs;
let
  R-with-my-packages = rWrapper.override { packages = with rPackages; [ ggplot2 ]; };
  RStudio-with-my-packages = rstudioWrapper.override { packages = with rPackages; [ ggplot2 dplyr xts tidyverse ]; };
in
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback.out
    evdi.out
  ];
  boot.kernelModules = [
    "uinput"
    "evdi"
    "v4l2loopback"
  ];
  boot.extraModprobeConfig = ''
    options v412loopback exclisive_caps=1 card_label="Virtual Camera"
  '';

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.graphics = {
    # hardware.opengl in 24.05
    enable = true;
    enable32Bit = true; # driSupport32Bit in 24.05
    extraPackages = with pkgs; [ libva vaapiVdpau libvdpau-va-gl libgpg-error ];
  };

  hardware.uinput.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc =
    {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  nix.settings.auto-optimise-store = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.niko = {
    isNormalUser = true;
    description = "Niko Birbilis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      signal-desktop
      (pass.withExtensions (exts: [ exts.pass-otp ]))
      diceware
      zbar
      plex-desktop
      lazygit
      commitizen
      stow
      kitty
      zsh-powerlevel10k
      zoxide
      zsh-autocomplete
      zsh-syntax-highlighting
      fzf
      eza
      nnn
      tldr
      bitwarden-desktop
      immersed-vr
      obsidian
      brave
      zen-browser
      sidequest
      glaumar_repo.qrookie
      ffmpeg
      kdePackages.kdenlive
      libsForQt5.kdenlive
      yt-dlp
      gnomeExtensions.caffeine
      R-with-my-packages
      RStudio-with-my-packages
      nushell
      carapace
      oh-my-posh
      libsForQt5.okular
    ];
    shell = pkgs.nushell;
  };

  programs.zsh = {
    enable = true;
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    ohMyZsh = {
      enable = true;
      # plugins = [ "zsh-syntax-highlighting" ];
    };
    interactiveShellInit = ''
      eval "$(direnv hook zsh)" 
    '';
  };

  programs.tmux = {
    enable = true;
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.session-wizard
      pkgs.tmuxPlugins.catppuccin
      pkgs.tmuxPlugins.yank
    ];
    extraConfig = ''
      set -g @catppuccin_flavor 'macchiato'
    '';
  };

  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };

  # Install firefox.
  programs.firefox = {
    enable = true;
    preferences = {
      "mousewheel.default.delta_multiplier_y" = 30;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
    };
  };

  programs.neovim = {
    enable = true;
  };

  programs.git = {
    enable = true;
    config = {
      user.name = "Niko Birbilis";
      user.email = "nikob381@gmail.com";
      init.defaultBranch = "main";
      color.ui = "auto";
      pull.rebase = false;
    };
  };

  programs.steam.enable = true;
  programs.browserpass.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wl-clipboard
    tree-sitter
    ripgrep
    unzip
    cargo
    xclip
    nodejs
    gcc
    gnupg
    pinentry-gnome3
    audacity
    direnv
  ];

  programs.gnupg = {
    package = pkgs.gnupg;
    agent = {
      enable = true;
    };
  };

  # Plex needs this to login/click on links.
  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;

  environment.variables.EDITOR = "nvim";

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "Meslo" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    21000
    21013
    19000 # Expo dev server
    19001 # Metro bundler
    8081 # Metro bundler alternative port
  ];
  networking.firewall.allowedUDPPorts = [ 21003 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  virtualisation.docker.enable = true;
}
