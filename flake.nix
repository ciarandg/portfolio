{
  inputs.hugo-theme-anubis.url = "github:Mitrichius/hugo-theme-anubis";
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
          mkdir -p $out/share
          cp -r ./* $out/share/
        '';
      };
      portfolio = pkgs.stdenv.mkDerivation {
        name = "portfolio";
        src = ./.;
        buildPhase = ''
          ${pkgs.hugo}/bin/hugo
          mkdir -p $out/themes
          cp -r public $out/public
          cp -r ${hugo-theme-anubis}/share $out/public/themes/hugo-theme-anubis
        '';
      };
      default = portfolio;
    };
  };
}
