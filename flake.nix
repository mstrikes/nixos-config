{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, lanzaboote, ...} :
  {
    nixosConfigurations.watson = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/watson/configuration.nix

        lanzaboote.nixosModules.lanzaboote
      ];
    };

    nixosConfigurations.matilda = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/matilda/configuration.nix
      ];
    };
  };
}
