{
  lib,
  makeRustPlatform,
  rust-bin,
  alsa-lib,
  openssl,
  pkg-config,
}: let
  toolchain = rust-bin.stable.latest.default;
  rustPlatform = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in
  rustPlatform.buildRustPackage {
    pname = "lowfi";
    version = "1.5.3";

    buildInputs = [alsa-lib openssl];
    nativeBuildInputs = [pkg-config];

    src = ../.;
    cargoLock.lockFile = ../Cargo.lock;

    meta = with lib; {
      description = "lowfi is a tiny rust app that serves a single purpose: play lofi. It'll do this as simply as it can: no albums, no ads, just lofi.";
      homepage = "https://github.com/talwat/lowfi";
      license = with licenses; [
        mit
      ];
      mainProgram = "lowfi";
    };
  }
