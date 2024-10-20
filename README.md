# Ciaran's Site

https://ciarandg.com

Note that `themes/hugo-theme-anubis` is a submodule for my fork of the [archived](https://github.com/Mitrichius/hugo-theme-anubis) original theme. This repo should be cloned using `--recursive`.

## Deployment
### Helm

The `helm` directory contains a basic Helm chart for hosting this site via nginx.

### Nix

**Note:** unfortunately, Nix Flakes are currently incompatible with git LFS (which this repo is heavily reliant on), so best practice here is to use the Docker image or Helm chart.

- `pkgs.${system}.portfolio` (also `pkgs.${system}.default`)
  - A derivation containing a static site
    - e.g. `result/index.html`
- `pkgs.${system}.hugo-theme-anubis`
  - A derivation containing the contents of the [repo](https://github.com/Mitrichius/hugo-theme-anubis) `Mitrichius/hugo-theme-anubis`

The `portfolio` package in `flake.nix` is a derivation that outputs the contents of a static site to `$out/public`, which is hostable using any webserver.
