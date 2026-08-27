{config, pkgs, lib, ...}:
{
  options = {};
  config = {
    services.displayManager.plasma-login-manager.enable = true;
    services.desktopManager.plasma6.enable = true;
    qt.platformTheme = "kde";

    environment.systemPackages = with pkgs; [
      wl-clipboard xdg-utils
    ];

    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };
    
    # Enable sound.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    fonts = {
      enableDefaultPackages = true;
      packages = [
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.arimo
        pkgs.corefonts
      ];
    };
  };
}
