build:
  nix run nixpkgs#hugo
serve:
  nix run nixpkgs#hugo -- serve

# Assets commands require ~/.s3cfg to be configured
# Both push and pull are intentionally non-destructive
push-assets:
  nix run nixpkgs#s3cmd -- sync ./static/ s3://ciarandg-portfolio/
pull-assets:
  nix run nixpkgs#s3cmd -- sync s3://ciarandg-portfolio/ ./static/
