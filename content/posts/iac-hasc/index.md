---
title: "Infrastructure as Code, Humans as Second-Class"
date: 2025-03-01T00:00:00-06:00
draft: false
tags: ["devops", "terraform"]
downloads: []
blog: true
---

I spend quite a lot of my waking hours working with Terraform. It's a love-hate relationship. I think people already have a sense for what's great about Terraform, and most of the alternatives I see cropping up (looking at you, Pulumi) seem like solutions in search of a problem. I'm open to having my mind changed on that. However, to my mind, Terraform's greatest weaknesses come from a disregard for user experience. Obviously, this list is non-exhaustive.

- In any non-trivial Terraform setup, you are developing from one directory (your shared code) and executing from another (your environment-specific module). This split introduces a small but constant element of friction.
- The dependency tree is brittle because everything is so explicit: too often, you change something in one place and have to fix the same thing further up the module chain.
- The feedback loop is painful. Making a slew of network requests each time you want to evaluate your code is frustrating, and finding the resource path (nested behind one or more modules) to type out a targeted plan is often time-consuming enough that it's quicker to just sit through a regular plan.
- Inspecting your state is way more work than it should be. I want to be able to pull out some value four layers deep into my state without having to thread an output through several modules.
- You are building a dependency graph of all your infrastructure, but visualizing its structure is not treated as a priority.
- Figuring out how to import an existing resource is an annoyance.
- Plan readouts are huge and filled with things I don't care about, and interacting with them in a data-driven manner is two hops away (`terraform plan -out=<file>; terraform show -json <file>`).

---

- I want building systems to feel dynamic and flexible.
- I want REPL-driven Infrastructure as Code.
- I want the text representation and the runtime to intertwine.
- I want the third-party services that I'm interfacing with to bring themselves to me, rather than me going to them.
- I want to dig through my Terraform state without leaving my editor.
- I don't want to feel like I was born to restructure JSON for the rest of my days.
