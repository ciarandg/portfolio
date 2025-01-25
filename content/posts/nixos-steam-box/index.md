---
title: "Turn Your PC Into a Steam Box with Jovian-NixOS"
date: 2025-01-25T00:00:00-06:00
draft: true
tags: ["nix", "nixos", "jovian-nixos", "steam", "gaming"]
downloads: []
blog: true
---

## Preface

For years, I've wanted to build a Steam Box: a generic PC, repurposed into a Steam-powered gaming console. Prior to the advent of the Steam Deck, there had been two long-standing issues that kept me from realizing my Steam Box dreams.

The first blocker was Linux game compatibility. Plenty of ink has been spilled already on Proton and how it has fundamentally changed the Linux gaming landscape; I don't think I need to add to that.

The second issue is more fundamental to desktop Linux: Desktop Environments don't play nice with Steam in Big Picture mode. Even with mainstream DEs like KDE Plasma, I have seen games do all of the following:

- Launch in a separate, non-fullscreen window, sitting on top of the Big Picture interface
- Arbitrarily decide to ignore controller input, despite having built-in controller support
- Refuse to exit via the Big Picture UI

Much like Proton, Valve has built a solution for the Linux community in the form of [gamescope](https://github.com/ValveSoftware/gamescope). For the unfamiliar, `gamescope` is a Wayland compositor specifically designed to tackle these problems. Importantly, it _just works_, and because it's a Wayland compositor, you can even launch it as a window in any DE (sandboxed) to escape the windowing headaches I described above.

Finally, the Linux ecosystem has reached a point where you can build a viable, competitive gaming console on your own hardware. Most importantly, if you're a NixOS dead-ender like myself, it's a breeze.

## Setting Standards

Here's are some criteria that I consider necessary for a viable Steam Box:

- Full controller support and controller pairing within the UI
- No need to think about the concept of a window
- No need to touch a keyboard or a mouse if you just want to play a game
- An easy escape hatch out to access your Linux system in a regular DE

## Enter: Jovian

[Jovian-NixOS](https://github.com/Jovian-Experiments/Jovian-NixOS) is a project primarily intended for running NixOS on the Steam Deck. It recreates much of the Steam Deck software environment on top of NixOS, and lets you opt in to specific aspects of it through NixOS modules. Fortunately for us, its modular architecture means that we can easily run it on generic hardware.
