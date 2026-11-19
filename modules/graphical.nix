{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = { };
  config = {
    services.displayManager.plasma-login-manager.enable = true;
    services.desktopManager.plasma6.enable = true;
    qt.platformTheme = "kde";

    #services.displayManager.gdm.enable = true;
    #services.desktopManager.gnome.enable = true;

    environment.systemPackages = with pkgs; [
      wl-clipboard
      xdg-utils
    ];

    hardware = {
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
    };
  };
}
