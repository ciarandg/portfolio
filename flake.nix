{
  inputs.hugo-theme-anubis.url = "github:Mitrichius/hugo-theme-anubis";
  inputs.hugo-theme-anubis.flake = false;

  outputs = { self, nixpkgs, hugo-theme-anubis, ... }: let
    system = "x86_64-linux";
  in {
    packages.${system} = let
      pkgs = nixpkgs.legacyPackages.${system};
    in rec {
      portfolio = pkgs.stdenv.mkDerivation {
        name = "portfolio";
        src = ./.;
        buildPhase = ''
          ${pkgs.hugo}/bin/hugo
          mkdir -p $out
          mv public $out/public
        '';
      };
      default = portfolio;
    };
  };
}
