# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
let
  vintagebase = (pkgs.vintagestory.override { x11Support = false; waylandSupport = true; });
  vintage215 = vintagebase.overrideAttrs {
    version = "1.21.5";
    src = fetchTarball {
      url = "https://cdn.vintagestory.at/gamefiles/stable/vs_client_linux-x64_1.21.5.tar.gz";
      sha256  = "18r5i2q39sasnyrwzz5pclkpy2zhblz2cldv7gjkbs5vksxjxh4f";
    };
  };
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Set your time zone.
  time.timeZone = "Israel";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_IL/UTF-8"
      "en_US.UTF-8/UTF-8"
      "he_IL.UTF-8/UTF-8"
    ];
  };
  
  environment.systemPackages = with pkgs; [
    wget git helix nil sbctl
    zstd zip unzip
    ghostty
    scrcpy
    bottles
  ];

  #xdg.terminal-exec = {
  #  enable = true;
  #  setttings.default = [
  #    "ghostty.desktop"
  #  ];
  #};
  
  programs.firefox.enable = true;
  services.fwupd.enable = true;
  
  services.udev.extraRules =
    ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="4273", ATTR{idProduct}=="7563",  MODE="0660", GROUP="plugdev"
    '';

  nix = {
    settings ={
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "matan" ];
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-then 14d";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;

  users.users.matan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "navidrome" "plugdev"];
    hashedPassword = "$6$7d3kZc5N9Nem6iZZ$DyUjI/vv42NFQ9baYQqPql17nCtYg2.96AS./vqEzJnbTxo8cgHpgS/FFH/xyT58wq/EjNxHDF.6RgCjBmSHw/";
    packages = with pkgs; [
      zoom-us spotify

      prismlauncher
      openjdk21
      hplip

      vintagebase
      dotnet-runtime_8
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  networking.firewall.allowedTCPPorts = [ 62930 42420];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  hardware.graphics = {
      enable = true;
      package = (pkgs.mesa.overrideAttrs (o: {
        mesonFlags = o.mesonFlags ++ [ (lib.mesonOption "tools" "intel") ];
      }));
    };
  
  services.navidrome = {
    enable = false;
    openFirewall = true;
    settings = {
      MusicFolder = "/var/opt/navidrome";
      DataFolder = "/var/lib/navidrome";
    };
  };
  
  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  # for more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
