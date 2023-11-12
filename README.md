# Ciaran's Site

https://ciarandg.com

## Deployment
### Helm

The `helm` directory contains a basic Helm chart for hosting this site via nginx.

### Nix

The default package in `flake.nix` is a derivation that outputs the contents of a static site to `$out/public`, which is hostable using any webserver.
