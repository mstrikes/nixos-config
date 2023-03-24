{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
  ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.modesetting.enable = true;
}
