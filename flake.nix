{
  description = "Nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs, ... }@inputs:
    {
      overlays.default = final: prev: {
        discord = import ./overlays/discord;      
      };
        
      nixosConfigurations.matilda = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { host = "matilda"; };
        modules = [
          { nix.registry.nixpkgs.flake = nixpkgs; }
          { nixpkgs.overlays = [ self.overlays.default ]; }
          ./machines/matilda
        ];
      };

      nixosConfigurations.watson = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { host = "watson"; };
        modules = [
          { nix.registry.nixpkgs.flake = nixpkgs; }
          { nixpkgs.overlays = [ self.overlays.default ]; }
          ./machines/watson
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
