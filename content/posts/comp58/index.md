---
title: "Comp58"
date: 2020-05-11T15:34:38-06:00
draft: false
tags: ["faust", "effect", "minimal"]
downloads: [ "[Source Code](https://github.com/ciarandg/nix-home/blob/ee35f0eba25d669e312f45a118b81d27ce74a814/programs/comp58/src/comp58.dsp)" ]
---

A tiny effects chain, written in Faust, for easily routing dynamic mic input (in
my case, an SM58) into applications that expect line-level webcam input
(Discord, Zoom, Skype, etc) via JACK. Includes sensible defaults, controls for
tweaking on the fly, and input/output VU meters. Usually I compile it using
`faust2jack` (JACK + GTK), but any `faust2` script with GUI support should work.

`_ -> noise gate -> signal multiplier -> dynamic compressor -> _`
