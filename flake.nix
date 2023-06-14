{
  description = "A survey of software related to the Gemini protocol";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {

      overlays.default = final: prev:
        with prev; {
          gacme = callPackage ./gacme { };
          html2gmi = callPackage ./html2gmi { };
          kineto = callPackage ./kineto { };
        };

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
        in {
          inherit (pkgs)
            agate amfora asuka av-98 bombadillo castor duckling-proxy gacme
            gemget gmid gmni gmnisrv gmnitohtml html2gmi md2gemini kiln kineto
            kristall lagrange molly-brown ncgopher telescope;
        });

      nixosModules = {
        duckling-proxy = import ./duckling-proxy/nixos-module.nix self;
        kineto = import ./kineto/nixos-module.nix self;
        molly-brown = import
          "${nixpkgs}/nixos/modules/services/web-servers/molly-brown.nix";
      };

    };
}
