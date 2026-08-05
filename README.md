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
