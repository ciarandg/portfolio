---
layout: homepage.vto
title: Ciaran De Groot
templateEngine: [vto, md]
---
I'm Ciaran. I write code, and sometimes I write here.

---

<div class="post-columns">

<section>

## Recently

<ul id="recent-posts" class="post-listing">
  {{ for post of search.pages("url^=/posts/", "date=desc", 5) }}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      <i>{{ post.date |> formatDate }}</i>
    </li>
  {{ /for }}
</ul>

</section>

<section>

## Randomly

<ul id="random-posts" class="post-listing">
  {{ for post of search.pages("url^=/posts/", "date=desc") |> drop(5) |> shuffle |> take(5) }}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
      <i>{{ post.date |> formatDate }}</i>
    </li>
  {{ /for }}
</ul>

</section>

</div>

<br />
<br />

---

<div class="contact-details">

- [ciaran.deg@gmail.com](mailto:ciaran.deg@gmail.com)
- [github.com/ciarandg](https://github.com/ciarandg)

</div>
