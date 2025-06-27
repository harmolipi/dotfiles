{
  description = "Main NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    glaumar_repo = {
      url = "github:glaumar/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    ghostty.url = "github:ghostty-org/ghostty";
    tmux-sessionx.url = "github:omerxx/tmux-sessionx";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, glaumar_repo, zen-browser, ghostty, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          # android_sdk.accept_license = true;
        };
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      nixosConfigurations.nixos = lib.nixosSystem {
        system = "x86_64-linux";
        inherit pkgs;
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
          ({
            nixpkgs.overlays = [
              (final: prev: {
                glaumar_repo = glaumar_repo.packages."${prev.system}";
              })

              (final: prev: {
                zen-browser = zen-browser.packages."${prev.system}".default;
              })
            ];
          })
          ./configuration.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager =
              {
                useGlobalPkgs = true;
                useUserPackages = true;
                backupFileExtension = "backup";
                users.niko = {
                  imports = [ ./home.nix ];
                };
              };
          }
          ({ pkgs, ... }: {
            environment.systemPackages = [
              ghostty.packages.x86_64-linux.default
            ];
          })
        ];

        specialArgs = {
          inherit pkgs-unstable;
        };
      };

      # homeConfigurations = {
      #   "niko" = home-manager.lib.homeManagerConfiguration {
      #     # Note: I am sure this could be done better with flake-utils or something
      #     pkgs = import nixpkgs { system = "x86_64-darwin"; };
      #
      #     modules = [ ./home.nix ]; # Defined later
      #   };
      # };
    };
}
