---
title: "The Beginnings of a Talos Homelab"
date: 2025-11-01T00:00:00-06:00
draft: false
tags: ["talos", "kubernetes", "homelab", "terraform", "devops", "homelab"]
downloads: []
blog: true
tableOfContents: true
---

<!-- {{< wrapimg src="tim-allen.jpg" alt="a beautiful portrait of Tim Allen" align="right" max-height="300px" >}} -->

In my [previous post](/archive/homelab-ugly/), I described the issues I've been having with my current homelab. I'm still working on the replacement, so this post is going to describe the intermediary state my homelab is currently in, my initial impressions of [Talos Linux](https://www.talos.dev/), and some hurdles I've run into along the way.

## The Appeal of Talos

I've been eyeing Talos Linux for a while as a potential platform for a homelab. Having experienced the tedium of building bare-metal Kubernetes clusters on both NixOS and Ubuntu, I am drawn to the concept of a "Kubernetes-only" Linux distribution. Talos is exciting because it's so stripped down: the ISO clocks in at a mere 300 megabytes, and it completely omits SSH authentication in favor of an API-based approach to system management.

However, there are clear reasons to be wary about Talos. It is a product of corporate open-source with a relatively small community. Sidero are eager to upsell their other products and are not necessarily incentivized to provide a stable and open platform. Additionally, anything you want to do at the system level on a Talos machine has to be packaged as an [extension](https://github.com/siderolabs/extensions) and baked into your image. This includes both ZFS and Tailscale support, both of which are going to be crucial for me moving forwards.

I have not yet settled on Talos as a long-term solution. However, I feel relatively secure in the knowledge that the node-level software I need to run on my Kubernetes clusters is a thin enough layer that I can lift-and-shift to another platform with relative ease when I need to.

## My Current State

Currently, I have a single-node Talos cluster running bare-metal on an [ODROID H4+](https://www.hardkernel.com/shop/odroid-h4-plus/). The cluster is running Flannel (which comes pre-installed), `ingress-nginx`, and MetalLB. I've got application ingress fully working on a static IP within my LAN, but have not yet attempted to expose services to the public or to a VPN. This is my first time using both Flannel and MetalLB. So far I haven't had to give Flannel any thought or configuration at all though that may change as I expand to a multi-node cluster. MetalLB has presented a bit more of a learning curve, as I'll explain below, but so far I've been impressed by it overall.

The cluster itself is provisioned using the [Talos Terraform provider](https://registry.terraform.io/providers/siderolabs/talos/latest). For simplicity's sake, I'm currently managing on-cluster resources with the Helm and Kubernetes Terraform providers, though I will be assessing several other options including Yoke, Helmfile, and ArgoCD going forwards.

## Terraform Management

I am thankful that the Talos Terraform provider exists, because without it I would likely not be using Talos at all. However, the provider suffers from a clunky user experience, to the point that it feels like an afterthought. I spend a pretty big chunk of my professional life writing and managing Terraform configs, and find that most providers fall into one of two camps: polished and effortless, or shonky and slapped-together. It's disappointing to see a first-class provider from a commercial vendor fall clearly into the second category.

My main point of contention is that changes to your MachineConfigs have to be done by applying a sequence of patches to an existing configuration, rather than by simply modifying the configs directly. I don't know about you, but I'm not too keen on the idea of making machine management more like managing MySQL migrations in a Rails application. Further, I have not had to upgrade my Talos cluster yet, but I've seen that supposedly you cannot upgrade a cluster via the Terraform provider and instead have to do it imperatively. While not a deal-breaker, I do find this pretty disappointing.

Despite this, it's worth highlighting that the Talos provider comes with an excellent [set of examples](https://github.com/siderolabs/contrib/tree/main/examples/terraform). I adapted my own config from the [basic](https://github.com/siderolabs/contrib/tree/main/examples/terraform/basic) one, which got me up and running in no time.

## Snags and Configuration Tips

### Reinstalling Talos

When you boot from a Talos live image on a system that already has Talos installed, it will refuse to overwrite the existing install. There is a kernel parameter to overwrite this behavior, but I can't be bothered with that. I have reinstalled Talos a few times on my system by booting to another distro's live image, writing `/dev/zero` to my disk, and then rebooting to the Talos live image for a fresh install.

### Node IP Addresses

Each Talos node has an IP address hardcoded into its MachineConfig. This makes for a slightly annoying situation when you reboot your machine only to find that now your node has been given a new IP by DHCP, which doesn't align with the one in its config. Fortunately this doesn't prevent you from connecting to the node via `talosctl` on the new IP and updating its config, but it doesn't exactly inspire confidence. For this reason (and [another](#a-very-annoying-mystery) described below), I would recommend configuring static IPs for your nodes and making sure that they aren't in your router's DHCP range.

### Single-Node Cluster Quirks

If you are running a single-node cluster, make sure to allow your control plane nodes to schedule worker pods with the following MachineConfig patch:

```yaml
cluster:
  allowSchedulingOnControlPlanes: true
```

Similarly for MetalLB's L2 advertisement to work on a single-node cluster, you'll need to remove the `node.kubernetes.io/exclude-from-external-load-balancers` label from your node with this patch:

```yaml
machine:
    nodeLabels:
        node.kubernetes.io/exclude-from-external-load-balancers:
            $patch: delete # allow loadbalancer l2 advertisement on the control plane
```

### MetalLB Configuration

Those familiar with MetalLB will not need this reminder, but nonetheless: read the documentation thoroughly and remember that you **must** manually create an `IPAddressPool` resource and an `L2Advertisement` resource in order to have a working install (assuming you're using L2 rather than BGP). For a configuration as simple as mine, it's dead easy:

```yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: lan
  namespace: metallb-system
spec:
  addresses:
  - 10.0.0.3/32
```

```yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: lan
  namespace: metallb-system
spec:
  ipAddressPools:
  - lan
  nodeSelectors:
  - matchLabels:
      kubernetes.io/hostname: home-01-cp-0
```

You may notice that my address pool is only a single address. This is because currently I am using the Nginx Ingress service as my only entry point, and configuring ingress resources that point to `ClusterIP` services for each of my applications, rather than configuring a `LoadBalancer` service for each application. This may not be best practice; I have restricted my pool to a `/32` for predictability's sake while I'm getting building things out, but I'll probably expand it later.

Additionally, make sure that the namespace you install MetalLB on has the correct labels:

```yaml
pod-security.kubernetes.io/enforce: privileged
pod-security.kubernetes.io/audit: privileged
pod-security.kubernetes.io/warn: privileged
```

Lastly, remember that the [troubleshooting guide](https://metallb.io/troubleshooting/) and standard Linux networking tools (`ping`, `ip neigh show`, `arp`, `curl -v`) are on your side! In honesty, low-level networking is not my strong suit and consulting an LLM was quite helpful here.

### A Very Annoying Mystery

Last but not least: a couple minutes after configuring MetalLB and loading the Nginx 404 page in my laptop's browser, I suddenly started receiving `Connection Refused` errors. I dug through the MetalLB troubleshooting guide, checked all of my pod logs, and scoured `talosctl dmesg` with no leads. Soon enough I found that restarting MetalLB's speaker pod would fix the issue for a couple minutes, after which my configuration would break again. Running a `watch ip neigh show` was what tipped me off to the issue: another device on my network was snatching my ingress' IP address.

It turns out that the router supplied by my ISP is configured by default to treat its entire subnet as addressable for DHCP, resulting in an address collision between my ingress and a thermostat in my house. After reducing the DHCP address space on my router and restarting it to trigger lease expiry, my ingress was back in working order.
