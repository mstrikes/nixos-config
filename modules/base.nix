{config, lib, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  networking.networkmanager.enable = lib.mkDefault true;

  time.timeZone = lib.mkDefault "Asia/Jerusalem";

  environment.systemPackages = with pkgs; [
    exa
    git
    bat
    wget
    zip unzip
    zstd
  ];

  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    ls = "exa --color-scale --group-directories-first -l -a -group --icons --header";
    tree = "exa --color-scale -a --group --icons --header -T";
    cat = "bat";
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = [
      pkgs.jetbrains-mono
    ];
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
  system.stateVersion = "23.05"; # Did you read the comment?
}
