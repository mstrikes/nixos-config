{ config, pkgs, ... }:

{
  imports = [
    ./firefox
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    spotify
    zoom-us
    discord
    galaxy-buds-client
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.stateVersion = "22.05";

  # xdg.configFile."....".source =

  xdg.configFile."discord/settings.json".text = ''
    {
        "SKIP_HOST_UPDATE": true,
        "IS_MAXIMIZED": true,
        "IS_MINIMIZED": false
    }
  '';

  programs.git = {
    enable = true;
    userName = "Matan Dery";
    userEmail = "matand103@gmail.com";
    aliases = {
      prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";

    };

    extraConfig = {
      color.ui = true;
      core.askPass = "";
      credential.helper = "store";
    };
  };
}
