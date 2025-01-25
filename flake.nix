{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
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

      # nix run .#pull-assets downloads all static content from object storage to ./static/
      pull-assets = {
        type = "app";
        program = lib.getExe (pkgs.writeShellScriptBin "pull-assets" ''
          ${lib.getExe pkgs.s3cmd} sync s3://ciarandg-portfolio/ ./static/
        '');
      };

      # nix run .#push-assets uploads all static content from ./static/ to object storage
      push-assets = {
        type = "app";
        program = lib.getExe (pkgs.writeShellScriptBin "push-assets" ''
            ${lib.getExe pkgs.s3cmd} sync --acl-public ./static/ s3://ciarandg-portfolio/
        '');
      };
    };
  };
}
