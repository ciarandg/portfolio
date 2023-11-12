{
  inputs.hugo-theme-anubis.url = "github:Mitrichius/hugo-theme-anubis/1.1";
  inputs.hugo-theme-anubis.flake = false;

  outputs = { self, nixpkgs, hugo-theme-anubis, ... }: let
    system = "x86_64-linux";
  in {
    packages.${system} = let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      hugo-theme-anubis = pkgs.stdenv.mkDerivation {
        name = "hugo-theme-anubis";
        src = self.inputs.hugo-theme-anubis;
        buildPhase = ''
          mkdir -p $out
          cp -r ./* $out/
        '';
      };
      portfolio = pkgs.stdenv.mkDerivation {
        name = "portfolio";
        src = ./.;
        buildPhase = ''
          cp -r ${hugo-theme-anubis} ./themes/hugo-theme-anubis
          ${pkgs.hugo}/bin/hugo
          mv public $out
        '';
      };
      default = portfolio;
    };
  };
}
