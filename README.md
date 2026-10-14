# Screenshot Dock

A Mac app that keeps screenshots off your Desktop and one click away in the Dock.

- **Pick where each screenshot goes** with a quick-choice bar that appears right after you take it.
- **Grab them from the Dock.** Click the Dock icon for a shelf of your screenshots, newest first. Drag one into any app.
- **Names you can read.** Apple's on-device text recognition and AI rename each screenshot from what's in it, like `Youth Soccer Schedule – Oct 13, 4.27 PM.png`. Nothing leaves your Mac.

## The quick-choice bar

After each screenshot, press a number (or click). If you do nothing for 6 seconds, it goes to **Save**.

Taking several screenshots in a row? While the bar is showing, each new one joins the same batch (the bar shows a count and the timer restarts), and one choice files them all.

| Key | Category | Where it goes |
|---|---|---|
| **1** | Desktop | Loose on your Desktop |
| **2** | Save (default) | `Desktop/screenshots/save` |
| **3** | Inspiration | `Desktop/screenshots/inspiration` |
| **4** | Records | `Desktop/screenshots/records/<year>` |
| **5** | Photos | Saved to Photos (syncs to your iPhone) and `Desktop/screenshots/save` |

## Your screenshots folder

Save, Inspiration and Records go into a `screenshots` folder on your Desktop. You can move or rename that folder and Screenshot Dock follows it. If it's deleted, new screenshots go to your Desktop and the shelf shows an alert (with a **!** on the Dock icon) so you can choose a new folder. To use a different folder, open the shelf → gear → **Change…**

## The shelf

- **Click the Dock icon** to open it, or **hold ⌥`** (Option + backtick) to peek at it under your mouse. Tap the key to keep it open.
- **Drag a screenshot out** and it leaves the shelf. The file stays in its folder.
- **Pin** keeps a screenshot on the shelf. **✕** removes it from the shelf only.
- **Recently removed** at the bottom brings back anything you took off by mistake.
- Delete a file in Finder and it disappears from the shelf too.
- Right-click the Dock icon for your latest screenshots.
- Settings (gear) → **Screenshots per row**: 2, or 1 for larger previews. With 1 per row, pick how screenshots are separated: a divider line (image only) or a caption bar with the name on the image.

## Copy-only screenshots

For screenshots you're about to paste, use macOS's own "Copy picture of selected area to the clipboard" shortcut (System Settings → Keyboard → Keyboard Shortcuts → Screenshots). It never creates a file, so Screenshot Dock stays out of the way.

## Setup

Open the shelf and click **Set up** once. It points macOS screenshots at `~/Screenshots/Inbox` and turns off the floating thumbnail, so the choice bar appears instantly and nothing lands loose on your Desktop. If macOS keeps saving to the Desktop anyway, press ⌘⇧5 → Options → Other Location… and pick `~/Screenshots/Inbox` once. Settings has a button to restore Apple's defaults.

Requires macOS 26 or newer. Names use Apple Intelligence when it's on, and fall back to the screenshot's largest heading when it isn't.

## Build it yourself

```bash
./build.sh        # builds and installs to /Applications
./build.sh dist   # also makes dist/ScreenshotDock.dmg
```

The whole app is one file: [`main.swift`](main.swift).

## License

[MIT](LICENSE)
