{config, pkgs, ... }:

{
    users.users.matan = {
        shell = pkgs.fish;
        isNormalUser = true;
        home = "/home/matan";
        extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
        hashedPassword = "$6$7d3kZc5N9Nem6iZZ$DyUjI/vv42NFQ9baYQqPql17nCtYg2.96AS./vqEzJnbTxo8cgHpgS/FFH/xyT58wq/EjNxHDF.6RgCjBmSHw/";
    };
}
