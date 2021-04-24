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
          html2gmi = callPackage ./html2gmi { };
        };

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system}.extend self.overlay;
        in {
          inherit (pkgs)
            amfora asuka av-98 bombadillo castor duckling-proxy gacme html2gmi
            kristall lagrange molly-brown ncgopher;
          inherit (pkgs.haskellPackages) diohsc;
        });

      nixosModules = {
        duckling-proxy = import ./duckling-proxy/nixos-module.nix self;
        molly-brown = import
          "${nixpkgs}/nixos/modules/services/web-servers/molly-brown.nix";
      };

    };
}
