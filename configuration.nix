{ config, pkgs, host, user, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  users.mutableUsers = false;

  # Enable networking
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.hostName = host;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";
  time.hardwareClockInLocalTime = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    # GNOME desktop environment
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;

    # input
    libinput.enable = true;
  };
  programs.xwayland.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      jetbrains-mono
    ];

    fontconfig = {
      enable = true;
    };
  };

  programs.steam = {
    enable = true;
    # Open ports in the firewall for Steam Remote Play
    remotePlay.openFirewall = true;
    # Open ports in the firewall for Source Dedicated Server
    dedicatedServer.openFirewall = true;
  };

  programs.fish.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-then 14d";
    };
  };

}
