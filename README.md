# Ciaran's Portfolio Website

https://ciarandg.com

## Usage

`flake.nix` contains several packages and scripts for running the site. Importantly, static assets (images, audio, etc.) are not tracked in version control, and instead rely on the `pull-assets` and `push-assets` scripts to pull and push from object storage.

In production, the site is built and deployed via Netlify. See `netlify.toml` for config.
