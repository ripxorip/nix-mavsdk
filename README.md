# nix-mavsdk
A Nix Flake For The MAVLink MAVSDK

## About

This is a nix overlay for the MAVLink MAVSDK. It adds libraries/headers for both
the mavlink C library and MAVSDK.

### Usage

This overlay is meant to be used with nix flakes.

It may be used like so as a flake input:

```nix
nix-mavsdk.url = "github:ripxorip/nix-mavsdk";

outputs = { self, nixpkgs, nix-mavsdk }:
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [
        nix-mavsdk.overlays.default
      ];
    };
  in {
    # Normal outputs here, using the 'pkgs' reference above.
  };
```

