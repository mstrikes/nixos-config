host: { nixpkgs, home-manager, system, user, overlays }:

nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit host user; };
    modules = [
        { nixpkgs.overlays = overlays; }

        ../hosts/shared-configuration.nix
        ../hosts/${host}/host-configuration.nix

        ../users/${user}/user.nix
        home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = import ../users/${user}/home.nix;
        }
   ];
}
