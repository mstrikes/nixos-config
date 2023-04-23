{
  description = "Nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs, ... }@inputs:
    let overlays = import ./lib/overlays.nix; in {
      nixosConfigurations.matilda = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { host = "matilda"; };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/matilda

          ./profiles/common
          ./profiles/develop
        ];
      };

      nixosConfigurations.watson = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { host = "watson"; };
        modules = [
          { nixpkgs.overlays = overlays; }
          ./machines/matilda

          ./profiles/common
          ./profiles/develop
          ./profiles/game
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
