{
    description = "Nixos configuration";
    
    inputs = {
        # Pin nixpkgs to latest release, I don't want unstable currently
        nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

#        home-manager = {
#            url = "github:nix-community/home-manager/release-22.05";
#            
#            # use same nixpkgs as system
#            inputs.nixpkgs.follows = "nixpkgs";
#        };
    };

    outputs = {self, nixpkgs, ... }@inputs:
    let mkSystem = import ./lib/mkSystem.nix;
        user = "matan";
    in {
       nixosConfigurations.watson = mkSystem "watson" {
            inherit user nixpkgs;
            system = "x86_64-linux";
        };
     };
}
