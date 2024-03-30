{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }@inputs: {
    packages.x86_64-linux.default = let
      img = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/hosts/qemu.nix
          ./system/configuration.nix

          home-manager.nixosModules.home-manager
          ./users/matan
        ];

        specialArgs = { inherit inputs; };
      };
    in img.config.system.build.vm;
    
    nixosConfigurations = {
      watson = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/hosts/watson.nix
          ./system/configuration.nix

          home-manager.nixosModules.home-manager
          ./users/matan
        ];

        specialArgs = { inherit inputs; };
      };

      matilda = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./system/hosts/matilda.nix
          ./system/configuration.nix

          home-manager.nixosModules.home-manager
          ./users/matan
        ];

        specialArgs = { inherit inputs; };
      };
   };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
