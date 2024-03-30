{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;

    profiles.matan = {
      isDefault = true;
      name = "matan";

      bookmarks = import ./bookmarks.nix;
      search.force = true;
      search.engines = {
        "Nix Packages" = {
          urls = [
            { template = "https://search.nixos.org/packages?query={searchTerms}"; }
            { template = "https://search.nixos.org/options?query={searchTerms}"; }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
        };

        "NixOS Wiki" = {
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@nw" ];
        };

        "Movies" = {
          urls = [{ template = "https://lookmovie2.to/movies/search/?q={searchTerms}"; }];
          iconUpdateURL = "https://lookmovie2.to/favicon-96x96.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@lm" ];
        };

        "Shows" = {
          urls = [{ template = "https://lookmovie2.to/shows/search/?q={searchTerms}"; }];
          iconUpdateURL = "https://lookmovie2.to/favicon-96x96.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@ls" ];
        };

        "Bing".metaData.hidden = true;
        "Google".metaData.alias = "@g"; # builtin engines only support one alias
      };

      search.order = [ "Google" "DuckDuckGo" ];
      search.default = "Google";

      settings = { };
    };
  };
}
