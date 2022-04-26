{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    tezos.url = "github:marigold-dev/tezos-nix";
    tezos.inputs.nixpkgs.follows = "nixpkgs";
    tezos.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, tezos }:
    let
      out = system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
          inherit (pkgs) lib;
        in {
          devShell = (pkgs.mkShell {
            buildInputs = with pkgs;
             with ocamlPackages; [
               ligo
               tezos
               ocaml-lsp
               ocamlformat
               odoc
               ocaml
               dune_3
               nixfmt
              ];
            shellHook = ''
              alias lcc="ligo compile contract"
              alias lce="ligo compile expression"
              alias lcp="ligo compile parameter"
              alias lcs="ligo compile storage"

            ''; 
          });
          defaultPackage = pkgs.liquid-dapp;
          defaultApp =
            flake-utils.lib.mkApp { drv = self.defaultPackage."${system}"; };
        };
    in with flake-utils.lib; eachSystem defaultSystems out;

}
