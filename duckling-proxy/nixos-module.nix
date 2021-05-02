flake:
{ config, lib, pkgs, ... }:

with lib;
let cfg = config.services.duckling-proxy;
in {
  options.services.duckling-proxy = {
    enable = mkEnableOption "Gemini proxy to access the Web";

    package = mkOption {
      description = "Which package this service should use.";
      type = types.package;
      default = let pkgs' = pkgs.extend flake.overlay; in pkgs'.duckling-proxy;
    };

    settings = mkOption {
      description = ''
        Command-line flags, see <link xlink:href="${pkgs.duckling-proxy.meta.homepage}">${pkgs.duckling-proxy.meta.homepage}</link>'';
      type = with types; attrsOf (nullOr str);
      example = {
        citationMarkers = null;
        citationStart = 3;
      };
      default = { };
    };

    address = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Which address this service should listen on.";
    };

    port = mkOption {
      type = types.port;
      default = 1965;
      description = "Which port this service should listen on.";
    };

    serverCert = mkOption {
      type = types.str;
      description = "Path to Gemini server TLS certificate.";
    };

    serverKey = mkOption {
      type = types.str;
      description = "Path to Gemini server TLS private key.";
    };

  };

  config = mkIf cfg.enable {

    services.duckling-proxy.settings = {
      inherit (cfg) serverCert serverKey;
      address = cfg.address;
      port = toString cfg.port;
    };

    systemd.services.duckling-proxy = {
      description = "Gemini proxy to access the Web";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        DynamicUser = true;
        ExecStart = let
          flags = attrsets.mapAttrsToList (name: value:
            if value == null then "--${name}" else "--${name} ${value}")
            cfg.settings;
        in "${cfg.package}/bin/duckling-proxy ${toString flags}";
        Restart = "always";
      };
    };

  };

}
