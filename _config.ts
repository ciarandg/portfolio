import lume from "lume/mod.ts";
import codeHighlight from "lume/plugins/code_highlight.ts";
import feed from "lume/plugins/feed.ts";
import googleFonts from "lume/plugins/google_fonts.ts";

const site = lume();
const postsQuery = "url^=/posts/ !draft=true !archived=true";
const assetHost = "ciarandg-portfolio.us-southeast-1.linodeobjects.com";

site.add("/css/base.css");
site.add("/css/homepage.css");
site.add("/css/post.css");

site.preprocess([".md"], (pages) => {
  pages.forEach((page) => page.data.templateEngine = ["vto", "md"]);
});

site.use(codeHighlight({
  theme: {
    name: "github-dark",
    cssFile: "/css/highlight.css",
  },
}));

site.use(googleFonts({
  cssFile: "css/fonts.css",
  fonts: {
    ibm:
      "https://fonts.googleapis.com/css2?family=IBM+Plex+Serif:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;1,100;1,200;1,300;1,400;1,500;1,600;1,700&display=swap",
    jetbrains:
      "https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,100..800;1,100..800&display=swap",
  },
}));

site.data("postsQuery", postsQuery);

site.use(feed({
  output: ["/posts.rss", "/posts.json"],
  query: postsQuery,
  info: {
    title: "=site.title",
    description: "=site.description",
  },
  items: {
    title: "=title",
    description: "=excerpt",
  },
}));

site.filter("shuffle", (array: unknown[]) => {
  let currentIndex = array.length;

  // While there remain elements to shuffle...
  while (currentIndex != 0) {
    // Pick a remaining element...
    const randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex],
      array[currentIndex],
    ];
  }

  return array;
});

site.filter("take", (array: unknown[], count: number) => {
  return array.slice(0, count);
});

site.filter("drop", (array: unknown[], count: number) => {
  return array.slice(count);
});

site.filter("formatDate", (date: Date) => {
  return date.toLocaleDateString("en-US", {
    year: "numeric",
    month: "short",
    day: "numeric",
  });
});

site.filter("assetUrl", (endpoint: string) => {
  const base = new URL(`https://${assetHost}`);
  base.pathname = endpoint;
  return base.href;
});

export default site;
