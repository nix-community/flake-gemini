{
  description = "A survey of software related to the Gemini protocol";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {

      overlay = final: prev:
        with prev; {
          duckling-proxy = callPackage ./duckling-proxy { };
          gacme = callPackage ./gacme { };
          gemget = callPackage ./gemget { };
          html2gmi = callPackage ./html2gmi { };
          kineto = callPackage ./kineto { };
        };

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}.extend self.overlay;
        in {
          inherit (pkgs)
            agate amfora asuka av-98 bombadillo castor duckling-proxy gacme
            gemget gmnisrv html2gmi kineto kristall lagrange molly-brown
            ncgopher;
        });

      nixosModules = {
        duckling-proxy = import ./duckling-proxy/nixos-module.nix self;
        kineto = import ./kineto/nixos-module.nix self;
        molly-brown = import
          "${nixpkgs}/nixos/modules/services/web-servers/molly-brown.nix";
      };

    };
}
