---
title: "Rust for the Weekend Warrior"
date: 2025-04-20T00:00:00-06:00
draft: false
tags: ["rust"]
downloads: []
blog: true
---

Recently I've been dabbling in Rust. This post is an attempt to collect my thoughts on the language and toolchain, particularly for working on smallish hobby projects. These points are likely obvious to Rust evangelists.

## Context

At my day job, I find myself mostly programming in Python and TypeScript, along with a bit of Ruby and Go. Away from work, I'm enamored with functional programming, but I don't find strict functional code particularly natural to write for most of my use cases. Lisps have been great fun for me because they scratch a puzzle-solving itch, but when I just want to build something with limited time constraints, I find myself most at home in languages that are neither strictly procedural nor strictly functional.

Prior to Rust, the language I've found myself most productive with is Kotlin, but its ties to the Java ecosystem (_Gradle_) cause too much pain for me to use it on a regular basis. TypeScript can also be great fun to write, but is plagued by mountains of legacy weirdness (both in the toolchain and in the language itself), and is just too rooted in the web browser for me to use it outside that context.

## Bash Your Way Through, but Don't Get Too Far

One of the stumbling blocks I've found with functional programming is that there is too much friction when I just want to take the fastest path to some working code. Maybe I'm just too entrenched in procedural programming, but if so, I'm certainly not alone in this feeling; I end up thinking more about semantics than the actual problem. This is a real annoyance for me when working on hobby projects: if I only have half an hour to spend on some code, I would really like to be able to bash something out and then come back to it later to refine.

With Rust, I'm free to write my logic the obvious, intuitive, and maybe even suboptimal way. I can get surprisingly far before having to think about the borrow checker. Crucially though, when the compiler _does_ start to get on my nerves, I have seen that more often than not, there is an underlying architectural issue I need to address. This creates a sort of baked-in refactoring cycle that I have come to appreciate.

## Null Safety and Error Handling

Seriously: why even have a strong type system if it's not going to be null safe? I think that's about all I've got to say on the topic. Rust's approach to error handling feels similarly obvious when contrasted with exceptions, taking best practices from the functional programming world.

The downside is that sometimes these features can feel like they're weighing you down just a bit when you're trying to implement a happy path. Fortunately, you can opt out of some safety with `unwrap()` and `expect()`, and sufficiently strong linting rules can force you to clean up your mess when you're done.

## Ergonomics are Empowering

Rust is a systems programming language. I'm not a systems programmer. However, Rust makes me feel like I can LARP as one on my days off. I can't stand writing C and C++, not for lack of trying. As I become more confident with Rust, I'm finding myself more and more excited to pull out my dusty copy of _The Linux Programming Interface_, or to get back into audio programming and DSP.

## Tooling

I yearn for JetBrains-tier language/editor integration. Rust doesn't quite achieve that, but manages to dodge the vendor lock-in that is so pervasive in the Java/Kotlin ecosystem. I started writing Rust in VSCode for comfort's sake, but am more recently forcing myself to use Helix. So far it has been fairly frustrating and uncomfortable, but I'm holding out hope that it will either click with me, or that I will Stockholm Syndrome myself into enjoying using it, because Neovim's LSP plugins (CoC et al) just feel junky to me. I know that recent versions of Neovim have native LSP support; I have yet to give it a spin, but am finding myself generally more attracted to Helix's batteries-included approach anyhow.

I haven't fully wrapped my head around Nix integrations yet. I can get reasonably far in NixOS with just installing components via Cargo, and I'm currently using [crane](https://github.com/ipetkov/crane) to build my crates. However I'm already bumping up against the boundaries of my setup when trying to configure code coverage reporting. 
