{
  description = "Nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";

      # use same nixpkgs as system
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      user = "matan";
      mkSystem = import ./lib/mkSystem.nix;
      overlays = import ./lib/overlays.nix;
    in
    {
      nixosConfigurations.watson = mkSystem "watson" {
        inherit user nixpkgs home-manager overlays;
        system = "x86_64-linux";
      };

      nixosConfigurations.matilda = mkSystem "matilda" {
        inherit user nixpkgs home-manager overlays;
        system = "x86_64-linux";
      };

      formatter.${self.system} = nixpkgs.legacyPackages.${self.system}.nixpkgs-fmt;
    };
}
