{
  description = "Nix overlay for the MAVSDK";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";

    nix-formatter-pack.url = "github:Gerschtli/nix-formatter-pack";
    nix-formatter-pack.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , nix-formatter-pack
    , flake-utils
    }:

    flake-utils.lib.eachDefaultSystem
      (system:

      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {

        formatter = pkgs.nixpkgs-fmt;

        devShells.default = with pkgs; pkgs.mkShell {
          packages = [ mavsdk mavlink ];
        };
      }) // {

      overlays.default = (final: prev: rec {
        mavlink = final.callPackage ./pkgs/mavlink { };
        mavsdk = final.callPackage ./pkgs/mavsdk { inherit mavlink; };
      });
    };
}
