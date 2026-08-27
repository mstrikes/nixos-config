{config, lib, pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    wget git helix
    zstd zip unzip
  ];
  
  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_IL/UTF-8"
      "en_US.UTF-8/UTF-8"
      "he_IL.UTF-8/UTF-8"
    ];
  };
  
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
}
