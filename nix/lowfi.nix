{
  makeRustPlatform,
  rust-bin,
  alsa-lib,
  openssl,
  pkg-config,
}:
let
  toolchain = rust-bin.stable.latest.default;
  rustPlatform = makeRustPlatform {
    cargo = toolchain;
    rustc = toolchain;
  };
in
rustPlatform.buildRustPackage {
  pname = "lowfi";
  version = "1.5.3";

  buildInputs = [ alsa-lib openssl ];
  nativeBuildInputs = [ pkg-config ];

  src = ../.;
  cargoLock.lockFile = ../Cargo.lock;
}
