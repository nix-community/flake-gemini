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
            amfora asuka av-98 castor kristall molly-brown ncgopher;
          gacme = pkgs.callPackage ./gacme.nix { };
        });

      nixosModules = {
        molly-brown = import
          "${nixpkgs}/nixos/modules/services/web-servers/molly-brown.nix";
      };

    };
}
