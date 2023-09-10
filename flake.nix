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

    flake-utils.lib.eachDefaultSystem (system:

    let
      pkgs = import nixpkgs { inherit system; };

      _mavlink = pkgs.callPackage ./pkgs/mavlink { };
      _mavsdk = pkgs.callPackage ./pkgs/mavsdk { mavlink=_mavlink; };

    in
    {
      formatter = pkgs.nixpkgs-fmt;
      overlays.default = (final: prev: rec {
        mavlink = final._mavlink;
        mavsdk = final._mavsdk;
    });

      devShells.default = with pkgs; pkgs.mkShell {
        packages = [ _mavsdk _mavlink ];
      };
    });
}
