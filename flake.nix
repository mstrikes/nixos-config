{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, lanzaboote, ...} :
  {
    nixosConfigurations.watson = nixpkgs.lib.nixosSystem {
      modules = [
        ./machines/watson/configuration.nix
        ./modules/graphics.nix

        lanzaboote.nixosModules.lanzaboote
      ];
    };

    nixosConfigurations.matilda = nixpkgs.lib.nixosSystem {
      modules = [
        ./machines/matilda/configuration.nix
      ];
    };

    nixosConfigurations.howl = nixpkgs.lib.nixosSystem {
      modules = [
        ./machines/howl/configuration.nix
      ];
    };
  };
}
