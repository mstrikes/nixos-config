{config, pkgs, host, ...}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  networking.hostName = host;
  
  # Time zone.
  time.timeZone = "Asia/Jerusalem";
  time.hardwareClockInLocalTime = true;
  
  # windowing system
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
  
  # fontconfig
  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      jetbrains-mono
    ];
    fontconfig.enable = true;
  };
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  services.printing.enable = true;
  services.pringint.drivers = [ pkgs.hplip ];
  
  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
    # If you want to use JACK applications, uncomment the line bellow
    #jack.enable = true;
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
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}