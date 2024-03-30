{config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/3e7db49c-cb00-45b1-9f74-225d71f7a459";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9594-0B02";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-uuid/3d325c05-23a5-44e5-9e16-0207bd3f916c";
      fsType = "ext4";
    };
  };
  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];

  networking.hostName = "watson";
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault false;
  networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  # dealing with nvidia
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.modesetting.enable = true;

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
