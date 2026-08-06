# Pitch Chart

Live pitch charting and opponent tendency tool for baseball.

Chart pitches in real time — type, location, count, result — and the app surfaces
what the opposing pitcher actually does: his mix by count, tendencies that differ
from his own baseline, sequencing patterns, and how your hitters have fared.

Everything runs locally. No account, no server, no network calls.

## Layout

```
index.html       The app — a single self-contained file
sw.js            Service worker, for offline use on the web
PitchChartApp/   Native iOS wrapper (Xcode project)
```

There is one copy of `index.html`, at the repo root. The iOS project references it
directly as a bundled resource, so editing it updates both the web and iOS versions.

## Web version

Open `index.html` in a browser, or host it anywhere static. It registers a service
worker over HTTPS so it keeps working offline once loaded.

## iOS app

Open the Xcode project and run:

```bash
open PitchChartApp/PitchChartApp.xcodeproj
```

A SwiftUI app wrapping the web app in a `WKWebView`, loading from the bundle over
`file://`. Requires iOS 17+. Builds for iPhone and iPad.

To build and run from the command line:

```bash
xcodebuild build -project PitchChartApp/PitchChartApp.xcodeproj \
  -scheme PitchChartApp -sdk iphonesimulator CODE_SIGNING_ALLOWED=NO
```

## Velocity

Optional. There's a velo box on the Chart tab — type a number before tapping the
result and it rides along with that pitch. Leave it blank whenever the gun's
down; every other number in the app works without it, and a half-charted game
still gives honest velocity numbers for the pitches you did get.

Readings clear after each pitch rather than carrying over, so a stale number
never gets stamped onto pitches nobody gunned. The last reading from the man on
the mound shows as the placeholder, for reference.

With readings in, the Pitcher tab adds:

- **Per pitch type** — average, peak, low, spread
- **Inning by inning** — the fatigue read, flagging a drop off his own peak.
  Bars are scaled to a fixed 4 mph window, so a pitcher holding 90.1–90.4 draws
  a flat line instead of a misleading staircase
- **What he gives up, and for what** — where he takes something off to locate,
  and where he reaches back. Each split is measured against the same pitch type
  everywhere else, so a changeup isn't flagged merely for being slower than a
  fastball

Gaps under 1 mph are treated as gun scatter and left out. Splits need at least
three readings before they're shown at all.

## What it tells you

**While you're charting.** The Chart tab shows what this pitcher throws in the
situation in front of you — the live count, batter hand, runners. When the exact
count is too thin it widens to "with two strikes" or "when he's behind" and says
which. It also carries a pitch count, and raises a fatigue flag only when the
count and a real velocity drop agree; either alone is too easy to over-read.

**After the fact.** The Pitcher tab covers tendencies that differ from his own
baseline, sequencing, count splits, velocity by inning, the contact he gives up,
and the umpire's actual zone that day — called strikes outside the box and balls
inside it, drawn from pitches the hitter took.

Everything states its sample size, and views stay silent rather than print a
percentage built on three events.

## Themes

Dark by default, with a light theme for charting outdoors — a dark screen in
direct sun is close to unreadable. The sun/moon button in the tab row switches
between them.

Until you pick one, it follows the device setting and flips itself at sunset.
Once you choose, that choice sticks for that device. The iOS app follows the
same system setting, status bar included.

Every colour is a CSS variable declared once per theme at the top of
`index.html`; nothing below that block is hardcoded. The light theme uses its
own darker pitch colours, since the neon set washes out on white.

## Data

All charting data lives in `localStorage`, scoped to wherever it runs — the browser
for the web version, the app container for iOS. The two do not share data, and
deleting the app or clearing site data wipes it.

Use the backup export in the Games tab to save a JSON file after each game, and the
import to move data between the web and app versions.
