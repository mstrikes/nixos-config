# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
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
  services.xserver.xkb.layout = "us,il";

  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.jetbrains-mono
      pkgs.nerd-fonts.arimo
    ];

    fontconfig.defaultFonts = {
      monospace = [ "JetBrains Mono" "Arimo" ];
    };
  };

  # Enable the GNOME Desktop Environment.
  services.xserver = {
    enable = true;
    
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    desktopManager.xterm.enable = false;
  };
  programs.xwayland.enable = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget git helix nil
    zstd zip unzip
    ghostty
    wl-clipboard
  ];
  
  programs.firefox.enable = true;

  services.udev.extraRules =
    ''
      SUBSYSTEM="usb", ATTR{idVendor}=="4273", ATTR{idProduct}=="7563",  MODE="0660", GROUP="plugdev"
    '';
  nix = {
    settings ={
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
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
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$7d3kZc5N9Nem6iZZ$DyUjI/vv42NFQ9baYQqPql17nCtYg2.96AS./vqEzJnbTxo8cgHpgS/FFH/xyT58wq/EjNxHDF.6RgCjBmSHw/";
    packages = with pkgs; [
      rquickshare galaxy-buds-client
      zoom-us spotify
      resources

      prismlauncher
      openjdk21
      hplip
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  networking.firewall.allowedTCPPorts = [ 62930 ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  
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
