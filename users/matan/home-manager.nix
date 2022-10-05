{config, pkgs, ... }:

{
    xdg.enable = true;

    home.packages = with pkgs; [
        firefox
        discord
        nvim
        wget
        tetex
    ];

    home.sessionVariables = {
        LANG = "en_IL.UTF-8";
        LC_CTYPE = "en_IL.UTF-8";
        LC_ALL = "en_IL.UTF-8";
        EDITOR = "nvim";
    };

    # xdg.configFile."....".source =

    programs.fish = {
        enable = true;
    };

    programs.git = {
        enable = true;
        userName = "Matan Dery";
        userEmail = "matand103@gmail.com";
        aliases = {
            prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";

        };

        extraConfig = {
            color.ui = true;
            core.askPass = ""; # ask pass within terminal
            credential.helper = "store"
        };
    };
}
