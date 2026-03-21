import { drop, formatDate, shuffle } from "../utils/helpers.ts";

const POST_COUNT = 8;

fetch("/post-metadata.json").then((resp) => {
  resp.json().then((result) => {
    const withoutRecent = drop(result, POST_COUNT);
    const shuffled = shuffle(withoutRecent);

    const randomPosts = document.getElementById("random-posts");
    if (!randomPosts) {
      return;
    }
    randomPosts.innerHTML = "";

    const selected = shuffled.slice(0, POST_COUNT);

    selected.forEach((post) => {
      const li = document.createElement("li");
      const formattedDate = formatDate(new Date(post.date_published));
      const type = post.type;
      li.innerHTML = `
        <span class="post-title">
          <a href="${post.url}">${post.title}</a>
          <span class="post-type">${type}</span>
        </span>
        <span class="post-date">${formattedDate}</span>
      `;
      randomPosts.appendChild(li);
    });
  });
});
