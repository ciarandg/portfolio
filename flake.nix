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
      # nix build .#public generates the contents of a static site
      public = pkgs.stdenv.mkDerivation {
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

      default = self.packages.${system}.public;
    };

    apps.${system} = {
      # nix run .#dev runs a development server with hot reload
      dev = {
        type = "app";
        program = lib.getExe (pkgs.writeShellScriptBin "dev" ''
          ${lib.getExe pkgs.hugo} serve
        '');
      };
      develop = self.apps.${system}.dev;
    };
  };
}
