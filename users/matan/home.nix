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

                font = "JetBrains Mono:size=12";
                dpi-aware = "yes";
            };

            bell = {
                urgent = false;
                notify = false;
            };
            
            cursor = {
                style = "block";
                color = "2e3440 d8dee9";
                blink = false;
                beam-thickness = 1.5;
            };

            colors = {
                alpha = 1.0;
                foreground = "d8dee9";
                background = "2e3440";
                
                # Normal/regular colors (color palette 0-7)
                regular0 = "3b4252";
                regular1 = "bf616a";
                regular2 = "a3be8c";
                regular3 = "ebcb8b";
                regular4 = "81a1c1";
                regular5 = "b48ead";
                regular6 = "88c0d0";
                regular7 = "e5e9f0";
                
                # Bright colors (color palette 8-15)
                bright0 = "4c566a";
                bright1 = "bf616a";
                bright2 = "a3be8c";
                bright3 = "ebcb8b";
                bright4 = "81a1c1";
                bright5 = "b48ead";
                bright6 = "8fbcbb";
                bright7 = "eceff4";
                
                # dimmed colors (see foot.ini(5) man page)
                dim0 = "373e4d";
                dim1 = "94545d";
                dim2 = "809575";
                dim3 = "b29e75";
                dim4 = "68809a";
                dim5 = "8c738c";
                dim6 = "6d96a5";
                dim7 = "aeb3bb";
                
                # The remaining 256-color palette
                # 16 = <256-color palette #16>
                # ...
                # 255 = <256-color palette #255>
                
                # Misc colors
                # selection-foreground=<inverse foreground/background>
                # selection-background=<inverse foreground/background>
                # jump-labels=<regular0> <regular3>
                # urls=<regular3>
                # scrollback-indicator=<regular0> <bright4>
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

    programs.firefox = {
        enable = true;
    };
}
