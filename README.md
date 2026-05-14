# bysimms.co — Working File

This site has always been a playground of sorts. I use it to test ideas, work through decisions out loud, and tear the whole thing down when I want to try something new. I'm not a web designer or a programmer by trade — if you spot anything broken, off, or just plain wrong, tell me. I'd rather know.

## What's here

A small multi-project personal site. The home page is part status surface, part directory:

- **Vehicle project** — a buying decision worked through in public
- **Brand book** — the design system documented in itself (principles, palette, type, components)
- **Now** — what I'm working on this week, updated when I sit down with the file
- **Decision logs** — `SITE_DECISIONS.md` for the site itself, `DECISIONS.md` for the vehicle project. Every choice has an ID; supersessions keep the history.
- **Colophon** — fonts, stack, credits, build approach
- **Accessibility** — target conformance, what's in place, what's still open

The markdown files in this repo are the source of truth. The rendered HTML is the styled view. If the two disagree, the markdown wins.

## Stack

- [Hugo](https://gohugo.io/) — static site generator, building from the markdown sources
- [Cloudflare Pages](https://pages.cloudflare.com/) — hosting, deploying from `main` on push
- Plain CSS — shared theme in `theme.css`, print overrides in `print.css`, page-unique styles stay inline
- CSS custom properties on `:root` and `[data-theme="dark"]` for the light/dark toggle
- Type: Instrument Serif, Geist, JetBrains Mono, and Mrs Saint Delafield for the signature script

No framework, no client routing, no build step beyond Hugo.

## Found a problem?

Open an issue or drop me a line. Accessibility issues especially — the site targets WCAG 2.1 AA and the [accessibility page](https://bysimms.co/accessibility/) tracks where I'm meeting it and where I'm not.

---

Built in Richmond, VA. Live at [bysimms.co](https://bysimms.co).
