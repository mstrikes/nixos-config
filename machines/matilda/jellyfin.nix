{config, lib, pkg, ...}:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
}
