---
title: "Naima"
date: 2022-08-09
draft: false
tags: ["discord", "kotlin", "java", "mongodb"]
gallery: true
downloads: [
    '[Source Code](https://github.com/ciarandg/naima)'
]
---

![Naima voting interface]({{< assetUrl src="naima_voting.png" >}})

Naima is a Discord bot that I use to manage a jazz listening club with
friends. It is implemented in Kotlin using the
[JDA](https://github.com/DV8FromTheWorld/JDA) Discord API, and depends
on a MongoDB instance for managing state. Naima allows users to suggest
and then subsequently vote on a weekly album to listen to and discuss.
Additionally, it pulls album covers and metadata from the [MusicBrainz
API](https://musicbrainz.org/doc/MusicBrainz_API) and uses imagemagick
for album cover processing.

I've configured the project to build as a Docker image via
[jib](https://github.com/GoogleContainerTools/jib), and in my own
personal deployment I run it in a k3s cluster managed with FluxCD.
