---
title: "Tiling WMs and systemd: Two Great Tastes"
date: 2025-03-19T00:00:00-06:00
draft: false
tags: ["linux", "systemd", "niri", "hyprland", "ricing", "nix", "nixos"]
downloads: []
blog: true
---

One thing I've always found cumbersome about configuring a tiling window
manager is dealing with all the extra programs you need to launch on
startup. Most WMs have a config setting for running one-off commands to
start your status bar, set your background, and so on. This feels like
an afterthought and is a pain to debug when one of those programs
inevitably crashes.

The solution? systemd. I was browsing the documentation for niri the
other day and noticed [this](https://github.com/YaLTeR/niri/wiki/Example-systemd-Setup) 
handy page. It struck me: for years, I've been making this process so
much more painful than it needed to be. Turns out, systemd has a target
just for launching things on desktop startup:
`graphical-session.target`.

Maybe this is already obvious to folks. I had definitely come across it
before, but never stopped to consider that I could configure all my
startup programs like this. Check this out:

```
# /home/ciaran/.config/systemd/user/swaybg.service
[Install]
WantedBy=graphical-session.target

[Service]
ExecStart=swaybg -i /home/ciaran/desktop.png
Restart=on-failure

[Unit]
After=graphical-session.target
ConditionEnvironment=WAYLAND_DISPLAY
Description=Wallpaper tool for Wayland compositors
PartOf=graphical-session.target
```

And there, with a single service file, you get:

1. Portability between window managers
2. The ability to trivially inspect logs when something unexpected
   happens
3. A way to restart your services when they crash without having to look
   up their CLI flags in your dotfiles

Please note: I don't claim to be an expert in configuring systemd. The
service config above is adapted from the built-in waybar config in
home-manager. There may be room for improvement here.

As you can see from the comment at the top of the snippet, this is a
user service, not a system service. Don't forget to use `--user`, e.g.
`systemctl cat --user swaybg.service`.

One more thing: in reality, I'm configuring these services via Nix with
home-manager. The actual config looks like this:

```nix
systemd.user.services.swaybg = {
  Install = {
    WantedBy = ["graphical-session.target"];
  };
  Service = {
    ExecStart = "${lib.getExe pkgs.swaybg} -i ${cfg.wallpaperPath}";
    Restart = "on-failure";
  };
  Unit = {
    After = ["graphical-session.target"];
    ConditionEnvironment = "WAYLAND_DISPLAY";
    Description = "Wallpaper tool for Wayland compositors";
    PartOf = ["graphical-session.target"];
  };
};
```
