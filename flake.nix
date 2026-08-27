{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, lanzaboote, ...} :
  {
    nixosConfigurations.watson = nixpkgs.lib.nixosSystem {
      modules = [
        ./machines/watson/configuration.nix
        ./modules/base.nix
        ./modules/graphical.nix
        ./users/matan.nix        

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
