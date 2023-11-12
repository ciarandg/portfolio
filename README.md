# Ciaran's Site

https://ciarandg.com

- Note that the `themes/hugo-theme-anubis` directory is a submodule

## Deployment
### Helm

The `helm` directory contains a basic Helm chart for hosting this site via nginx.

### Nix

- `pkgs.${system}.portfolio`
  - A derivation consisting of a `public` directory, which is a static site
    - e.g. `result/public/index.html`
- `pkgs.${system}.hugo-theme-anubis`

The `portfolio` package in `flake.nix` is a derivation that outputs the contents of a static site to `$out/public`, which is hostable using any webserver.
