---
title: "QuickSand"
date: 2021-04-21
draft: false
tags: ["vst", "juce", "c++", "effect", "interactive"]
gallery: true
downloads: [
    '[Source Code](https://github.com/ciarandg/QuickSand)',
    '[Binaries](https://github.com/ciarandg/QuickSand/releases)'
]
---

QuickSand is a live-input granular synthesis VST, made with JUCE. Rather than granulating a presupplied buffer (as traditional granular synthesizers do), QuickSand caches live input and granulates it in realtime.

![QuickSand's interface](/quicksand_interface.png)

QuickSand was designed as an alternative to the lack of spontaneity offered in classic granular synths. In VST terms, QuickSand's use of live input makes it an audio effect, rather than an instrument. This makes for a more dynamic user experience, and I hope it can help make granular synthesis a more convenient option in live performance!
