{pkgs, ...}:
{
  fonts = {
    enableDefaultPackages = true;
    packages = [
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.nerd-fonts.arimo
      pkgs.corefonts
    ];
  };
}
