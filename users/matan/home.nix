{config, pkgs, ... }:

{
    xdg.enable = true;

    home.packages = with pkgs; [
        spotify zoom-us
        discord neovim
        wget
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

    programs.foot = {
        enable = true;
        server.enable = true;
        settings = {
            main = {
                term = "xterm-256color";

                font = "JetBrains Mono:size=11";
                dpi-aware = "yes";
            };

            bell = {
                urgent = false;
                notify = false;
            };
            
            cursor = {
                style = "beam";
            };
        };
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
            core.askPass = "";
            credential.helper = "store";
        };
    };

    programs.firefox.enable = true;
}
