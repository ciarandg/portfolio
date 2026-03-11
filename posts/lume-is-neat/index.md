---
title: "Lume Is Neat"
date: 2026-03-10T00:00:00-06:00
draft: false
archived: false
type: blog

tags: ["ssg", "javascript", "typescript"]
downloads: []
blog: true
---

## Preamble

{{ comp.wrapimg({ src: "marge-neat.jpg", alt: "Marge Simpson recommending a potato", align: "right" }) }}

Recently I was browsing a story about the [death of Eleventy](https://brennan.day/the-end-of-eleventy/) on Lobste.rs and a [comment](https://lobste.rs/s/nbsppn/au_revoir_eleventy#c_ejshje) from `u/kel` caught my eye:

> This is why I like Lume. It's basically just glue for your site's build scripts. If it died as a project it wouldn't be too hard to bash together rocks for an afternoon and replace enough of what it does for my own purposes.

I hadn't seen [Lume](https://lume.land) before, but this pitch appealed to me. Most of my SSG experience is with Hugo, and I have always found it burdensome to work with. Looking at their homepage, a Mastodon [testimonial](https://desu.social/@pixel/112155492135005017) stuck out:

> Once again big thanks to @cadey for showing me @lume. 
>
> Out of all static site builders I used in the past few years, this was the most smooth and pleasant experience of building a website. 

In the time I've been reading developer blogs, I've found that recommendations from [Xe](https://xeiaso.net/) have a damn good hit rate. So I gave it a shot, and ended up rebuilding my website (this site) from scratch.

## Why's It Neat?

Lume gets out of your way. It gives you just enough SSG to let you focus on building what you want to build, and it's wonderfully [modular](https://lume.land/plugins).

Because it's a JavaScript project, Lume gives you access to a huge ecosystem of web-dev tools, and it lets you configure them _directly_. Getting GHFM-style Markdown callouts working in Hugo was a headache for me. In Lume, it's [trivial](https://github.com/ciarandg/portfolio/commit/8006e84e82743e1a53d70525a9e0f0d13dd601d5) because you've got the full power of `markdown-it` at your disposal and you can just hook a [plugin](https://www.npmjs.com/package/markdown-it-obsidian-callouts) directly into the parser.

> [!WARNING]
> Holy shit a Markdown callout poggers

What's that you say? You want to write arbitrary TypeScript functions and expose them to your templates? That's [trivial](https://github.com/ciarandg/portfolio/blob/8006e84e82743e1a53d70525a9e0f0d13dd601d5/_config.ts#L56-L81) [too](https://github.com/ciarandg/portfolio/blob/8006e84e82743e1a53d70525a9e0f0d13dd601d5/index.md?plain=1#L34).

Static websites are not complicated!! Why do we make them so challenging, and why are we sapping the joy out of building them? Lume is a breath of fresh air coming from Hugo. It's so clean and intuitive. I highly recommend you give it a try.
