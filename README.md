# AppBoard

**Languages**: [English](README.md) | [简体中文](i18n/README.zh.md) | [繁體中文](i18n/README.zh-TW.md) | [日本語](i18n/README.ja.md) | [한국어](i18n/README.ko.md) | [Français](i18n/README.fr.md) | [Español](i18n/README.es.md) | [Deutsch](i18n/README.de.md) | [Русский](i18n/README.ru.md) | [हिन्दी](i18n/README.hi.md) | [Tiếng Việt](i18n/README.vi.md) | [Italiano](i18n/README.it.md) | [Čeština](i18n/README.cs.md)

macOS Tahoe removed Launchpad, the new Apps experience doesn't meet user needs and doesn't take full advantage of the machine's Bio GPU. Yet Apple offers no way to roll back. AppBoard tries to fix that.

*AppBoard is developed based on [LaunchNext](https://github.com/RoversX/LaunchNext) and [LaunchNow](https://github.com/ggkevinnnn/LaunchNow), many thanks to the original projects!*

*LaunchNext and LaunchNow are both licensed under GPL 3, and AppBoard follows the same license terms.*

⭐ Please consider starring [LaunchNext](https://github.com/RoversX/LaunchNext) and the original [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)!


## What AppBoard Delivers
- ✅ **Faithful classic Launchpad experience** — We try to recreate the old Launchpad feel, including long-press jiggle/delete management, drag-to-merge apps into folders, and more.
- ✅ **One-click import from the legacy Launchpad** — Reads your native Launchpad SQLite database directly to rebuild folders, app positions, and layout.
- ✅ **Manual app organization** — Move apps, create folders, and keep the layout exactly how you want it.
- ✅ **Two rendering paths** — `Legacy Engine` for compatibility, `Next Engine + Core Animation` for the best experience.
- ✅ **Compact and fullscreen modes** — Each with its own saved settings.
- ✅ **Keyboard-first workflow** — Fast search, navigation, and launching.
- ✅ **Hot Corner and native gesture activation** — Multiple global entry points.
- ✅ **Drag apps directly to the Dock** — Available in the Core Animation engine.
- ✅ **Update hub with Markdown release notes** — A richer in-app update flow.
- ✅ **Backup and restore tools** — Safer export and restore.
- ✅ **Accessibility and controller support** — Voice feedback and gamepad navigation are both enhanced.
- ✅ **Broad localization** — Wide coverage of UI languages.

## What macOS Tahoe Took Away

- ❌ No custom app organization
- ❌ No user-created folders
- ❌ No drag-and-drop customization
- ❌ No visual app management
- ❌ Forced categorical grouping

## Data Storage

Application data lives at:

```text
~/Library/Application Support/AppBoard/Data.store
```

## Native Launchpad Integration

AppBoard reads directly from the system Launchpad database:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## Installation

### Requirements

- macOS 26 (Tahoe) or later
- Apple Silicon or Intel processor
- Xcode 26 (when building from source)

### Build from Source

1. **Clone the repository**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Open in Xcode**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **Build and run**
   - Select your target device
   - Press `⌘+R` to build and run
   - Or `⌘+B` to build only

### Command Line Build

Building is a two-step process: first ensure SwiftUpdater has been built (only required on the first build or after cleaning), then build the main app.

**1. One-time SwiftUpdater pre-build**

You only need this on the first checkout, or after deleting `UpdaterScripts/SwiftUpdater/.build/`:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
The output lands at `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`. The main app's `Run Script Phase` copies it automatically.

**2. Build the main app**
- Debug build (day-to-day):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
Output: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release build:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- Release packaging (Release + zip + checksum):
```bash
./scripts/release.sh
```

This script runs a `clean build` of `Release`, zips `AppBoard.app` as `AppBoard<version>.zip` under `Build/dist/`, and produces `checksums.txt`.

- Building inside Xcode
Open `AppBoard.xcodeproj`, press `Cmd+B` to build or `Cmd+R` to run. `Xcode` picks the `AppBoard scheme` automatically. You still need to pre-build `SwiftUpdater` once with the command above.

**3. Universal binary (Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## Usage

### Getting Started

1. AppBoard scans every installed app on first launch
2. Import your legacy Launchpad layout, or start from a blank one
3. Organize apps through search, keyboard navigation, mouse drag, and folders
4. Configure engine, layout mode, activation, and automation in Settings

### Import Your Launchpad

1. Open Settings
2. Click **Import Launchpad**
3. Your existing layout and folders are imported automatically

### Engines and Layout Modes

- **Legacy Engine** — Keeps the old rendering path, prioritizing compatibility
- **Next Engine + Core Animation** — Recommended for the best overall experience and new feature support
- **Compact / Fullscreen** — AppBoard supports both modes and saves their settings separately

## Key Features

### Activation and Input

- **Hot Corner support** — Open AppBoard from a configurable screen corner
- **Experimental native gestures** — Four-finger pinch / tap actions
- **Global shortcut support** — Open AppBoard from anywhere
- **Drag apps to the Dock** — Hand an app straight to the macOS Dock in the Core Animation engine

### Update Experience

- **In-app update hub** — Check for updates without leaving the app
- **Markdown release notes** — Richer release notes shown directly in Settings
- **Modern notification API** — Works with the updated macOS notification system

### Backup and Restore

- Create and restore backups from Settings
- More reliable backup export behavior
- Safer handling of temporary files and cleanup

### Accessibility and Navigation

- **Voice feedback** — Announce app and folder names while navigating
- **Controller support** — Drive AppBoard and folders with a gamepad
- **Keyboard-first interaction** — Search and navigate without ever touching the mouse

## Performance and Reliability

- Smart icon caching for smooth browsing
- Lazy loading and background scanning for large app libraries
- Better Settings and navigation state sync
- Improved reliability around update handling, backup export, and gesture recovery


## Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Swift style conventions
- Add meaningful comments for complex logic
- Test across multiple macOS versions when possible
- Avoid scattering experimental features into unrelated files
- Keep removable integrations isolated

## The Future of App Management

As Apple drifts away from customizable app launchers, AppBoard works to preserve manual organization, user control, and efficient access on modern macOS.

**AppBoard** is more than a Launchpad replacement — it's a pragmatic answer to workflow regression.

---

**AppBoard** — Reclaim Your App Launcher 🚀

*Built for macOS users who refuse to compromise on customization.*

## Development Tools

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
