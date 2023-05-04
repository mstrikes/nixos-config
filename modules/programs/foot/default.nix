{config, lib, pkgs, ... }:
let
  cfg = config.programs.foot;
  iniFormat = pkgs.formats.ini { };
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

    settings = mkOption {
      type = iniFormat.type;
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
  
    environment.etc."xdg/foot/foot.ini" = mkIf (cfg.settings != { }) {
      source = iniFormat.generate "foot.ini" cfg.settings;
    };

    systemd.user.services.foot = mkIf cfg.server.enable {
      description = "Fast, lightweight and minimalistic Wayland terminal emulator.";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/foot --server";
        Restart = "on-failure";
        OOMPolicy = "continue";
      };
    };
  };
}
