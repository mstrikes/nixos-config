{
  description = "Nixos configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    overlays.default = final: prev: builtins.mapAttrs (n: o: (o final prev).${n}) self.overlays;
    overlays = {
      discord = import ./overlays/discord.nix;
      # pkg = final: prev: final.callPackge ./packages/pkg;
    };

    nixosConfigurations =
      let
        x86_64-linux = {
          system = "x86_64-linux";
          modules = with self.nixosModules; [
            home-manager.nixosModules.home-manager
            traits.stateVersion
            traits.registry
            traits.overlays
          ];
        };
      in
      with self.nixosModules; {
        matilda = nixpkgs.lib.nixosSystem {
          specialArgs = { host = "matilda"; };
          inherit (x86_64-linux) system;
          modules = x86_64-linux.modules ++ [
            machines.matilda
            configuration
            home.matan
          ];
        };
        watson = nixpkgs.lib.nixosSystem {
          specialArgs = { host = "matilda"; };
          inherit (x86_64-linux) system;
          modules = x86_64-linux.modules ++ [
            machines.watson
            configuration
            home.matan
          ];
        };
      };

    nixosModules = {
      machines.matilda = ./machines/matilda;
      machines.watson = ./machines/watson;

      configuration = ./configuration.nix;

      traits.stateVersion = ./modules/stateVersion.nix;
      traits.overlays = { nixpkgs.overlays = [ self.overlays.default ]; };
      traits.registry = { nix.registry.nixpkgs.flake = nixpkgs; };

      home.matan = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.matan = import ./users/matan/home.nix;

        users.users.matan = {
          shell = nixpkgs.legacyPackages.x86_64-linux.fish;
          isNormalUser = true;
          home = "/home/matan";
          extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
          hashedPassword = "$6$7d3kZc5N9Nem6iZZ$DyUjI/vv42NFQ9baYQqPql17nCtYg2.96AS./vqEzJnbTxo8cgHpgS/FFH/xyT58wq/EjNxHDF.6RgCjBmSHw/";
        };
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
  };
}
