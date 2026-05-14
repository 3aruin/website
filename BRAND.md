---
title: Working File — Brand Book
project: Vehicle Project (website design system)
version: 1.0
last_updated: 2026-05-13
renders_to: theme-preview.html
status_counts:
  principles: 4
  color_tokens: 14
  type_families: 3
  type_levels: 7
  components: 9
---

# Working File · Brand Book v1.0

A warm, editorial design system for working files, decision logs, and personal references. The whole system rides on CSS variables — fourteen named colors paired across light and dark, three typefaces, a handful of editorial components. This document is the source of truth for [`theme-preview.html`](theme-preview.html), the rendered brand book.

---

## 01 · Principles

Four ideas the system is willing to be inflexible about. Everything else can flex; these don't.

### Warmth
The surface reads as paper, not screen. Page is cream or deep ink — never pure white, never pure black. Text is warm-dark or warm-cream. The whole palette tilts toward the red side of neutral.

### Restraint
One accent, used sparingly. The italic emphasis, the recommendation block, the burgundy mark — they earn attention by being rare. Two accent uses per page is the ceiling.

### Editorial
Numbered sections, serif headlines, italic emphasis on key words, mono labels for metadata. The system reads like a working magazine layout, not a dashboard.

### Dual mood
Same character in light and dark. Dark is intentional, not inverted — a leather-bound book by a reading lamp, not a generic dark theme. Accents lift; surfaces deepen; nothing flips.

---

## 02 · Palette

Fourteen named colors, each defined for both light and dark. Surfaces and ink carry structure; accents and functional colors carry meaning. Every value is a CSS custom property routed through `:root` (light) or `[data-theme="dark"]`.

**CMYK note:** values below are mathematical sRGB → CMYK conversions for working specs. Production print should ICC-profile match against destination paper — the math here gives the print shop a starting point.

### Surfaces & Ink

| Token       | Name  | Light HEX (CMYK)         | Dark HEX (CMYK)           | Usage |
|-------------|-------|--------------------------|---------------------------|-------|
| `--bg`      | Page  | `#faf7f2` · 0 / 1 / 3 / 2 | `#16130e` · 0 / 14 / 36 / 91 | Primary page surface — the "paper" beneath all content |
| `--bg-card` | Card  | `#ffffff` · 0 / 0 / 0 / 0 | `#1f1b15` · 0 / 13 / 32 / 88 | Raised content: cards, decisions, panels, stat cells |
| `--bg-soft` | Soft  | `#f3eee5` · 0 / 2 / 6 / 5 | `#28231b` · 0 / 13 / 33 / 84 | Subtle fills — hover states, open badges, table bands |
| `--ink`     | Ink   | `#1a1816` · 0 / 8 / 15 / 90 | `#f0e9db` · 0 / 3 / 9 / 6   | Primary text — headlines, titles, navigation |
| `--ink-2`   | Ink 2 | `#3d3a35` · 0 / 5 / 13 / 76 | `#c4baa8` · 0 / 5 / 14 / 23 | Body text — paragraphs, decision bodies |
| `--ink-3`   | Ink 3 | `#6b655c` · 0 / 6 / 14 / 58 | `#897f6e` · 0 / 7 / 20 / 46 | Tertiary — eyebrows, captions, metadata, mono labels |

### Accents & Functional

| Token          | Name        | Light HEX (CMYK)           | Dark HEX (CMYK)            | Usage |
|----------------|-------------|----------------------------|----------------------------|-------|
| `--accent`     | Accent      | `#8b3a2f` · 0 / 58 / 66 / 45 | `#d4897a` · 0 / 35 / 42 / 17 | Primary brand mark — italic emphasis, reco bar, links |
| `--accent-soft`| Accent soft | `#f0d9d2` · 0 / 10 / 13 / 6  | `#3a201a` · 0 / 45 / 55 / 77 | Rejected badge fill; pairs with `--accent-ink` |
| `--tan`        | Tan         | `#c69568` · 0 / 25 / 47 / 22 | `#d9b287` · 0 / 18 / 38 / 15 | Secondary warm hue — decorative only, never structural |
| `--tan-soft`   | Tan soft    | `#f1e3d2` · 0 / 6 / 13 / 5   | `#3a2c1d` · 0 / 24 / 50 / 77 | Recommendation block gradient base |
| `--green`      | Green       | `#4a6741` · 28 / 0 / 37 / 60 | `#9bb585` · 14 / 0 / 27 / 29 | Functional — success / decided. Forest, not bright |
| `--green-soft` | Green soft  | `#dfe8da` · 4 / 0 / 6 / 9    | `#2a3a22` · 28 / 0 / 41 / 77 | Decided badge fill — calm, never celebratory |
| `--amber`      | Amber       | `#a87617` · 0 / 30 / 86 / 34 | `#dcb547` · 0 / 18 / 68 / 14 | Functional — in progress / open. Mustard, not orange |
| `--amber-soft` | Amber soft  | `#f3e6c8` · 0 / 5 / 18 / 5   | `#3a2e14` · 0 / 21 / 66 / 77 | In-progress badge fill — soft warning, never alarm |

### Pairing rules

Functional colors come in triplets: a base, a soft-fill background, and an ink-variant for readable on-color text.

| Soft (background)   | Ink (text on soft)               | Used in                          |
|---------------------|----------------------------------|----------------------------------|
| `--accent-soft`     | `--accent-ink` — `#8b3a2f` / `#ec9f8e` | Rejected badges, accent callouts  |
| `--green-soft`      | `--green-ink` — `#2f4729` / `#c0d4a8`   | Decided badges                   |
| `--amber-soft`      | `--amber-ink` — `#6f4c0e` / `#ecc875`   | In-progress badges, open callouts |

New badge states follow the same pattern: pick a hue, define soft + ink variants for both modes.

---

## 03 · Typography

Three typefaces, distinct registers. All loaded from Google Fonts.

### Families

**Instrument Serif** — Display headlines and italic emphasis. Carries the editorial character. The italic forms are the centerpiece of the signature emphasis pattern.

**Geist** — Body text, UI elements, button labels, anything readable at small sizes. Weights used: 400 (regular), 500 (medium), 600 (semibold).

**JetBrains Mono** — Eyebrows, IDs, metadata, status labels, numerical detail. Reserved for things where character width or "code-feel" matters.

### Type scale

| Role     | Family            | Size (px)       | Weight | Letterspacing | Usage                              |
|----------|-------------------|-----------------|--------|---------------|------------------------------------|
| Display  | Instrument Serif  | 64–144 (clamp)  | 400    | −0.035em      | Brand cover, hero `h1`             |
| H2       | Instrument Serif  | 36–52           | 400    | −0.025em      | Section headings                   |
| Tagline  | Instrument Serif  | 24–32           | 400    | −0.01em       | Secondary serif line below `h1`    |
| H3       | Geist             | 18              | 600    | −0.005em      | Card and UI headings               |
| Body     | Geist             | 16              | 400    | normal        | Paragraphs, default body           |
| Small    | Geist             | 13              | 400    | normal        | Captions, secondary text           |
| Eyebrow  | JetBrains Mono    | 11–11.5 (CAPS)  | 600    | +0.10–0.14em  | Section eyebrows, IDs, labels      |

Line heights: 1.0 for display, 1.05–1.15 for H2 and tagline, 1.55–1.65 for body. Generous body line-height is part of the warm-paper feel — not optional.

### Italic emphasis (signature pattern)

The single most distinctive technique in the system. Italicize **one** key word in a display headline and color it with `--accent`. The serif's italic forms (especially Instrument Serif) carry a printed-press feel that pairs with the warm palette.

**Examples:**

- Replacing the Vibe, *thoughtfully.*
- One theme, *two moods.*
- Working *File.*

**Do:**
- Italicize a single key word per display headline.
- Reserve for `h1` / hero-level type only.
- End the italic with a period for finality.

**Don't:**
- Apply to body or UI sizes — loses character at small scale.
- Italicize whole phrases — pick one word.
- Use a non-serif italic for this pattern.

---

## 04 · Components

Every component uses tokens — no hard-coded hex anywhere. Both modes work automatically.

### Stat strip
Auto-fit grid of metric cells. Three to five cells per row. Each cell: mono uppercase label, serif value, optional small subtext. For at-a-glance status surfaces.
**Markup:** `<div class="stats"><div class="stat">` containing `.stat-label`, `.stat-value`, `.stat-sub`.

### Recommendation / featured block
The strongest visual hierarchy. Vertical accent bar (left), gradient background using `--reco-gradient`, italic emphasis on the headline. **Reserve for one item per page max.**
**Markup:** `<div class="recommendation">` with `.reco-label` (mono), `.reco-pick` (serif with `<em>`), `.reco-price` (mono detail), `.reco-body` (prose).

### Card
Plain content surface. White background (light) or warm dark (dark), 1px border, subtle shadow, 10px rounded.
**Markup:** `<div class="card">`.

### Open question strip
Amber left-border treatment for unresolved items. Contains: ID (mono amber), question (sans), trigger condition (small sans).
**Markup:** `<div class="open-q">` with `.open-q-id`, `.open-q-q`, `.open-q-trig`.

### Status badge
Four states, each a soft-fill / ink-text pair from the functional palette.
**Markup:** `<span class="badge decided">`, `.progress`, `.rejected`, `.open`.

### Decision item
For decision logs and change records. Header row: ID (mono), title (sans semibold), status badge. Body: prose with bold for the operative noun.
**Markup:** `<article class="decision">` with `.decision-head` and `.decision-body`.

### Clean list
List with burgundy arrow bullets (`→`) and dashed dividers. For next-actions and short lists.
**Markup:** `<ul class="clean"><li>`.

### Two-column grid
Equal-width 2-col collapsing to 1-col under 760px.
**Markup:** `<div class="two-col">`.

### Nav
Sticky top with brand (serif italic with one word in accent), optional nav links (sans), and theme toggle button. Backdrop-filter blur uses `--nav-bg`.
**Markup:** `<nav class="nav">` with `.nav-inner`, `.nav-brand`, `.nav-links`, `.theme-toggle`.

---

## 05 · Theme & implementation

### CSS variable model

All theme values live as CSS custom properties on `:root` / `[data-theme="light"]` (defaults) and `[data-theme="dark"]`. Toggling the theme is a single attribute swap on `<html>`. No build step, no preprocessing.

### Theme toggle behavior

1. On first load, check `localStorage.theme`.
2. If missing, fall back to `window.matchMedia('(prefers-color-scheme: dark)')`.
3. On user toggle, write to `localStorage`.
4. Listen for system preference changes; only follow if no localStorage entry exists.

Inline script runs before paint to avoid flash-of-wrong-theme.

### Re-skinning the system

To shift this brand to a different aesthetic (different project, different mood):

1. Edit `--accent` and `--accent-soft` for both modes — this carries 80% of the brand identity.
2. Edit `--tan` / `--tan-soft` if you want a different secondary warm hue.
3. **Leave surfaces and ink alone** if you want to keep the warm-paper character. Shift them only if the project demands a colder temperature.
4. Functional colors (`--green`, `--amber`) can stay — they communicate state, not brand.
5. Recompute CMYK values for any token you change.

### Voice (brief)

The brand voice carries the same editorial restraint as the visuals.

- Direct, not breathless. "Hub stays as the comprehensive doc" beats "We're so excited to announce…"
- Acknowledge tradeoffs out loud. Every meaningful choice has a cost.
- Use IDs. Decisions are `D-001`, build decisions `B-001`, open questions `OQ-N`.
- Eyebrows are mono CAPS — section descriptors, metadata, status.
- One italic word per headline.

---

## Colophon

**Working File · Brand Book v1.0 · May 2026**

Source: this file. Rendered view: [`theme-preview.html`](theme-preview.html). Sits in the same repo as [`DECISIONS.md`](DECISIONS.md) (vehicle project decisions) and [`SITE_DECISIONS.md`](SITE_DECISIONS.md) (site build decisions).

Typefaces — [Instrument Serif](https://fonts.google.com/specimen/Instrument+Serif), [Geist](https://fonts.google.com/specimen/Geist), [JetBrains Mono](https://fonts.google.com/specimen/JetBrains+Mono) — all served via Google Fonts.

---

*Last updated: May 13, 2026. Naming convention and conventions for this file follow [`SITE_DECISIONS.md`](SITE_DECISIONS.md).*
