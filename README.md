# Think Layer

Marketing site for Think Layer: egocentric capture of real human work, sold as training data
for physical AI.

## Do not edit index.html

`index.html` is **generated**. Edit the source, then rebuild:

```sh
./build.sh capture-floor.html index.html
```

The reason for the build step: this page is published both as a Claude Artifact and to Vercel,
and the two want different things. The Artifact publisher injects its own
`<!doctype html><html><head>…</head><body>` wrapper, so the source file must **not** carry a
document skeleton. Vercel serves the file byte for byte, and without a doctype the browser drops
into quirks mode, where `document.scrollingElement` resolves to `<body>` instead of `<html>` and
the scroll-driven camera stops tracking. `build.sh` wraps the source with the doctype, charset and
viewport meta so the deployed copy renders in standards mode.

## Files

| File | What it is |
|---|---|
| `capture-floor.html` | **Source of the live site.** Three.js warehouse you walk through on scroll. |
| `index.html` | Generated from the above by `build.sh`. This is what Vercel serves. |
| `under-one-roof.html` | Alternative photographic version. Not deployed, kept for reference. |
| `img/` | Placeholder photography for `under-one-roof.html` only. Unused by the live site. |
| `build.sh` | The wrapper step described above. |

## Notes on the 3D floor

- `three.js` r128 and GSAP ScrollTrigger load from cdnjs with pinned SRI hashes. If you bump a
  version you must recompute the hashes, or the scripts are blocked and the page falls back to
  its no-WebGL state.
- The warehouse is built from primitives at runtime. There is no `.glb` model and no `.hdr` map:
  the environment lighting is generated with `PMREMGenerator.fromScene()`. This is deliberate, as
  the Artifact CSP blocks fetching binary assets.
- `overflow-x: clip` on `body` is load-bearing. `overflow-x: hidden` computes to `hidden auto`,
  which makes `<body>` a scroll container and breaks ScrollTrigger's measurements.
- Motion respects `prefers-reduced-motion`.

## Photography

The images in `img/` are licensed placeholders (Unsplash, free for commercial use, no attribution
required). They stand in for the real floor. Replace them with actual capture stills when those
exist; every slot is a fixed aspect ratio, so the layout holds.
