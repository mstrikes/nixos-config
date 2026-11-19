{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, lanzaboote, ... }:
    {
      nixosConfigurations = {
        watson = nixpkgs.lib.nixosSystem {
          modules = [
            ./machines/watson/configuration.nix
            ./modules/base.nix
            ./modules/graphical.nix
            ./modules/sound.nix
            ./modules/fonts.nix
            ./users/matan.nix

            lanzaboote.nixosModules.lanzaboote
          ];
        };

        wren = nixpkgs.lib.nixosSystem {
          modules = [
            ./machines/wren/configuration.nix
            ./modules/base.nix
            ./modules/sound.nix
            ./modules/fonts.nix
          ];
        };

        matilda = nixpkgs.lib.nixosSystem {
          modules = [
            ./machines/matilda/configuration.nix
          ];
        };
      };
    };
}
