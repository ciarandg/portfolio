# Ciaran's Site

https://ciarandg.com

- Note that the `themes/hugo-theme-anubis` directory is a submodule

## Deployment
### Helm

The `helm` directory contains a basic Helm chart for hosting this site via nginx.

### Nix

- `pkgs.${system}.portfolio` (also `pkgs.${system}.default`)
  - A derivation containing a static site
    - e.g. `result/index.html`
- `pkgs.${system}.hugo-theme-anubis`
  - A derivation containing the contents of the [repo](https://github.com/Mitrichius/hugo-theme-anubis) `Mitrichius/hugo-theme-anubis`

The `portfolio` package in `flake.nix` is a derivation that outputs the contents of a static site to `$out/public`, which is hostable using any webserver.
