{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=22.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    lib = nixpkgs.lib;
  in {
    packages.${system} = {
      portfolio = pkgs.stdenv.mkDerivation {
        pname = "ciarandg-portfolio";
        version = ""; # unversioned
        src = ./.;
        nativeBuildInputs = [pkgs.hugo];
        buildPhase = "hugo";
        installPhase = ''
          mkdir -p $out
          cp -r ./public/* $out/
        '';
      };

      default = self.packages.${system}.portfolio;
    };

    apps.${system} = {
      dev = {
        type = "app";
        program = lib.getExe (pkgs.writeShellScriptBin "dev" ''
          ${lib.getExe pkgs.hugo} serve
        '');
      };
    };
  };
}
