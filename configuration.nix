{ config, pkgs, host, user, ... }:

{
  imports = [
    ./modules/programs/foot
  ];
  
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
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

  programs.foot = {
    enable = true;
    server.enable = true;
    
    settings = {
      main.font = "JetBrains Mono:size=12";
      main.dpi-aware = "yes";
      
      bell.urgent = false;
      bell.notify = false;

      colors = {
        alpha = 1.0;
        foreground = "d8dee9";
        background = "2e3440";

        # Normal/regular colors (color palette 0-7)
        regular0 = "3b4252";
        regular1 = "bf616a";
        regular2 = "a3be8c";
        regular3 = "ebcb8b";
        regular4 = "81a1c1";
        regular5 = "b48ead";
        regular6 = "88c0d0";
        regular7 = "e5e9f0";

        # Bright colors (color palette 8-15)
        bright0 = "4c566a";
        bright1 = "bf616a";
        bright2 = "a3be8c";
        bright3 = "ebcb8b";
        bright4 = "81a1c1";
        bright5 = "b48ead";
        bright6 = "8fbcbb";
        bright7 = "eceff4";

        # dimmed colors (see foot.ini(5) man page)
        dim0 = "373e4d";
        dim1 = "94545d";
        dim2 = "809575";
        dim3 = "b29e75";
        dim4 = "68809a";
        dim5 = "8c738c";
        dim6 = "6d96a5";
        dim7 = "aeb3bb";

        # The remaining 256-color palette
        # 16 = <256-color palette #16>
        # ...
        # 255 = <256-color palette #255>

        # Misc colors
        # selection-foreground=<inverse foreground/background>
        # selection-background=<inverse foreground/background>
        # jump-labels=<regular0> <regular3>
        # urls=<regular3>
        # scrollback-indicator=<regular0> <bright4>
      };
    };
  };
  
  programs.steam = {
    enable = true;
    # Open ports in the firewall for Steam Remote Play
    remotePlay.openFirewall = true;
    # Open ports in the firewall for Source Dedicated Server
    dedicatedServer.openFirewall = true;
  };

  users.mutableUsers = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };
}
