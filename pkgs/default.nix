{ pkgs ? import <nixpkgs> { } }: rec {
  mavlink = pkgs.callPackage ./mavlink { };
  mavsdk = pkgs.callPackage ./mavsdk { inherit mavlink; };
}
