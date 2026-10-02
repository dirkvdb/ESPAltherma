{
  description = "infra-rs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    rust-overlay.url = "github:oxalica/rust-overlay/stable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells = {
          default =
            with pkgs;
            mkShell {
              buildInputs = [
                clang-tools
                just
                pixi
                python310
                samba
                platformio
                mosquitto
              ];
              shellHook = ''
                export PATH="${clang-tools}/bin:$PATH"
                exec fish
              '';
            };
        };
      }
    );
}
