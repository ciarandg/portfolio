---
title: "Turn Your PC Into a Steam Box with Jovian-NixOS"
date: 2025-02-27T00:00:00-06:00
draft: false
tags: ["nix", "nixos", "jovian-nixos", "steam", "gaming"]
downloads: []
blog: true
tableOfContents: true
---

## Preface

For years, I've wanted to build a Steam Box: a generic PC, repurposed into a Steam-powered gaming console. Prior to the advent of the Steam Deck, there had been two long-standing issues that kept me from making this happen.

The first blocker was Linux game compatibility. Plenty of ink has been spilled already on Proton and how it has changed the Linux gaming landscape; I don't think I need to add to that.

The second issue is more fundamental to desktop Linux: Desktop Environments aren't designed to be used as gaming consoles, and they don't play nice with Steam in Big Picture mode. Even with mainstream DEs like KDE Plasma, I have seen games do all of the following:

- Launch in a separate, non-fullscreen window, sitting on top of the Big Picture interface
- Launch in fullscreen, but with the game content in the top-left corner and the rest of the screen filled with black
- Arbitrarily decide to ignore controller input, despite having built-in controller support
- Refuse to exit via the Big Picture UI

Fortunately, Valve has built a solution for the Linux community: [gamescope](https://github.com/ValveSoftware/gamescope). For the unfamiliar, `gamescope` is a Wayland compositor specifically designed to tackle these problems. Importantly, it _just works_, and because it's a Wayland compositor, you can launch it as a sandboxed window in any DE to avoid the headaches I described above.

Finally, the Linux ecosystem has reached a point where you can build a viable, competitive gaming console on your own hardware. Most importantly, if you're a NixOS dead-ender like myself, it's a breeze.

## Setting Standards

Here's are some criteria that I consider necessary for a viable Steam Box:

- Full controller support and controller pairing within the UI
- No need to think about the concept of a window
- An easy escape hatch out to access your Linux system in a regular DE
- No need to touch a keyboard or a mouse if you just want to play a game
  - Frustratingly, I haven't quite gotten here yet, as I still need to sign into my Steam Box with a keyboard at startup. If you're comfortable with automatic login, Jovian's `autoStart` feature achieves this (or purports to, anyway—I have not had luck getting it working myself).

## Enter: Jovian-NixOS

[Jovian-NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS) is a project primarily intended for running NixOS on the Steam Deck. It recreates much of the Steam Deck software environment on top of NixOS, and lets you opt in to specific aspects of it through NixOS modules. Fortunately for us, its modular architecture means that we can easily run it on generic hardware.

An important note: Currently, Jovian only supports the `nixos-unstable` branch of `nixpkgs`. If your config is using a stable release (e.g. `24.11`), your mileage may vary.

I'm going to assume that you are using a flake-based NixOS configuration. If you're not, see Jovian's [docs](https://github.com/Jovian-Experiments/Jovian-NixOS/blob/development/docs/getting-started.md#configuring-the-software) for how to fetch the tarball directly.

### Importing the Jovian-NixOS Module

First, add Jovian as an input to your `flake.nix`:
```nix
{
  inputs.jovian = {
    url = "github:Jovian-Experiments/Jovian-NixOS";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

A reminder: using `inputs.<name>.follows` is always a tradeoff. You will gain a consistent set of package between Jovian and your system's core `nixpkgs`, which I think is worthwhile given that Jovian reaches pretty low into the desktop stack. However, you are introducing a risk of breakages if Jovian's Nix code makes any assumptions that are innaccurate for your particular version of `nixpkgs`. For this reason, I suggest running `nix flake update nixpkgs` before making this change, so that you are running the latest version of `nixpkgs`.

Now that you've added the flake input, you'll also need to import the Jovian NixOS module into your config. Wherever your call to the `nixosSystem` function is, you should add it to the `modules` list like so:

```nix
{
  outputs = {self, nixpkgs, jovian, ...}: {
    nixosConfigurations.steam-box = nixpkgs.lib.nixosSystem {
      system = "x86-64_linux";
      modules = [
        jovian.nixosModules.default
      ];
    };
  }
}
```

### Jovian Configuration Options

Here's a broad overview of the configuration options in Jovian:

```md
- `jovian.steam`
  - `jovian.steam.enable`
    - This is the most important setting for our purposes. Enabling this will
      install Steam and `gamescope`, along with a bunch of other low-level
      configuration (udev rules, polkit config, environment variables, and so on).
  - `jovian.steam.autoStart`
    - If enabled, Jovian will configure your machine to boot straight into
      `gamescope`. This involves overriding your Display Manager, so you need to
      disable e.g. `sddm` if you're going to use this.
  - `jovian.steam.user`
    - Only relevant if you have enabled `autoStart`. This option determines which
      user Jovian will automatically sign in as, in order to launch `gamescope`.
  - `jovian.steam.desktopSession`
    - Only relevant if you have enabled `autoStart`. This option determines which
      environment you'll switch to if you switch to the desktop from the Steam UI.
      If unconfigured, you will get booted to your Display Manager when you try to
      switch to the desktop. If you're not sure what value to set for this, try
      setting an invalid string; the error message will list the current valid
      options for your system.
- `jovian.hardware`
  - `jovian.hardware.has.amd.gpu`
    - If you have an AMD GPU, you need to set this to `true`.
  - `jovian.hardware.amd.gpu.enableEarlyModesetting`
    - Enables early kernel modesetting for your GPU. For me, enabling this just
      gave me an inescapable blackscreen, and I don't care enough about KMS to
      want to fix it.
  - `jovian.hardware.amd.gpu.enableBacklightControl`
    - Adds a udev rule to loosen permissions on backlight access. As far as I can
      tell, this would be used for automatically dimming your display on
      inactivity. I don't think this is particularly relevant for a setup with a
      TV.
- `jovian.steamos`
  - Contains settings for things like Bluetooth and automount that mirror stock
    Steam Deck configs. Personally, my view is that you may as well configure
    these things outside of Jovian, but you may find more use than me.
- `jovian.devices`
  - Currently, this group of options only contains settings that are specific to
    the Steam Deck hardware. As a result, we don't need to worry about them!
```

For more info, see the various `README` files inside Jovian's [modules directory](https://github.com/Jovian-Experiments/Jovian-NixOS/tree/development/modules).

## My Config

I generally run Hyprland on my machines, but for the sake of a media PC, I think Plasma is a very comfortable environment. You should be able to pretty much mix and match whatever Display Manager and Desktop Environment you want with this config, though.

Note: My graphics card is a Radeon RX 6600. Your mileage may vary with other cards.
```nix
{
  # These are all the unfree dependencies required by `jovian.steam.enable`
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steamdeck-hw-theme"
      "steam-jupiter-unwrapped"
      "steam"
    ];

  jovian = {
    steam.enable = true;
    hardware.has.amd.gpu = true;
  };

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    settings = {
      General = {
        # Scale SDDM UI by 2x for TV
        GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=2";
      };
    };
  };
  services.desktopManager.plasma6.enable = true;
}
```

## Troubleshooting

- Command to run gamescope from a regular Wayland session: `start-gamescope-session`
  - This way you can easily see the console logs from gamescope!
