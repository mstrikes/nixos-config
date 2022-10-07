{config, pkgs, host, user, ... }:

{
    users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
        shell = pkgs.fish;
    };

    environment.systemPackages = with pkgs; [
        git wget neovim
        firefox discord spotifyd
        zoom-us foot
    ];
    
    #nixpkgs.overlays = [
    #    (self: super: {
    #        discord = super.discord.overrideAttrs (_: {
	#                src = builtins.fetchTarball "https://discord.com/api/download?platform=linux&format=tar.gz";
	#            });})
    #];


    programs.fish = { enable = true; };

    # Enable networking
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;
    services.resolved.enable = true;
    networking.hostName = host;

    # Set your time zone.
    time.timeZone = "Asia/Jerusalem";
    time.hardwareClockInLocalTime = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_IL.utf8";

    # Enable the X11 windowing system.
    services.xserver = {
        enable = true;

        # GNOME desktop environment
        displayManager.gdm.enable = true;
        displayManager.gdm.wayland = true;
        desktopManager.gnome.enable = true;

        # keymap
        layout = "us";
        xkbVariant = "";

        # input
        libinput.enable = true;
    };

    fonts = {
      enableDefaultFonts = true;
      fonts = with pkgs; [
        jetbrains-mono
      ];
      
      fontconfig = {
        enable = true;
      };
    };

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

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "22.05"; # Did you read the comment?
}
