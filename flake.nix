{
    description = "A flake for building a simple rust app";

    inputs = {
      nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
    };
  
    outputs = { self, nixpkgs, flake-utils }:
      flake-utils.lib.eachDefaultSystem(system:
        let 
          pkgs = import nixpkgs { inherit system; };
        in
        {
          packages = rec {
            nix-deploy = pkgs.rustPlatform.buildRustPackage {
              pname = "nix_deploy";
              version = "0.1";
              cargoLock.lockFile = ./Cargo.lock;
              src = pkgs.lib.cleanSource ./.;
              nativeBuildInputs = [
                pkgs.pkg-config
              ];
            };

            default = nix-deploy;
          };
        }
      );
}
