{config, pkgs, lib, ...}:
{
  options = {};
  config = {
    services.displayManager.plasma-login-manager.enable = true;
    services.desktopManager.plasma6.enable = true;
    qt.platformTheme = "kde";

    programs.xwayland.enable = true;
    environment.systemPackages = with pkgs; [
      wl-clipboard xdg-utils
    ];

    # Enable sound.
    services.pipewire = {
      enable = true;
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
