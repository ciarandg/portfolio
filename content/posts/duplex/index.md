---
title: "Duplex (Max/MSP)"
date: 2020-03-06
draft: false
tags: ["max", "instrument", "interactive"]
gallery: true
downloads: [ "[Download Duplex](/duplex.zip)" ]
---

This patch is a polyphonic four-operator FM/additive synth. The synth is
intentionally simple, and can only run in either pure parallel (additive) or
pure series (FM). You can easily plug it into custom filters, but it has its own
resonant lowpass built in for ease of use. It is designed to take MIDI input,
but also has a built-in GUI keyboard to play with.

### Per-operator features:
- Individual ADSR envelope with dial controls and function display
- Harmonicity ratio selector (integer numerator and denominator)
- Waveform selection (sin, smooth saw, pure saw, square)
- Pulse width control for square waveform
- Optional velocity gain control (in FM, this can be used to control timbre)

![](/duplex.png)