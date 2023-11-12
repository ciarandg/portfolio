{
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.portfolio = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      lib = nixpkgs.lib;
      in pkgs.stdenv.mkDerivation {
        name = "portfolio";
        src = ./.;
        buildPhase = ''
          ${pkgs.hugo}/bin/hugo
          mkdir -p $out
          mv public $out/public
        '';
      };
    packages.x86_64-linux.default = self.packages.x86_64-linux.portfolio;
  };
}
