{config, lib, pkgs, inputs, ...}:
{
  imports = [];

  time.timeZone = "Israel";
  
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_IL/UTF-8"
      "en_US.UTF-8/UTF-8"
      "he_IL.UTF-8/UTF-8"
    ];
  };
  
  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.jetbrains-mono
    ];

    fontconfig.defaultFonts = {
      monospace = [ "JetBrains Mono" ];
    };
  };
  
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
  };

  environment.systemPackages = with pkgs; [
    git helix # TODO use programs.git & programs.helix
    wget eza bat
    zstd zip unzip
  ];

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    ls = "${pkgs.eza}/bin/eza";
    tree = "${pkgs.eza}/bin/eza -T";
    cat = "${pkgs.bat}/bin/bat";
  };

  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;
    desktopManager.gnome.enable = true;

    displayManager.gdm.enable = true;

    libinput.enable = true;
  };
  programs.xwayland.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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

    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
