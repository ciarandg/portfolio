import lume from "lume/mod.ts";
import codeHighlight from "lume/plugins/code_highlight.ts";
import feed from "lume/plugins/feed.ts";
import esbuild from "lume/plugins/esbuild.ts";
import googleFonts from "lume/plugins/google_fonts.ts";
import callouts from "npm:markdown-it-obsidian-callouts@0.3.3";
import {
  drop,
  formatDate,
  POSTS_QUERY,
  shuffle,
  take,
} from "./utils/helpers.ts";

const markdown = {
  plugins: [callouts],
};

const site = lume({}, { markdown });
const assetHost = "ciarandg-portfolio.us-southeast-1.linodeobjects.com";

site.use(esbuild());

site.add("/css");
site.add("/js");

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

site.data("postsQuery", POSTS_QUERY);

site.use(feed({
  output: ["/posts.rss", "/posts.json"],
  query: POSTS_QUERY,
  limit: 999,
  info: {
    title: "=site.title",
    description: "=site.description",
  },
  items: {
    title: "=title",
    description: "=excerpt",
  },
}));

site.filter("shuffle", shuffle);
site.filter("take", take);
site.filter("drop", drop);
site.filter("formatDate", formatDate);
site.filter("assetUrl", (endpoint: string) => {
  const base = new URL(`https://${assetHost}`);
  base.pathname = endpoint;
  return base.href;
});

export default site;
