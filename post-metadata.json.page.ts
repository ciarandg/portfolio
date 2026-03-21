import { POSTS_QUERY } from "./utils/helpers.ts";

export const url = "/post-metadata.json";

export default function ({ search }) {
  const posts = search.pages(POSTS_QUERY, "date=desc");

  return JSON.stringify(
    posts.map((post) => ({
      title: post.title,
      url: post.url,
      date_published: post.date,
      type: post.type,
    })),
  );
}
