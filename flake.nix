{
    description = "Nixos configuration";
    
    inputs = {
        # Pin nixpkgs to latest release, I don't want unstable currently
        nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-22.05";
            
            # use same nixpkgs as system
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, home-manager, ... }@inputs:
    let
        mkSystem = import ./lib/mkSystem.nix;
        overlays = import ./lib/overlays.nix;
        user =  "matan";
    in {
        nixosConfigurations.watson = mkSystem "watson" {
            inherit user nixpkgs home-manager overlays;
            system = "x86_64-linux";
        };

        nixosConfigurations.matilda = mkSystem "matilda" {
            inherit user nixpkgs home-manager overlays;
            system = "x86_64-linux";
        };
     };
}
