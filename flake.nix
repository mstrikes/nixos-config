{
  description = "Nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, ... }@inputs:
    let
      pkgs = inputs.nixpkgs; # add overrides
    in {
      nixosConfigurations.matilda = pkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { host = "matilda"; };
        modules = [
          ./machines/matilda

          ./profiles/common
          ./profiles/develop
        ];
      };

      nixosConfigurations.watson = pkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { host = "watson"; };
        modules = [
          ./machines/watson

          ./profiles/common
          ./profiles/develop
          ./profiles/game
        ];
      };

      formatter.x86_64-linux = pkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
