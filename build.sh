#!/bin/zsh
# Builds Screenshot Dock and installs it to /Applications.
# ./build.sh dist  also makes dist/ScreenshotDock.dmg to share.
set -e
cd "$(dirname "$0")"
APP=ScreenshotDock.app
rm -rf $APP
mkdir -p $APP/Contents/MacOS $APP/Contents/Resources
# Universal binary: Apple Silicon + Intel. macOS 26+ (uses Apple's on-device model for names).
for arch in arm64 x86_64; do
  swiftc -swift-version 5 -O -target $arch-apple-macos26 main.swift -o /tmp/ScreenshotDock-$arch
done
lipo -create /tmp/ScreenshotDock-arm64 /tmp/ScreenshotDock-x86_64 -output $APP/Contents/MacOS/ScreenshotDock
rm /tmp/ScreenshotDock-arm64 /tmp/ScreenshotDock-x86_64
cp AppIcon.icns $APP/Contents/Resources/
cat > $APP/Contents/Info.plist <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>CFBundleName</key><string>Screenshot Dock</string>
  <key>CFBundleDisplayName</key><string>Screenshot Dock</string>
  <key>CFBundleIdentifier</key><string>com.danielryan.screenshotdock</string>
  <key>CFBundleExecutable</key><string>ScreenshotDock</string>
  <key>CFBundleIconFile</key><string>AppIcon</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>LSMinimumSystemVersion</key><string>26.0</string>
  <key>NSPhotoLibraryAddUsageDescription</key><string>Screenshot Dock saves screenshots to Photos when you press 5, so they sync to your iPhone.</string>
  <key>NSDesktopFolderUsageDescription</key><string>Screenshot Dock watches for new screenshots and puts "Remember" screenshots on your Desktop.</string>
</dict></plist>
PLIST
codesign --force --sign - $APP
echo "Built $APP"

if [[ "$1" == "dist" ]]; then
  rm -rf dist && mkdir -p dist/stage
  cp -R $APP dist/stage/
  ln -s /Applications dist/stage/Applications
  hdiutil create -volname "Screenshot Dock" -srcfolder dist/stage -ov -format UDZO dist/ScreenshotDock.dmg >/dev/null
  rm -rf dist/stage
  echo "Made dist/ScreenshotDock.dmg"
fi

# Install: move into /Applications so there's only one copy on this Mac.
pkill -x ScreenshotDock || true
sleep 1
rm -rf /Applications/$APP
mv $APP /Applications/
open /Applications/$APP
echo "Installed to /Applications"
