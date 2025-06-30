---
title: "My Homelab: The Ugly"
date: 2025-07-18T00:00:00-06:00
draft: false
tags: ["nixos", "terraform"]
downloads: []
blog: true
---

{{< wrapimg src="tim-allen.jpg" alt="a beautiful portrait of Tim Allen" align="right" max-height="300px" >}}

Lately I've been itching to rework my homelab. As I pack up my bindle, I want to take an accounting of the frustrations and pain points in my current setup.

# Context

My current homelab came about when I had just bought my first serious single-board server: an [ODROID H3+](https://www.hardkernel.com/shop/odroid-h3-plus/). It blew my old Raspberry Pi out of the water, and I was stoked to get my hands on something with [Quick Sync](https://en.wikipedia.org/wiki/Intel_Quick_Sync_Video) so I could finally build the [media](https://peach.blender.org/download/) [server](https://jellyfin.org/) of my dreams.

At the same time, I was geeking out about how many trendy Nix projects I could shove into my server. The [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) Terraform module was brand new, and offered an elegant solution for declarative systems management. I wanted to build a perfect system: one that had [impermanent state](https://github.com/nix-community/impermanence), declarative configuration right [down to the partition table](https://github.com/nix-community/disko), with all of its state backed by a ZFS mirror.

That ODROID box still runs all of my application workloads and talks to two tiny Linode boxes, which serve as a bastion server and a monitoring server connected over Tailscale. You might say: "Ciaran, it's not really a homelab if you have more cloud VMs than physical boxes." You'd probably be right, but that's what I've got.

## The State of Things

All systems come with tradeoffs. Although it's far from perfect, this setup has scaled pretty well. I'm running about 20 self-hosted services on my ODroid without any performance problems and solid uptime _(I'm not going to give you a number of nines)_. I'm focusing on the negative here; there are lots of benefits to my setup, but right now I want an honest accounting of its shortfalls for when I rework it.

First are the issues that are inherent to NixOS:

1. Configuring unattended upgrades is nasty business.
2. When you rebuild your system you get a derivation hash instead of a diff of what changed.
3. Rebuilds can be slow. If you build on your local machine, you're likely to be using a different nixpkgs revision to your server, and therefore will have to pull a ton of dependencies down to your disk.
4. While Nix has _some_ industry adoption, it's a far cry from being foundational tooling, and NixOS even less so. My homelab has the dual purpose of being something I do for fun in my free time while also (in theory) being a place to play with new technologies for the sake of my career. For better or worse, right now my work life centers around Kubernetes.

Next, I regret my choices for state management:

1. [Impermanence](https://github.com/nix-community/impermanence) is very cool, but I'm coming to regret using it. Maybe I could get it to a point where it doesn't feel quite so tedious by loosening the screws a little bit, but every time you do that, it feels like a loss. Running an impermanent server is a bit of an exercise in yak-shaving, especially as far as secrets management is concerned.
2. As a result of my state management choices integrating with each other so poorly, I have a 6-step manual process for adding a new service to my ODROID. This involves creating a new dataset over SSH and applying the NixOS state changes to get the mounts configured correctly before I actually enable the service. This is pretty far from the declarative dream I was sold on. NixOS falls down a bit when you try to make it manage things that need to be executed in a specific order.

Lastly, the issues that are (mostly) just moral failings on my part:

1. I have way too much duplication when it comes to hostnames and port numbers. This comes from the fact that all my services have a Caddy server sitting in front of them, either directly on my ODROID or on my bastion server. The Caddy server is configured in my NixOS config, whereas the DNS records are configured in Terraform, and I have not spent the time to think of a nice way to bridge between the two.
2. Currently I'm doing basic black-box alerting with Uptime Kuma, which has been a great experience. However, I'm feeding those alerts into Discord via a webhook, which is undesirable. I've gotten used to stateful PagerDuty incidents at my day job, and Discord notifications just aren't cutting it for me anymore. I'd like to figure out a nice free software solution for stateful incident alerting.
3. I still haven't set up SSL for my private services (the ones that don't go through my bastion server). I took a look at doing this with Tailscale but bounced off because they require using a `ts.net` subdomain, and I have my own prized collection of stupid domain names for personal use. I think the way to configure this correctly would be via a DNS challenge, but I haven't bothered  try to configure that declaratively yet.
4. Because my Nix configs for my homelab are completely separate from the configs that I use for my laptops and desktop, my carefully manicured shell environment is not present on my servers. This is a minor annoyance, and could be resolved through flake inputs or by merging the two repositories.
5. I still haven't set up a proper 3-2-1 backup system.

## My Wishlist

### Must-Haves

1. All application state must be backed by ZFS. Dataset creation should be easy and declarative. I don't care that much about whether pool creation/management is declarative.
2. I need unattended upgrades for my base OS. I think that if I settle on NixOS, that means I'll need to configure some over-engineered CI/CD nightmare.
3. My configuration must be declarative. I should not be shelling into machines in order to initialize or reconfigure applications.
4. A complete backup and restore solution.
5. SSL on everything.

### Nice-To-Haves

1. Some support for clustering and HA. This almost certainly means Kubernetes. I could dig into Nomad again, but that's not very useful for cynical career development reasons. I don't actually care about HA for its own sake, but I do care about having a bunch of little computers talking to each other in a mini rack. It's just neat.
2. A stateful alerting system.
3. Define each hostname one time.
4. Expose services to the public without needing a dedicated bastion server.
