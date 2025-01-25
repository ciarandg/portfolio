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
  in {
    packages.${system} = {
      portfolio = let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
        pkgs.stdenv.mkDerivation {
          pname = "ciarandg-portfolio";
          version = "1.0";

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
  };
}
