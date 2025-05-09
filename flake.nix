{
  description = "nixos-config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  };

  outputs = {self, nixpkgs, ...}@inputs :
  {
    nixosConfigurations.watson = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/watson/configuration.nix
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
