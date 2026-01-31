---
title: "Markdown Preview in Helix with go-grip"
date: 2026-01-31T00:00:00-06:00
draft: false
tags: ["helix", "docs", "markdown"]
downloads: []
blog: true
---

I spend a fair bit of time editing Markdown files in [Helix](https://helix-editor.com/). By and large, these are GitHub Flavored Markdown, and I get sick of needing to push up my changes to see how GitHub would actually render the source code. Today I went ahead and found a solution.

[go-grip](https://github.com/chrishrb/go-grip) is a handy little tool that launches a live-reload webserver for rendering GitHub Flavored Markdown files. Just install it and drop this in your Helix config:

```toml
[keys.normal.C-p]
g = ":sh pkill go-grip || true; go-grip --theme dark %{buffer_name} > /dev/null || true"
```

or in [home-manager](https://github.com/nix-community/home-manager):

```nix
programs.helix = {
  settings.keys.normal = {
    C-p = {
      g = ":sh ${pkgs.procps}/bin/pkill go-grip || true; ${lib.getExe pkgs.go-grip} --theme dark %{buffer_name} > /dev/null || true";
    };
  };
};
```

Now if you press `Ctrl+P` followed by the `g` key, `go-grip` will open a tab in your browser so you can preview your Markdown file as you edit it!

Note that by preventing non-zero exit codes via `|| true`, you avoid seeing error messages inside of Helix. This is necessary for both the `pkill` command and the `go-grip` command because:

1. `pkill` returns an exit code of 1 if there's no `go-grip` process currently running
2. `go-grip` returns an exit code of 1 when killed by `pkill`

Additionally by redirecting `go-grip`'s stdout to `/dev/null`, you prevent Helix from showing a dialog box with the server URL, which seems unnecessary to me since `go-grip` launches a browser tab anyhow.
