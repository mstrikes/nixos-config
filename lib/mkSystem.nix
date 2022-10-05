host: { nixpkgs, system, user }:

nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit host user; };
    modules = [
        ../hosts/configuration.nix
        ../hosts/${host}/configuration.nix # host spacific configuration

#        home-manager.nixosModules.home-manager {
#            home-manager.useGlobalPkgs = true;
#            home-manager.useUserPackages = true;
#            home-manager.users.${user} = import ../users/${user}/home-manager.nix;
#        }
   ];
}
