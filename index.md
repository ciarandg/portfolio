---
layout: homepage.vto
title: Ciaran De Groot
---
I'm Ciaran. I write code, and sometimes I write here.

---

<div class="post-columns">

<section>

## Recently

<ul id="recent-posts" class="post-listing">
  {{ for post of search.pages(postsQuery, "date=desc", 8) }}
    <li>
      <span class="post-title">
        <a href="{{ post.url }}">{{ post.title }}</a>
        <span class="post-type">{{ post.type }}</span>
      </span>
      <span class="post-date">{{ post.date |> formatDate }}</span>
    </li>
  {{ /for }}
</ul>

</section>

<section>

## Randomly

<ul id="random-posts" class="post-listing">
  {{ for post of search.pages(postsQuery, "date=desc") |> drop(8) |> shuffle |> take(8) }}
    <li>
      <span class="post-title">
        <a href="{{ post.url }}">{{ post.title }}</a>
        <span class="post-type">{{ post.type }}</span>
      </span>
      <span class="post-date">{{ post.date |> formatDate }}</span>
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
