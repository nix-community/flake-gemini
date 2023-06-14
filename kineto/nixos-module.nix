flake:
{ config, lib, pkgs, ... }:

with lib;
let cfg = config.services.kineto;
in {
  options.services.kineto = {
    enable = mkEnableOption "HTTP to Gemini proxy";

    package = mkOption {
      description = "Which package this service should use.";
      type = types.package;
      default = let pkgs' = pkgs.extend flake.overlays.default; in pkgs'.kineto;
    };

    address = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Which address this service should listen on.";
    };

    port = mkOption {
      type = types.port;
      example = "8080";
      description = "Which port this service should listen on.";
    };

    geminiDomain = mkOption {
      type = types.str;
      example = "gemini://example.org";
      description = "Gemini domain to serve via HTTP.";
    };

    extraArgs = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example =  lib.literalExample ''[ "-s ${./style.css}" ]'';
      description = "Extra command line arguments.";
    };

  };

  config = mkIf cfg.enable {

    systemd.services.kineto = {
      description = "HTTP to Gemini proxy";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        DynamicUser = true;
        ExecStart = let
          flags = cfg.extraArgs ++ [
            "-b ${cfg.address}:${toString cfg.port}"
            cfg.geminiDomain
          ];
        in "${cfg.package}/bin/kineto ${toString flags}";
        Restart = "always";
      };
    };

  };

}
