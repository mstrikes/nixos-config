{
  description = "Nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
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
          ./configuration
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

      nixosModules = {
        profiles.common = ./profiles/common;
        
        traits.overlays = { nixpkgs.overlays = [self.overlays.default ]; };
        traits.registry = { nix.registry.nixpkgs.flake = nixpkgs; };    
        
        home.matan = home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.matan = import ./users/matan/home.nix;
          
          users.users.matan = {
              shell = nixpkgs.pkgs.fish;
              isNormalUser = true;
              home = "/home/matan";
              extraGroups = [ "networkmanager" "wheel" "video" "audio"];
              password = "123455678";
            };
        };
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}
