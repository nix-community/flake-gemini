{
  description = "A survey of software related to the Gemini protocol";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in {

      packages = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          inherit (pkgs)
            amfora asuka av-98 bombadillo castor kristall lagrange molly-brown
            ncgopher;
          inherit (pkgs.haskellPackages) diohsc;
          duckling-proxy = pkgs.callPackage ./duckling-proxy { };
          gacme = pkgs.callPackage ./gacme { };
          html2gmi = pkgs.callPackage ./html2gmi { };
        });

      nixosModules = {
        duckling-proxy = import ./duckling-proxy/nixos-module.nix self;
        molly-brown = import
          "${nixpkgs}/nixos/modules/services/web-servers/molly-brown.nix";
      };

    };
}
