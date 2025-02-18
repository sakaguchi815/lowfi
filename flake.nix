{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [rust-overlay.overlays.default];
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            alsa-lib
            openssl
            pkg-config
            rust-bin.stable.latest.default
          ];
        };
        packages.default = pkgs.callPackage ./nix/lowfi.nix {};
        formatter = pkgs.alejandra;
      }
    );
}
