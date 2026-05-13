# AppBoard

**Sprachen**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe hat Launchpad entfernt; die neue Apps-Erfahrung erfüllt die Anforderungen der Nutzer nicht und schöpft die Bio GPU des Macs nicht aus. Apple bietet jedoch keine Option für den Rückweg. AppBoard versucht, diese Lücke zu schließen.

*AppBoard baut auf [LaunchNext](https://github.com/RoversX/LaunchNext) und [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) (Autor: ggkevinnnn) auf — vielen Dank an die Originalprojekte! ❤️*

*LaunchNext und LaunchNow stehen beide unter GPL 3, und AppBoard folgt denselben Lizenzbedingungen.*

⭐ Bitte gib auch [LaunchNext](https://github.com/RoversX/LaunchNext) und dem Originalprojekt [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) einen Stern!


## Was AppBoard bietet
- ✅ **Originalgetreues LaunchPad-Erlebnis** - Wir versuchen, die Bedienung des alten LaunchPad so weit wie möglich wiederherzustellen, inklusive Langdruck-Wackeln zum Löschen, Drag-to-merge gleichartiger Apps in einen Ordner und mehr.
- ✅ **Ein-Klick-Import vom alten LaunchPad** - Liest die native SQLite-Datenbank des Launchpad direkt aus und stellt Ordner, App-Positionen und Layout wieder her
- ✅ **Manuelle App-Organisation** - Apps verschieben, Ordner anlegen und Layouts so behalten, wie du es willst
- ✅ **Zwei Render-Pfade** - `Legacy Engine` für Kompatibilität, `Next Engine + Core Animation` für die beste Erfahrung
- ✅ **Kompakter Modus und Vollbildmodus** - Separat speicherbare Einstellungen
- ✅ **Tastatur-zuerst-Workflow** - Schnelle Suche, Navigation und Start
- ✅ **Hot Corner und native Gesten** - Mehrere globale Einstiegspunkte
- ✅ **Apps direkt ins Dock ziehen** - Im Core-Animation-Engine verfügbar
- ✅ **Update-Hub mit Markdown-Release-Notes** - Reichere In-App-Update-Erfahrung
- ✅ **Backup- und Wiederherstellungstools** - Sicherere Export- und Wiederherstellungsabläufe
- ✅ **Barrierefreiheit und Controller-Unterstützung** - Sprachfeedback und Gamepad-Navigation verbessert
- ✅ **Breite Lokalisierung** - Umfassende UI-Sprachabdeckung

## Was macOS Tahoe weggenommen hat

- ❌ Keine individuelle App-Organisation
- ❌ Keine vom Nutzer erstellten Ordner
- ❌ Keine Drag-and-drop-Anpassung
- ❌ Keine visuelle App-Verwaltung
- ❌ Erzwungene Kategoriegruppierung

## Datenspeicher

App-Daten werden gespeichert unter:

```text
~/Library/Application Support/AppBoard/Data.store
```

## Native Launchpad-Integration

AppBoard kann die System-Launchpad-Datenbank direkt auslesen:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## Installation

### Systemvoraussetzungen

- macOS 26 (Tahoe) oder neuer
- Apple Silicon oder Intel-Prozessor
- Xcode 26 (beim Bauen aus den Quellen)

### Aus den Quellen bauen

1. **Repository klonen**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **In Xcode öffnen**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **Bauen und ausführen**
   - Zielgerät auswählen
   - `⌘+R` zum Bauen und Starten drücken
   - Oder `⌘+B` nur zum Bauen

### Kommandozeilen-Build

Der Build erfolgt in zwei Schritten: Zuerst sicherstellen, dass SwiftUpdater gebaut wurde (nur beim ersten Mal oder nach einem Clean nötig), und dann die Haupt-App bauen.

**1. Einmaliges Vorab-Build von SwiftUpdater**

Nur nach dem ersten Klonen oder nach Löschen von UpdaterScripts/SwiftUpdater/.build/ nötig:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
Das Artefakt landet unter `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`. Die `Run Script Phase` der Haupt-`App` kopiert es automatisch.

**2. Haupt-App bauen:**
- Debug-Build (Alltag):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
Ergebnis: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release-Build:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- Release-Paket (Release + zip + checksum):
```bash
./scripts/release.sh
```

Dieses Skript führt `clean build` in `Release` aus, packt `AppBoard.app` als `AppBoard<Version>.zip` unter `Build/dist/` und erzeugt `checksums.txt`.

- Direkt in Xcode bauen
`AppBoard.xcodeproj` öffnen, `Cmd+B` zum Bauen, `Cmd+R` zum Starten. `Xcode` verwendet automatisch das `AppBoard scheme`. `SwiftUpdater` muss trotzdem einmal mit dem obigen Befehl gebaut werden.

**3. Universal Binary (Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## Verwendung

### Schnellstart

1. AppBoard durchsucht beim ersten Start alle installierten Apps
2. Importiere dein altes Launchpad-Layout oder starte mit einem leeren Layout
3. Organisiere Apps per Suche, Tastatur, Maus-Drag und Ordner
4. Konfiguriere Engine, Layoutmodus, Aktivierung und Automatisierung in den Einstellungen

### Launchpad importieren

1. Einstellungen öffnen
2. Auf **Import Launchpad** klicken
3. Bestehende Layouts und Ordner werden automatisch importiert

### Engines und Layoutmodi

- **Legacy Engine** - Behält den alten Render-Pfad bei, Kompatibilität hat Vorrang
- **Next Engine + Core Animation** - Empfohlen. Beste Gesamterfahrung und Support für neue Funktionen
- **Kompakt / Vollbild** - AppBoard unterstützt beide Modi und speichert ihre Einstellungen getrennt

## Wichtige Funktionen

### Aktivierung und Eingabe

- **Hot-Corner-Unterstützung** - AppBoard über eine konfigurierbare Bildschirmecke öffnen
- **Experimentelle native Gesten** - Pinch / Tap mit vier Fingern
- **Globale Tastenkürzel** - AppBoard von überall aus öffnen
- **Apps ins Dock ziehen** - Im Core-Animation-Engine wird die App direkt an das macOS-Dock übergeben

### Update-Erfahrung

- **Update-Hub in der App** - Updates prüfen, ohne die App zu verlassen
- **Markdown-Release-Notes** - Inhaltsreiche Release-Notes direkt in den Einstellungen
- **Moderne Notification API** - Passt zum aktualisierten macOS-Benachrichtigungssystem

### Backup und Wiederherstellung

- Backups in den Einstellungen erstellen und wiederherstellen
- Zuverlässigeres Backup-Export-Verhalten
- Sichere Handhabung temporärer Dateien und Aufräumarbeiten

### Barrierefreiheit und Navigation

- **Sprachfeedback** - App- und Ordnernamen beim Navigieren ansagen
- **Controller-Unterstützung** - AppBoard und Ordner per Gamepad steuern
- **Tastatur-zuerst-Interaktion** - Schnell suchen und navigieren ohne Maus

## Performance und Stabilität

- Intelligenter Icon-Cache für flüssiges Stöbern
- Lazy Loading und Hintergrund-Scans für große App-Bibliotheken
- Bessere Synchronisierung von Einstellungs- und Navigationszustand
- Höhere Zuverlässigkeit bei Update-Handling, Backup-Export und Gesten-Recovery


## Mitwirken

Beiträge sind willkommen.

1. Repository forken
2. Feature-Branch erstellen (`git checkout -b feature/amazing-feature`)
3. Änderungen committen (`git commit -m 'Add amazing feature'`)
4. Branch pushen (`git push origin feature/amazing-feature`)
5. Pull Request öffnen

### Entwicklungsrichtlinien

- Swift-Stilkonventionen folgen
- Sinnvolle Kommentare bei komplexer Logik ergänzen
- Wenn möglich auf mehreren macOS-Versionen testen
- Experimentelle Features nicht in unbeteiligten Dateien verstreuen
- Entfernbare Integrationen isolieren

## Die Zukunft der App-Verwaltung

Während Apple sich von anpassbaren App-Launchern abwendet, versucht AppBoard, manuelle Organisation, Nutzerkontrolle und effizienten Zugriff auf modernem macOS zu bewahren.

**AppBoard** ist mehr als ein Launchpad-Ersatz — es ist eine pragmatische Antwort auf den Rückschritt im Workflow.

---

**AppBoard** - Hol dir deinen App-Launcher zurück 🚀

*Für macOS-Nutzer, die bei Anpassbarkeit keine Kompromisse machen wollen.*

## Entwicklungstools

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
