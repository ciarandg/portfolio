---
title: "Contributing to Kubernetes: From Zero to Not-Zero"
date: 2026-01-20T00:00:00-06:00
draft: true
tags: ["kubernetes", "foss"]
downloads: []
blog: true
tableOfContents: true
---

Let's talk about FOSS contribution. I've always felt woefully inadequate as a FOSS contributor. I've put in a few drive-by commits to projects here and there, but I'm generally happier to hack away at my self-hosted infrastructure and personal projects than to patch up somebody else's code. After all, it's my free time, right? I've got a bunch of Nix derivations sitting around that should probably be upstreamed, but I'd rather just _get my shit done_ in the free time I have than get over the hurdle imposed by Nixpkgs' [bureaucratic contribution requirements](https://github.com/NixOS/nixpkgs/blob/master/CONTRIBUTING.md) and get a first PR in.

It's plain to see that I'm a bad citizen, so now I'm seeking law and order. I need to pay my dues. And what could bring more order and discipline than the most corporate, most gargantuan, most beloved and most reviled FOSS project? Enter Kubernetes.

## Prelude (Jan 20, 2026)

I'm not coming in blind here. I've used Kubernetes day-in-day-out for about 3 years at this point. I'm no stranger to cluster administration. I've used Kubernetes in anger and have plenty of reason to be grateful for its ubiquity.

I've been a member of the [Kubernetes Slack](https://kubernetes.io/community/) for a while, but have only used it to keep tabs on projects that I find important within the ecosystem. I've never tried to seriously pursue contribution, and have never worked on a project this large before.

The scale of the project appeals to me: maybe I can find my own nook and make a real difference, all-the-while giving back to a tool that I rely on every day. Maybe I can learn a thing or two about project management and architecture while I'm at it. If those goals are a bit lofty, hopefully I can scrape something together worth sticking on a resume.

## First Encounter (Jan 20, 2026)

This morning I attended the monthly [New Contributor Orientation](https://www.kubernetes.dev/docs/orientation/) meeting, and subsequently joined the Docs SIG's biweekly meeting.

### New Contributor Orientation

This is the first meeting of this sort that I've ever attended, and I came away very glad to have showed up. The orientation is held once a month on the third Tuesday of the month and encourages proper community engagement, attempting to steer potential contributors away from making one-off PRs that usually get rejected. This strikes me as a necessity for a project on the scale of Kubernetes, but also as something that could be tremendously beneficial for smaller-scale projects as well.

You can find the recording for the meeting I attended on [YouTube](https://www.youtube.com/watch?v=h3RzeLSmKpY), and the slides on [Google Drive](https://docs.google.com/presentation/d/1WB7fNdnWM3tL5c0qh2MRapQcVsqvlyaRfdldceE-AZY/edit?usp=sharing), though I would encourage anyone reading to attend an onboarding meeting synchronously as it is much more engaging that way.

#### Community Structure

I was familiar with some of the information presented here, but I found the structural clarity quite compelling. A little bit of terminology:

- A **Special Interest Group** (SIG) represents a long-running interest in the community. These include Docs, Architecture, Security, Scalability, Scheduling, and so on.
- A **Working Group** represents a short-term interest, and is owned by a SIG. Eventually, the Working Group will disolve and the owning SIG will be left responsible for the work done. This resembles a tiger team in other organizations.

All the work done within the Kubernetes community belongs to some SIG or WG. Contributors are free to associate with whatever SIGs/WGs they please. Further, SIGs and WGs are classified in terms of their scope:

- **Project-Wide:** Groups whose mandate spans all aspects of the project, e.g. Architecture, Docs, Release, Testing.
- **Horizontal:** Groups whose mandate is not all-encompassing but requires integration across the stack, e.g. Auth, CLI, Security.
- **Vertical:** Groups whose mandate is encapsulated by a particular feature in the stack, e.g. Network, Node, Scheduling, Storage.

{{< wrapimg src="flcl-terminal-core.jpg" caption="Pictured: Milton Friedman" alt="FLCL terminal core in dog form" align="right" max-height="400px" >}}

This structure is detailed in [governance.md](https://github.com/kubernetes/community/blob/master/governance.md#sigs). If you've ever worked for a medium-to-large software company, the need to break your organization into a 2D matrix will likely look familiar. What strikes me as remarkable, though, is how cleanly the Kubernetes organization is structured (see [slide](https://docs.google.com/presentation/d/1WB7fNdnWM3tL5c0qh2MRapQcVsqvlyaRfdldceE-AZY/edit?slide=id.g31809eea4f1_0_197#slide=id.g31809eea4f1_0_197) for a breakdown), and how few top-level groups manage to encompass the full scope of the community. Perhaps this clarity comes from producing a unified -- albeit multi-faceted -- product, unlike the sprawling complexity of enterprises who want to [grow at all costs](https://en.wikipedia.org/wiki/Friedman_doctrine).

As for individual heirarchy, there is a ladder that contributors progress through. It's pretty bog-standard though, and not of much interest in my opinion. You can find details in [community-membership.md](https://github.com/kubernetes/community/blob/master/community-membership.md).

### Key Takeaways

My single most important takeaway from the NCO is: **show up to SIG biweekly meetings rather than just trying to dive straight in**. This seems like a useful piece of advice for any substantial FOSS project: don't try to parachute in with a PR, because odds are you'll lack context. Instead do a little networking so that you know who you can lean on for the necessary context so that your first PR is actually wanted. Building those connections will also be invaluable if/when your PR gets lost in the deluge and nobody comes along to review it.

A few other tips and thoughts:

- When trying to decide what aspect of the project you want to contribute to, carefully consider why you want to contribute. When you reach out in a Slack channel, don't just ask "I'm new, is there anything I can do?" -- instead, provide some context on what you're trying get out of contributing
  - Are you trying to learn a particular skill? Are you trying to bolster your resume? Are you trying to meet like-minded people?
- Try to get a lay of the land. This may mean joining a SIG with a broad mandate at first. I know it's a cliché to say "just start with documentation" (it's also disrespectful to the skill required in good technical writing), but teams that cover the entire project _are_ a useful place to get your bearings, and can often be easiest to jump straight into.

## Docs SIG Meeting (January 20, 2026)

After the NCO had ended, I checked the [community calendar](https://www.kubernetes.dev/resources/calendar/) for which SIGs were holding their biweekly meetings soon. A few SIGs caught my eye, but the Docs SIG had a meeting later that same day. In an effort to keep my momentum going, I decided to sit in on the meeting.

As a new contributor you'll be expected (not forced) to introduce yourself at the beginning of a meeting, and encouraged to volunteer for note-taking duty. Taking notes is considered a contribution to Kubernetes, no different from contributing code! Crucially, it's a good accountability mechanism: if you're showing up and taking notes, you're more likely to stick around.

I didn't find anything in this Docs meeting that I was eager to contribute to immediately. There was an interesting initiative to consolidate Kustomize documentation, but there are already PRs in place for that, so I felt like it already had momentum and stakeholders.

## Contrib-Ex SIG Meeting (January 21, 2026)

## Contributing to LWKD

Branch is opened every week with a template to contribute to, contributors open PRs against that branch for each of the sections:

- Developer News
- Release Schedule
- Featured PRs
- KEP of the Week
- Other Merges
- Promotions
- Version Updates
- Subprojects and Dependency Updates
- Shoutouts
