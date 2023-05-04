{config, lib, pkgs, ... }:
let
  cfg = config.programs.foot;
in with lib; {
  options.programs.foot = {
    enable = mkEnableOption "Foot terminal";

    package = mkOption {
      type = types.package;
      default = pkgs.foot;
      defaultText = literalExpression "pkgs.foot";
      description = "The foot package to install";
    };
  
    server.enable = mkEnableOption "Foot terminal server";

    settings = {
      type = attrsOf (attrsOf anything);
      default = { };
      example = literalExpression ''
        {
          main = {
            term = "xterm-256color";
            font = "Fira Code:size=11";
            dpi-aware = "yes";
          };
          mouse = {
            hide-when-typing = "yes";
          };
        }
      '';
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];
  
    environment.etc.footconfig = mkIf (cfg.settings != { }) {
      text = generators.toINI cfg.settings;
      target = "xdg/foot/foot.ini";
    };

    systemd.user.services = mkIf cfg.server.enable {
      foot = {
        Unit = {
          Description = "Fast, lightweight and minimalistic Wayland terminal emulator.";
          Documentation = "man:foot(1)";
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          ExecStart = "${cfg.package}/bin/foot --server";
          Restart = "on-failure";
          OOMPolicy = "continue";
        };

        Install = { WantedBy = [ "graphical-session.target" ]; };
      };
    };
  };
}
