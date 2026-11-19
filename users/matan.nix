{config, pkgs, lib, ...}:
let
#  vintagestory = (pkgs.vintagestory.override { x11Support = false; waylandSupport = true; });
in {
  users.users.matan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "plugdev" "navidrome" ];
    hashedPassword = "$6$7d3kZc5N9Nem6iZZ$DyUjI/vv42NFQ9baYQqPql17nCtYg2.96AS./vqEzJnbTxo8cgHpgS/FFH/xyT58wq/EjNxHDF.6RgCjBmSHw/";
    packages = with pkgs; [
      ghostty
      bottles
      
      zoom-us
      spotify
      discord
      
      prismlauncher
      openjdk21
      vintagestory
      goverlay
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 42420 ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
    extraPackages = with pkgs; [
      gamemode
      mangohud
    ];
  };

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        gpu_device = 0;
      };
    };
  };

  services.udev.extraRules =''SUBSYSTEM=="hidraw", ATTR{idVendor}=="4273", ATTR{idProduct}=="7563",  MODE="0666", TAG+="uaccess"'';

}
  
