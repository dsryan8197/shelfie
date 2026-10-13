# Screenshot Dock

A Mac app that keeps screenshots off your Desktop and one click away in the Dock.

- **Pick where each screenshot goes** with a quick-choice bar that appears right after you take it.
- **Grab them from the Dock.** Click the Dock icon for a shelf of your screenshots, newest first. Drag one into any app.
- **Names you can read.** Apple's on-device text recognition and AI rename each screenshot from what's in it, like `Youth Soccer Schedule – Oct 13, 4.27 PM.png`. Nothing leaves your Mac.

## The quick-choice bar

After each screenshot, press a number (or click). If you do nothing for 6 seconds, it goes to **Random**.

Taking several screenshots in a row? While the bar is showing, each new one joins the same batch (the bar shows a count and the timer restarts), and one choice files them all.

| Key | Category | Where it goes |
|---|---|---|
| **1** | Remember | Your Desktop, and pinned on the shelf |
| **2** | Inspiration | `~/Screenshots/Inspiration` |
| **3** | Random (default) | `~/Screenshots/Random` |
| **4** | Records | `~/Screenshots/Records/<year>` |
| **5** | Photos | Saved to Photos (syncs to your iPhone) and `~/Screenshots/Random` |

## The shelf

- **Click the Dock icon** to open it, or **hold ⌥`** (Option + backtick) to peek at it under your mouse. Tap the key to keep it open.
- **Drag a screenshot out** and it leaves the shelf. The file stays in its folder.
- **Pin** keeps a screenshot on the shelf. **✕** removes it from the shelf only.
- **Recently removed** at the bottom brings back anything you took off by mistake.
- Delete a file in Finder and it disappears from the shelf too.
- Right-click the Dock icon for your latest screenshots.

## Copy-only screenshots

**⌘2** takes a screenshot straight to the clipboard, with no file, for things you're about to paste. (You can turn this off in settings, since ⌘2 is also "switch to tab 2" in browsers.)

## Setup

Open the shelf and click **Set up** once. It points macOS screenshots at `~/Screenshots/Inbox` and turns off the floating thumbnail, so the choice bar appears instantly and nothing lands on your Desktop. Settings has a button to restore Apple's defaults.

Requires macOS 26 or newer. Names use Apple Intelligence when it's on, and fall back to the screenshot's largest heading when it isn't.

## Build it yourself

```bash
./build.sh        # builds and installs to /Applications
./build.sh dist   # also makes dist/ScreenshotDock.dmg
```

The whole app is one file: [`main.swift`](main.swift).

## License

[MIT](LICENSE)
