# Ciaran's Portfolio Website

https://ciarandg.com

Note that `themes/hugo-theme-anubis` is a subtree containing my fork of the [archived](https://github.com/Mitrichius/hugo-theme-anubis) original theme.

## Usage

`flake.nix` contains several packages and scripts for running the site. Importantly, static assets (images, audio, etc.) are not tracked in version control, and instead rely on the `pull-assets` and `push-assets` scripts to pull and push from object storage. The `Dockerfile` is what I'm currently running in production (via Netlify); it builds the site using Nix and then serves the static content with Nginx.
