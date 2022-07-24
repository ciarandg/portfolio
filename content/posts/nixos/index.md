---

title: "NixOS Configuration"
date: 2021-04-28
draft: false
tags: ["linux", "nixos", "nix"]
gallery: false
downloads: [
  "[NixOS Config](https://github.com/ciarandeg/nixos-config)",
  "[Home-Manager Config](https://github.com/ciarandeg/nix-home)"
  ]

---

In spring of 2021 I migrated my laptop configuration over to [NixOS](https://nixos.org),
a stateless Linux distribution backed by the purely functional package
manager, Nix. My configuration is split between two repositories: a base
NixOS config that contains all of my core utilities, and my
[home-manager](https://github.com/nix-community/home-manager)
configuration, which has all the graphical tools, scripts, and
quality-of-life tweaks that I rely on day-to-day.

**Note:** These two repos are loosely coupled, as my [dwm build](../dwm/)
(which is included in the main configuration) has bindings for several
of the scripts and programs that are bundled in my home-manager config.
