{config, pkgs, ... }:

{
    users.user.matan = {
        isNormalUser = true;
        home = "/home/matan";
        extraGroups = [ "wheel" ];
        shell = pkgs.fish;
        initialPassword = "12345678";
    }
}
