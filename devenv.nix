{ pkgs, lib, config, inputs, ... }:
let
  name = "nix_deploy";
in
{
  config = {
    languages = {
      rust = {
        enable = true;
        components = [ "rustc" "cargo" "clippy" "rustfmt" "rust-analyzer" ];
      };
    };

    env = {
      OPENSSL_DIR = "${config.env.DEVENV_PROFILE}";
      ADDRESS_AND_PORT="127.0.0.1:8080";
    };

    packages = [
      pkgs.openssl.dev
      pkgs.cargo-watch
      pkgs.gh
    ];


    processes = {
      "${name}".exec = "cargo watch -x run";
    };
  };
}
