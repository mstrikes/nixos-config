{config, lib, pkgs, modulesPath, ...}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/virtualisation/qemu-vm.nix")
  ];

  hardware.opengl.enable = true;
  virtualisation.qemu.options = ["-vga none" "-device virtio-vga-gl" "-display sdl,gl=on"]; 
  virtualisation.sharedDirectories = {
    home = {
      source = "/home";
      target = "/home";
    };
  };
}
