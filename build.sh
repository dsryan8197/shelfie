#!/bin/zsh
# Builds Shelfie and installs it to /Applications.
# ./build.sh dist  also makes dist/Shelfie.dmg to share.
set -e
cd "$(dirname "$0")"
APP=Shelfie.app
rm -rf $APP
mkdir -p $APP/Contents/MacOS $APP/Contents/Resources
# Universal binary: Apple Silicon + Intel. macOS 26+ (uses Apple's on-device model for names).
for arch in arm64 x86_64; do
  swiftc -swift-version 5 -O -target $arch-apple-macos26 main.swift -o /tmp/Shelfie-$arch
done
lipo -create /tmp/Shelfie-arm64 /tmp/Shelfie-x86_64 -output $APP/Contents/MacOS/Shelfie
rm /tmp/Shelfie-arm64 /tmp/Shelfie-x86_64
cp AppIcon.icns $APP/Contents/Resources/
cat > $APP/Contents/Info.plist <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>CFBundleName</key><string>Shelfie</string>
  <key>CFBundleDisplayName</key><string>Shelfie</string>
  <key>CFBundleIdentifier</key><string>com.danielryan.screenshotdock</string>
  <key>CFBundleExecutable</key><string>Shelfie</string>
  <key>CFBundleIconFile</key><string>AppIcon</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>LSMinimumSystemVersion</key><string>26.0</string>
  <key>NSPhotoLibraryAddUsageDescription</key><string>Shelfie saves screenshots to Photos when you press 5, so they sync to your iPhone.</string>
  <key>NSDesktopFolderUsageDescription</key><string>Shelfie watches for new screenshots and puts "Remember" screenshots on your Desktop.</string>
</dict></plist>
PLIST
codesign --force --sign - $APP
echo "Built $APP"

if [[ "$1" == "dist" ]]; then
  rm -rf dist && mkdir -p dist/stage
  cp -R $APP dist/stage/
  ln -s /Applications dist/stage/Applications
  hdiutil create -volname "Shelfie" -srcfolder dist/stage -ov -format UDZO dist/Shelfie.dmg >/dev/null
  rm -rf dist/stage
  echo "Made dist/Shelfie.dmg"
fi

# Install: move into /Applications so there's only one copy on this Mac.
pkill -x Shelfie || true
pkill -x ScreenshotDock || true        # the app's name before it became Shelfie
rm -rf /Applications/ScreenshotDock.app
sleep 1
rm -rf /Applications/$APP
mv $APP /Applications/
open /Applications/$APP
echo "Installed to /Applications"
