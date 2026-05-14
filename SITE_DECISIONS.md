---
title: Site Build — Decisions Log
project: bysimms.co (Working File · multi-project personal site)
scope: build, hosting, theme, structure, brand
host: Cloudflare Pages
domain: bysimms.co
started: 2026-05-13
last_updated: 2026-05-17
status_counts:
  decided: 31
  in_progress: 1
  open: 3
  not_applicable: 0
---

# Site Build — Decisions Log

The meta log: how this static site is built, themed, hosted, and branded. **Not** about which car to buy — that's [`DECISIONS.md`](DECISIONS.md). Two decision logs, same convention, different scopes.

Decision IDs use a `B-NNN` prefix for *build*, distinct from the vehicle project's `D-NNN`. Chronological, never renumbered. Status can change; the ID is permanent. When a later decision replaces an earlier one, the earlier one keeps its ID and gets a **Superseded by** line — the history is the record.

**Status snapshot:** 31 decided · 1 in progress · 3 open · 0 not applicable

---

## Index

### ✅ Decided (31)

| ID    | Topic                                                                          |
|-------|--------------------------------------------------------------------------------|
| B-001 | Site model — multi-page with home as index                                     |
| B-002 | Hub stays as the comprehensive all-in-one doc                                  |
| B-003 | Source of truth — markdown files alongside rendered HTML                       |
| B-004 | Build approach — plain HTML, no static site generator · **superseded by B-020** |
| B-005 | Hosting — GitHub Pages from `main` · **superseded by B-021**                   |
| B-006 | Theme system — CSS variables driven by `data-theme`                            |
| B-007 | Dark mode — editorial warmth preserved, not generic dark                       |
| B-008 | Theme toggle — localStorage + `prefers-color-scheme`                           |
| B-009 | CSS deployment — inlined per HTML file · **superseded by B-022**               |
| B-010 | Filename convention — kebab-case with `.html` visible · **superseded by B-030** |
| B-011 | Page index — draft pages shown, not hidden                                     |
| B-012 | Typography — Instrument Serif / Geist / JetBrains Mono                         |
| B-013 | Color accent — burgundy (light) / terracotta (dark)                            |
| B-015 | `theme-preview.html` re-purposed as template + brand book                      |
| B-016 | Brand book format — HTML, not PDF or Figma                                     |
| B-017 | Palette docs include HEX + CMYK + per-color usage notes                        |
| B-018 | `BRAND.md` as canonical source for the brand book                              |
| B-019 | Four brand principles articulated (Warmth · Restraint · Editorial · Dual mood) |
| B-020 | Build approach switched to **Hugo**                                            |
| B-021 | Hosting switched to **Cloudflare Pages** on **bysimms.co**                     |
| B-022 | CSS extracted to `/css/theme.css` + `/css/print.css`                           |
| B-023 | Wordmark + favicon — script "S" path-traced after Mrs Saint Delafield          |
| B-024 | `theme-preview.html` renamed to `brand-book.html`                              |
| B-025 | Added `404.html`, `colophon.html`, `now.html` to the page set                  |
| B-026 | Added `robots.txt`, `sitemap.xml`, `humans.txt` for publish-readiness          |
| B-027 | Print stylesheet — `css/print.css`, light-mode forced, URLs revealed           |
| B-028 | Accessibility pass — target WCAG 2.1 AA · own log at `accessibility.html`      |
| B-029 | Chrome extracted to Hugo `baseof.html` + four partials                         |
| B-030 | URL convention — clean, no `.html` extension (uglyURLs = false)                |
| B-031 | Hugo build configuration — sitemap, robots, markup, params                     |

### 🔄 In progress (1)

| ID    | Topic                                                       | Trigger to close                       |
|-------|-------------------------------------------------------------|----------------------------------------|
| B-014 | Per-doc sub-pages (shortlist, buying-plan, decisions, quickref) | Build each `.html` from its source `.md` |

### 📋 Open (3)

Listed under **Open Questions** below as `OQ-B3`, `OQ-B4`, and `OQ-B6`. Each has a stated trigger. (`OQ-B1`, `OQ-B7`, and `OQ-B8` closed by B-022, B-023, and B-024 respectively. `OQ-B2` closed by B-030. `OQ-B5` resolved: public repo on GitHub, Hugo build on Cloudflare Pages.)

---

## Decisions

### B-001 — Site model: multi-page with home as index
**Status:** ✅ Decided

The site is a small multi-page static site, not a single scrolling document. The home page (`index.html`) serves two jobs at once: **status surface** (top pick, key stats, open questions, next actions) and **directory** (cards linking to every other page).

**Considered and rejected:**
- *Light landing, hub stays as deep doc* — overlap with the hub's existing overview made the home feel redundant.
- *Home replaces hub, split into per-section pages* — too much teardown of work already done in the hub.
- *Just restyle the hub* — didn't satisfy the desire to have a real front door.

**Tradeoff:** more files to maintain; some duplication between the home's status surface and the hub's overview section.

---

### B-002 — Hub stays as the comprehensive all-in-one doc
**Status:** ✅ Decided

`hub.html` (renamed from `vehicle_project_hub.html`) remains intact as the deep single-page document with all seven sections. Sub-pages (`shortlist.html`, `decisions.html`, etc.) are focused, single-purpose versions of individual hub sections — not replacements for the hub.

**Tradeoff:** content duplication between the hub and the focused sub-pages. Acceptable because the hub serves different readers (someone catching up cover-to-cover) than the sub-pages (someone looking up one thing).

---

### B-003 — Source of truth: markdown files alongside rendered HTML
**Status:** ✅ Decided · Updated by B-018, B-020

Each rendered HTML page has a corresponding `.md` source file in the repo:

| Source                       | Renders to              |
|------------------------------|-------------------------|
| `INDEX.md`                   | `index.html`            |
| (hub markdown TBD)           | `hub.html`              |
| `BRAND.md`                   | `brand-book.html`       |
| `BUYING_PLAN.md`             | `buying-plan.html`      |
| `SHORTLIST_COMPARISON.md`    | `shortlist.html`        |
| `DECISIONS.md`               | `decisions.html`        |
| `QUICKREF.md`                | `quickref.html`         |
| `COLOPHON.md` *(TBD)*        | `colophon.html`         |
| `NOW.md` *(TBD)*             | `now.html`              |
| `SITE_DECISIONS.md` *(this)* | not rendered            |

The markdown is canonical. HTML is the styled view. If the two disagree, the markdown wins. Under Hugo (B-020), the rendering becomes templated rather than hand-translated; markdown stays the source.

---

### B-004 — Build approach: plain HTML, no static site generator
**Status:** ✅ Decided · **Superseded by B-020**

Originally chose hand-written HTML over Jekyll / Hugo / Eleventy / Astro to keep the tooling surface zero. Reasoning held for the first two pages but broke down once four pages were inlined with the same theme block (see B-022 and the original `OQ-B1`).

**Why we're flipping:** Hugo (B-020) lets the markdown sources stay canonical *and* renders them automatically, removing the manual translation step that `OQ-B4` was tracking. The bespoke editorial feel survives — Hugo doesn't impose a look — but the duplication goes away.

---

### B-005 — Hosting: GitHub Pages, deploy from `main`
**Status:** ✅ Decided · **Superseded by B-021**

Originally chose GitHub Pages from `main` for zero-extra-account simplicity. Holding the source on GitHub anyway, no separate dashboard to learn.

**Why we're flipping:** B-021 moves hosting to Cloudflare Pages on `bysimms.co`. GitHub remains the source of truth; Cloudflare just builds and serves.

---

### B-006 — Theme system: CSS variables driven by `data-theme`
**Status:** ✅ Decided

Every color routes through a CSS custom property. Light values live on `:root` (and explicit `[data-theme="light"]`); dark values live on `[data-theme="dark"]`. Toggling is a single attribute swap on `<html>`.

**Considered and rejected:**
- *SCSS variables* — would require a build step for the styling layer alone. Hugo (B-020) provides the build, but the variables-first approach still beats SCSS because they're live-toggleable at runtime.
- *Tailwind* — aesthetic mismatch; trades the bespoke editorial feel for utility-class soup.
- *Plain hex throughout* — the hub's original problem; the point of this exercise was to fix it.

**Tradeoff:** every new component needs to use vars, not raw hex. Easy to forget; the brand book is the antidote.

---

### B-007 — Dark mode: editorial warmth preserved, not generic dark
**Status:** ✅ Decided

Dark mode is intentional, not inverted. Specifically:

- **Background** is deep warm ink (`#16130e`), not pure black — like a leather-bound book by a reading lamp.
- **Text** is warm cream (`#f0e9db`), not pure white.
- **Accent** lifts the burgundy `#8b3a2f` to terracotta `#d4897a` so it stays readable against dark, but keeps the same character.
- **Functional colors** (green, amber) lift the same way.
- Card and soft surfaces sit between bg and the contrast extremes.

**Considered:** generic dark mode (pure black bg, pure white text, untouched accent). Rejected — kills the editorial paper feel that defines light mode.

---

### B-008 — Theme toggle: localStorage + `prefers-color-scheme` fallback
**Status:** ✅ Decided

On first load: if `localStorage.theme` is set, use it; otherwise use `window.matchMedia('(prefers-color-scheme: dark)')`. On toggle: write to localStorage. Listen for system preference changes, but only follow them if the user hasn't explicitly chosen.

Inline script runs before paint to avoid a flash of wrong theme. The actual toggle handler now lives in `/js/theme.js` (one file, loaded once per page) instead of being copy-pasted into every page's footer — see B-022.

---

### B-009 — CSS deployment: inlined per HTML file
**Status:** ✅ Decided · **Superseded by B-022**

Originally inlined the full theme block per page. Worked when there were two pages. At four+ pages it became the maintenance burden the original `OQ-B1` warned about. B-022 closes the question by extracting `theme.css`.

---

### B-010 — Filename convention: kebab-case, `.html` visible
**Status:** ✅ Decided · **Superseded by B-030**

`index.html`, `hub.html`, `buying-plan.html`, `decisions.html`, `quickref.html`, `shortlist.html`, `brand-book.html`, `colophon.html`, `now.html`. URLs include `.html` (e.g. `/buying-plan.html`). Hugo (B-020) can produce either `.html` URLs or extensionless ones; we'll keep `.html` for now until `OQ-B2` is resolved.

OQ-B2 resolved via B-030. The visible-`.html` argument was rooted in the hand-written-HTML model (B-004) where the file you'd open locally and the URL you'd serve were the same string. Under Hugo (B-020), they're separate constructs, so the argument no longer applies.

---

### B-011 — Page index: draft pages shown, not hidden
**Status:** ✅ Decided

The home page's directory shows all planned pages, with "Live" and "Draft" status badges. Draft pages get reduced opacity and link to a 404 (a real 404 page now — see B-025).

**Tradeoff:** clicking a draft 404s. Acknowledged in the badge, softened by a real 404 with onward links.

---

### B-012 — Typography: Instrument Serif / Geist / JetBrains Mono
**Status:** ✅ Decided · Extended by B-023

Three families, distinct registers:

- **Instrument Serif** — display headlines, italic emphasis on key words
- **Geist** — body and UI sans
- **JetBrains Mono** — eyebrows, labels, IDs, numerical detail

B-023 adds a fourth — **Mrs Saint Delafield** — but as a signature script, used only in the colophon and the favicon mark. The display/body/UI/mono workhorse stack stays exactly three families.

---

### B-013 — Color accent: burgundy / terracotta
**Status:** ✅ Decided

Primary accent is burgundy `#8b3a2f` in light, lifting to terracotta `#d4897a` in dark. Functional palette: forest green for *decided*, amber for *in progress / open*, the burgundy itself for *rejected / N/A*. Tan as a secondary warm hue.

Full palette with HEX + CMYK + usage now lives in `BRAND.md` (B-017, B-018) and renders to the [brand book](brand-book.html).

---

### B-014 — Per-doc sub-pages: build from source markdowns
**Status:** 🔄 In progress

Each of `SHORTLIST_COMPARISON.md`, `BUYING_PLAN.md`, `DECISIONS.md`, and `QUICKREF.md` gets its own focused HTML page using the same theme system. Under Hugo (B-020), each becomes a content page with a shared layout — less per-page CSS to maintain.

**Order to build:** **Decisions** first (highest leverage, already structured), then Shortlist or Buying Plan depending on whether test drives or financing land next.

**Trigger to close:** all four sub-pages exist; the home page's directory shows them as "Live"; draft badges are gone.

---

### B-015 — `theme-preview.html` re-purposed as template + brand book
**Status:** ✅ Decided · Superseded by B-024 (rename)

The original `theme-preview.html` mixed theme-system demo with vehicle-project-specific content. It got rewritten twice:

1. **Sanitized template.** Same components, generic content.
2. **Elevated to brand book.** Principles section, expanded palette (HEX + CMYK + usage), full type scale, italic-emphasis Do/Don't, hero treatment with version stamp.

B-024 renamed the file to `brand-book.html` to match its content.

---

### B-016 — Brand book format: HTML in the system, not PDF or Figma
**Status:** ✅ Decided

The brand book is an HTML page rendered using its own theme system. The system documents itself in itself.

**Considered and rejected:**
- *PDF brand guidelines* — better for handoff and print, but drifts the moment anything changes.
- *Figma file with shared styles* — industry standard for design teams, but requires accounts, and moves the source-of-truth out of the repo.

The self-referential HTML stays in lock-step with production code because *it is* production code.

---

### B-017 — Palette docs include HEX + CMYK + usage notes
**Status:** ✅ Decided

Each color swatch shows HEX and CMYK values for both modes plus a one-line usage note. The system is web-first; CMYK is documented for any future print application (business cards, "for sale" cards, stickers, signage).

**Note on accuracy:** CMYK values are mathematical sRGB → CMYK conversions. Correct as working specs; a print shop will ICC-profile match against destination paper. The mathematical values are a starting point, not a target.

**Maintenance:** if a token color changes, the CMYK needs hand-recomputing — `OQ-B4` (Hugo shortcode for the palette table) is the eventual fix.

---

### B-018 — `BRAND.md` as canonical source for the brand book
**Status:** ✅ Decided

`BRAND.md` is the markdown source for `brand-book.html` (B-024). The markdown is canonical; the HTML is the styled view. Same pattern as every other source-of-truth pair (B-003).

---

### B-019 — Four brand principles articulated
**Status:** ✅ Decided

The brand book opens with four principles: **Warmth · Restraint · Editorial · Dual mood**. The four ideas the system is willing to be inflexible about; everything else can flex.

Articulating principles before tokens sets the "why" before the "what". Future design decisions stay more consistent when there's something to point back to.

---

### B-020 — Build approach: Hugo
**Status:** ✅ Decided · **Supersedes B-004**

Switching to [Hugo](https://gohugo.io/) as the static site generator.

**Why now:**
- Four+ pages with the same theme block — manual sync was already painful.
- `BRAND.md` and `SITE_DECISIONS.md` are well-structured markdown that Hugo can render natively.
- The original "no SSG" decision (B-004) was about keeping the tooling surface small, not about avoiding tools that fit. Hugo is a single binary; the surface stays small.
- Cloudflare Pages (B-021) builds Hugo natively — no separate CI to configure.

**Considered and rejected (again):**
- *Jekyll* — Ruby toolchain; slower; less natural fit with Cloudflare Pages.
- *Eleventy* — viable, but Hugo's content-page model maps more cleanly to the source-renders-to table in B-003.
- *Astro* — too JS-flavored for a site that has approximately zero client-side interactivity.

**Tradeoff:** layout/shortcode learning curve; once-static HTML now goes through templating. Worth it for content updates and zero rebuilds-by-hand.

---

### B-021 — Hosting: Cloudflare Pages on `bysimms.co`
**Status:** ✅ Decided · **Supersedes B-005**

Hosting moves to [Cloudflare Pages](https://pages.cloudflare.com/) at `bysimms.co`.

**Why:**
- Native Hugo build (B-020) — no GitHub Actions to write.
- Per-PR preview deployments (which GH Pages doesn't do).
- Faster cache invalidation than GitHub Pages.
- Custom domain (`bysimms.co`) lands cleanly; closes `OQ-B3`.

**Repo visibility** (`OQ-B5`) was decoupled from the hosting choice by this decision — Cloudflare Pages serves from a private repo without the Pro-tier requirement that GitHub Pages had — and has since resolved to **public** (see OQ-B5 closure note).

**Tradeoff:** new dashboard to learn. Acceptable; the surface is small.

---

### B-022 — CSS extracted to `/css/theme.css` + `/css/print.css`
**Status:** ✅ Decided · **Supersedes B-009 · Closes OQ-B1**

The shared theme — tokens, base, every component documented in the brand book — now lives in `/css/theme.css`. Print overrides live in `/css/print.css` and load with `media="print"`. Each HTML page links both:

```html
<link rel="stylesheet" href="css/theme.css">
<link rel="stylesheet" href="css/print.css" media="print">
```

Only page-unique styles stay inline. The theme-toggle handler also got extracted, to `/js/theme.js`, for the same reason.

**Under Hugo (B-020):** these files live in `static/css/` and `static/js/`, served at `/css/` and `/js/` URLs.

**Tradeoff:** pages aren't fully self-contained anymore. Worth it; single-file portability mattered when the site was two pages, not five+.

---

### B-023 — Wordmark + favicon: script "S" after Mrs Saint Delafield
**Status:** ✅ Decided · **Closes OQ-B7**

The site mark is a **script "S"** — for **Simms**, matching the domain `bysimms.co`.

- **Letterform:** path-traced after [Mrs Saint Delafield](https://fonts.google.com/specimen/Mrs+Saint+Delafield) (italic copperplate script). Hand-drawn as SVG paths rather than `<text>` so it renders identically across browsers and OSes — an SVG `<text>` reference would fall back to whatever script face the OS happens to have, which varies wildly.
- **Two files, auto-swapped:** `favicon.svg` (burgundy `#8b3a2f` on cream `#faf7f2`) for light user-agents; `favicon-dark.svg` (terracotta `#d4897a` on deep ink `#16130e`) for dark. The HTML uses paired `<link rel="icon" media="(prefers-color-scheme: ...)">` so browsers pick the right one without JS.
- **Apple touch icon:** `apple-touch-icon.svg`, fixed burgundy field with cream "S", 180×180. iOS doesn't honor `prefers-color-scheme` on home-screen icons, so the touch icon is single-mode.
- **In the nav:** text wordmarks ("Working File" on the brand book, "Vehicle Project" on the home) stay. The "S" is the favicon and the colophon signature, not the nav-brand. (Per the answer to "Does the wordmark change too?")
- **In the colophon:** the actual Mrs Saint Delafield font is loaded and used for the "Simms" signature line, giving the script face a real on-page appearance.

**Considered and rejected:**
- *Apple-touch-icon with the dark variant too* — iOS home-screen doesn't honor `prefers-color-scheme` on icons; a dark variant would never display. Single fixed touch icon.
- *Embed Mrs Saint Delafield directly in the favicon as `<text>`* — unreliable cross-browser; tried it, fell back to a path.

---

### B-024 — `theme-preview.html` renamed to `brand-book.html`
**Status:** ✅ Decided · **Closes OQ-B8**

The file is structurally a brand book now, not a preview. `brand-book.html` matches the content and the source-of-truth pattern (`BRAND.md` → `brand-book.html` reads naturally; `BRAND.md` → `theme-preview.html` doesn't).

**Done as part of this update:**
- Renamed the file.
- Added a "Brand Book" card to the home page's directory (it wasn't linked there before).
- Old file removed from the repo. Cloudflare Pages will 301 it via `_redirects` once a request shows up in logs.

---

### B-025 — Added `404.html`, `colophon.html`, `now.html`
**Status:** ✅ Decided

Three new pages join the site shell ahead of the sub-pages from B-014.

- **`404.html`** — editorial / dry tone, framed as an open question (`OQ-404`, trigger: "a working URL"). Links back to home, hub, brand book, colophon. Cloudflare Pages picks this up automatically.
- **`colophon.html`** — one-page about with stack, type, hosting, source-of-truth, signature script. Every entry points back to a B-NNN decision so "why" is one click from "what".
- **`now.html`** — "what I'm working on this week." Short, dated, deliberately narrow. Following the [/now page convention](https://nownownow.com/). Updated weekly.

**Tradeoff:** more files to keep in sync (especially `now.html`, by design). Acceptable; `now.html` is supposed to be sparse and frequently rewritten.

---

### B-026 — Added `robots.txt`, `sitemap.xml`, `humans.txt`
**Status:** ✅ Decided

Small but useful before publish:

- **`robots.txt`** — allow-all, points at the sitemap.
- **`sitemap.xml`** — Live pages only (home, hub, brand-book, now, colophon). Drafts excluded until they ship.
- **`humans.txt`** — author + stack + thanks. Optional but on-brand for a working-file site.

Under Hugo (B-020), these can stay in `static/` and be served as-is, or `sitemap.xml` can be Hugo-generated. Probably the latter once the sub-pages exist and the list grows.

---

### B-027 — Print stylesheet: `/css/print.css`
**Status:** ✅ Decided

A separate `print.css` loaded with `media="print"`. What it does:

- Forces light mode (ink on white) regardless of theme.
- Hides nav, theme toggle, draft badges, CTA links.
- Scales display type down for paper (clamp values are screen-sized).
- Reveals URLs after every link: `[click here] → click here (https://example.com)`.
- Adds a page-bottom colophon stripe: `bysimms.co · <page name>`.
- `break-inside: avoid` on cards and sections so things don't get sliced.

**Tradeoff:** more CSS to maintain. Worth it for a paper-document site that genuinely wants to be printable (the principle of "reads as paper" earns it).

---

### B-028 — Accessibility pass: target WCAG 2.1 AA
**Status:** ✅ Decided · Detail in [`accessibility.html`](accessibility.html)

The site targets **WCAG 2.1 Level AA**. It isn't in legal scope today — a personal working file isn't an ADA "place of public accommodation" and isn't on the EAA's product/service list — but AA is the right design bar, and the line between "personal" and "commercial" can move quietly.

**Closed in this pass (8 items, with WCAG criteria):**

- **A-001** — Semantic HTML throughout (1.3.1). 404 mark made decorative; the page's real heading is now `<h1 class="nf-q">`.
- **A-002** — `lang="en"` on every page (3.1.1).
- **A-003** — Theme toggle announces state via `aria-pressed` (4.1.2). Decorative SVGs inside the button carry `aria-hidden="true"`. Default theme follows `prefers-color-scheme`; falls back to **dark** when no preference is detected (was: light — warm dark is the brand's resting state).
- **A-004** — Color is never the only cue (1.4.1). Italic emphasis carries semantic `<em>`; status badges always include a text label.
- **A-005** — `prefers-reduced-motion` honoured (2.3.3) in `theme.css`.
- **A-006** — Theme toggle hits ≥ 44 × 44 on mobile (2.5.5 AAA).
- **A-007** — Body/headline contrast passes AA in both modes (1.4.3).
- **A-008** — Keyboard navigable; only native `<a>` and `<button>` (2.1.1).

**Open (with stated triggers):**

- **OQ-A1** — Light-mode `--amber` (`#a87617`) used as text fails AA (≈ 3.7:1 on cream). Trigger: deepen to ~`#8a5e0d` *or* recolor `.open-q-id` text to `--ink-2`, leaving the amber left border as the visual cue. (1.4.3)
- **OQ-A2** — Skip-to-content link not yet wired. CSS is in `theme.css` (`.skip-link`); needs `<a class="skip-link" href="#main">…</a>` on each page and `id="main"` on the primary content region. (2.4.1)
- **OQ-A3** — `:focus-visible` styles defined; needs a keyboard-walk verification on every page in both modes. (2.4.7)
- **OQ-A4** — Most pages wrap content in `<div class="wrap">` rather than `<main>`. Pair with OQ-A2.
- **OQ-A5** — No third-party automated audit yet (axe / Lighthouse / Pa11y). Run at first publish; file findings as new OQ-AN entries.

Accessibility items use an `A-NNN` / `OQ-AN` namespace, distinct from `B-NNN` / `OQ-BN` here and `D-NNN` / `OQ-N` in the vehicle log. Full list lives on [`accessibility.html`](accessibility.html); that page is the canonical statement for outside readers.

---

### B-029 — Chrome extracted to Hugo `baseof.html` + four partials
**Status:** ✅ Decided

The shared HTML chrome — `<head>`, theme-preload script, top nav, and an optional site footer — now lives in Hugo templates instead of being duplicated across every page:

- `layouts/_default/baseof.html` — the shell, with `extra_head` and `main` blocks for per-page injection.
- `layouts/partials/head.html` — meta, favicons, fonts, theme + print CSS links.
- `layouts/partials/theme-preload.html` — the pre-paint theme attribute script.
- `layouts/partials/nav.html` — top nav with the site wordmark and theme toggle. Renders an optional in-nav anchor list when the page declares `nav_links` in front matter (used by the brand book for jump-to-section affordance on a long page; quiet on every other page).
- `layouts/partials/theme-toggle.html` — the toggle button markup, extracted out of `nav.html` so both branches of the section-anchor conditional reuse a single source. Same chrome-extraction reasoning, one level deeper.
- `layouts/partials/footer.html` — universal minimal footer, opt-in per page. Pages with bespoke footers (the home's project-specific line, the brand book's content-specific line) keep theirs inlined.

`head.html` carries a three-case title rule: home renders just the site title, the 404 page renders `404 — Site Title` (Hugo's 404 has no `.Title`; `.Kind` is the reliable signal), everything else renders `Page Title — Site Title`. Hugo's special `layouts/404.html` location (top-level, not under `_default`) is the one place this convention breaks from the rest of the layout tree, by Hugo's own rule.

Two normalizations happened as side-effects of the lift:

- **Site brand is "Working File" sitewide.** The home page used to render the nav-brand as "Vehicle Project"; that framing now lives only in the home's hero `h1`, where it belongs. The two-word split renders via `[params.brand] word1 / word2` in `hugo.toml`.
- **Theme toggle `aria-label`** updated from "Dark theme" (names a state) to "Toggle light and dark theme" (names the action). Picked up because the partial surfaced what every page was duplicating; A-003's body text in `accessibility.html` was patched to match (loosely related to OQ-A3).

**Closes:** the cross-page duplication that B-022 only partially addressed at the CSS level. B-022 extracted shared *styles*; B-029 extracts shared *markup*.

**Tradeoff:** per-page layouts now need to define `{{ define "main" }}` and (when needed) `{{ define "extra_head" }}` blocks instead of being free-form HTML. Worth it — chrome edits become one-file edits, and the next time a meta tag or favicon path changes, six pages don't have to be touched in lockstep. A second tradeoff worth naming: front matter now carries some structural data (`nav_links` on the brand book) that wasn't strictly content. Acceptable as long as it stays narrow; if other pages start needing structural front matter, that's a signal to revisit.

---

### B-030 — URL convention: clean URLs, no `.html` extension
**Status:** ✅ Decided

URLs drop the `.html` suffix sitewide. `/colophon.html` becomes `/colophon/`, `/brand-book.html` becomes `/brand-book/`, and so on. The home stays at `/`. Implemented in `hugo.toml` as `uglyURLs = false` (Hugo's default), which emits `public/colophon/index.html` and lets Cloudflare Pages serve that on a request to `/colophon/`.

**Reverses:** B-010, which kept `.html` visible. That decision was right when the site was hand-written HTML pages saved as files — visible `.html` matched the file you'd open locally. Under Hugo, "the file" is now `content/colophon.md` plus a layout; the served URL is a separate construct entirely. The original argument for visibility doesn't apply to the new build.

**Closes:** OQ-B2. The trigger was *"if/when an outside audience starts seeing the site"* — `bysimms.co` going live on Cloudflare Pages is exactly that moment, so closing it before the first public link rather than after avoids the redirect tail.

**Internal-link cleanup:** every layout that linked to `*.html` (the home page directory's nine page cards, the colophon's "accessibility page" and "brand book" mentions, the now page's queued items, the 404's nav-back links, the accessibility page's brand-book pointer, the brand book's own footer) needs its hrefs updated. Net: ~25 edits across six layout files. Done as part of this decision so the log lands consistent with the code.

**Tradeoff:** any existing external link to `bysimms.co/something.html` would 404. There are none at time of writing (the site has never been linked from outside), so the redirect-rule cost is zero. If that ever changes, Cloudflare Pages `_redirects` handles `.html` → trailing-slash with one line per page.

---

### B-031 — Hugo build configuration
**Status:** ✅ Decided

Initial `hugo.toml` settings, each tied to a prior decision:

- **`baseURL = "https://bysimms.co/"`** — B-021.
- **`title = "Working File"`** — B-029.
- **`languageCode = "en-us"`** — required by Hugo; matches A-002 (`<html lang="en">`).
- **`uglyURLs = false`** — B-030 (clean URLs).
- **`enableRobotsTXT = false`** — `robots.txt` stays hand-written in `static/` (B-026). The file is short and single-purpose; Hugo's generation feature doesn't earn its keep here.
- **Sitemap** — Hugo-generated, replacing the hand-written `static/sitemap.xml`. Hugo derives `<loc>` from the content tree and `<lastmod>` from each page's git mtime, both of which stay accurate without manual upkeep. The hand-written file is deleted from `static/`.
- **`[markup.goldmark.renderer] unsafe = true`** — lets raw HTML inside markdown render. None of the current `.md` files have body content (all front-matter stubs pointing at layouts), so this doesn't matter yet, but the option is on for when page bodies start migrating into markdown. Risk profile is "trust your own repo's markdown," which on a single-author site is fine.
- **`disableKinds = ["taxonomy", "term", "RSS"]`** — this isn't a blog and doesn't need category-archive pages or an RSS feed. Closes noise routes Hugo would otherwise generate.
- **`[params]`** — `description` (sitewide default for OG/meta) and `[params.brand]` (`word1` / `word2` for the nav-brand split per B-029).

**Tradeoff:** five settings to maintain instead of one. Acceptable; the file is short and every line traces to a decision.

---

## Open Questions

### OQ-B3 — Custom domain or `*.github.io` subdomain?
**Status:** *Effectively closed by B-021* — keeping as OQ until DNS lands.

Cloudflare Pages serves `bysimms.co`. DNS A/CNAME records need to point at Cloudflare; until that's actually configured, this stays "open" so it doesn't get forgotten.

---

### OQ-B4 — Markdown → HTML sync workflow
**Trigger to resolve:** after the first content change is needed in production under Hugo
**Related decisions:** B-003, B-018, B-020

Hugo (B-020) handles the heavy lifting for prose. What remains tricky:

- **Palette table** — HEX/CMYK across light and dark, with usage notes. A Hugo shortcode that reads a small data file (`data/palette.yaml`) and renders the swatch grid would mean changing one row of YAML instead of two HTML blocks.
- **Decisions log** — currently markdown with hand-built status counters. A shortcode that reads YAML frontmatter on each decision and aggregates would close this.

Probably worth doing the palette shortcode first; the decisions one second.

---

### OQ-B6 — Self-host fonts?
**Trigger to resolve:** if Google Fonts becomes a problem (privacy, performance, offline)
**Related decisions:** B-012, B-023

Four Google Fonts now (Instrument Serif, Geist, JetBrains Mono, Mrs Saint Delafield). Self-hosting is a download-and-`@font-face` job. Not urgent; the privacy/performance hit from Google Fonts is small for this audience. Mrs Saint Delafield is the most niche of the four — if any one of them gets self-hosted first, it'll be that one.

---

## Conventions

- **B-NNN** — build/site decision IDs. Distinct from `D-NNN` (vehicle project decisions). Never renumbered; status can change but the ID is permanent. Superseded decisions keep their ID and add a **Superseded by** line.
- **OQ-BN** — site-build open questions. Distinct from `OQ-N` (vehicle project open questions). Each has a stated trigger.
- **Status values:** *Decided* · *In progress* · *Open* · *Not applicable*.
- **File scope:** this file documents *how the site is built and branded*. Anything about *what the site says* (vehicles, budgets, the buying process) belongs in `DECISIONS.md`, not here.

---

*Last updated: May 14, 2026. Mirrors the convention used in [`DECISIONS.md`](DECISIONS.md). Brand specifics live in [`BRAND.md`](BRAND.md). Rendered as `/site-decisions/` under Hugo, eventually.*
