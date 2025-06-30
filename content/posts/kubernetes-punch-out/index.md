---
title: "Kubernetes: Four Ways to Punch Out"
date: 2025-06-16T00:00:00-06:00
draft: false
tags: ["kubernetes"]
downloads: []
blog: true
---

{{< wrapimg src="glass_joe.gif" alt="Glass Joe" align="right" >}}

In my day job I work with EKS, where I almost exclusively rely on `LoadBalancer` and `ClusterIP` Services for external and internal networking, respectively. Things are often not so straightforward in the homelab or on local, temporary clusters, and every once in a while I find myself needing a refresher on what my other options are. Here are the four essential ways to let external traffic into your cluster:

1. `LoadBalancer` Service type
   - Requires integration with some external load balancer provider, usually pre-configured as part of a batteries-included Kubernetes distribution like EKS or GKE. Alternatively, you can use [MetalLB](https://metallb.io/), but so far I've found it to be overkill in my homelab.
2. `NodePort` Service type
   - Allocates a port on the node that links to the Service. You can optionally specify a port with `service.spec.ports.nodePort`. The main constraint here is that the port must be in the range **30000 – 32767**.
3. `pod.spec.containers.ports.hostPort` field
   - Like a `NodePort` Service, this allocates a port on the host node. There are two key differences to note: First, `hostPort` is specified at the Pod level rather than at the Service level. Second, there is no restriction on what port you can allocate, though standard OS restrictions still apply (on Linux, ports **1 - 1023** can only be allocated by `root`).
   - The fact that `hostPort` is a Pod-level field has an important consequence: if you use `hostPort` (you should avoid it where possible), you must ensure that only one pod per node will ask for a given port. This way you will avoid port collisions. One way to mitigate this is by limiting your use of this field to inside DaemonSets. Presumably, you could also enforce this with a policy engine.
4. `kubectl port-forward` command
   - Forwards a port on the machine running the `kubectl` command, and terminates when the selected pod dies. This is only really useful for debugging purposes, but can be very handy when working with local clusters (e.g. `kind`).
