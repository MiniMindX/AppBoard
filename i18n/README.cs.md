# AppBoard

**Jazyky**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe odstranil Launchpad, nový zážitek Apps nesplňuje potřeby uživatelů a ani plně nevyužívá Bio GPU počítače. Apple přesto nenabízí možnost se vrátit. AppBoard se snaží tento problém vyřešit.

*AppBoard je vyvíjen na základě [LaunchNext](https://github.com/RoversX/LaunchNext) a [LaunchNow](https://github.com/ggkevinnnn/LaunchNow), velké díky původním projektům!*

*LaunchNext i LaunchNow používají licenci GPL 3, AppBoard se řídí stejnými podmínkami.*

⭐ Zvažte prosím dát hvězdičku projektu [LaunchNext](https://github.com/RoversX/LaunchNext) i původnímu [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)!


## Co AppBoard nabízí
- ✅ **Zážitek věrný starému LaunchPadu** - Snažíme se v maximální možné míře obnovit chování klasického LaunchPadu, včetně dlouhého stisku pro chvění/odstraňování, přetahování stejných aplikací do jedné složky a další.
- ✅ **Import z původního LaunchPadu jedním kliknutím** - Přímo čte nativní SQLite databázi Launchpadu a rekonstruuje složky, pozice aplikací i rozložení
- ✅ **Ruční organizace aplikací** - Přesouvejte aplikace, vytvářejte složky a udržujte rozložení podle svého
- ✅ **Dvě cesty vykreslování** - `Legacy Engine` pro kompatibilitu, `Next Engine + Core Animation` pro nejlepší zážitek
- ✅ **Kompaktní režim a celá obrazovka** - Nastavení se ukládají odděleně
- ✅ **Workflow zaměřené na klávesnici** - Rychlé hledání, navigace a spouštění
- ✅ **Hot Corner a nativní gesta** - Více globálních bodů pro otevření
- ✅ **Přetahování aplikací přímo do Docku** - Dostupné v engine Core Animation
- ✅ **Centrum aktualizací s Markdown poznámkami k vydání** - Bohatší zážitek aktualizací v aplikaci
- ✅ **Nástroje zálohování a obnovy** - Bezpečnější export a obnova
- ✅ **Podpora přístupnosti a ovladačů** - Vylepšená hlasová zpětná vazba a navigace gamepadem
- ✅ **Široká lokalizace** - Široké pokrytí jazyků rozhraní

## Co macOS Tahoe odebral

- ❌ Žádná vlastní organizace aplikací
- ❌ Žádné uživatelské složky
- ❌ Žádné přizpůsobení přetahováním
- ❌ Žádná vizuální správa aplikací
- ❌ Vynucené seskupování podle kategorií

## Uložení dat

Data aplikace jsou uložena v:

```text
~/Library/Application Support/AppBoard/Data.store
```

## Integrace s nativním Launchpadem

AppBoard umí přímo číst systémovou databázi Launchpadu:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## Instalace

### Požadavky

- macOS 26 (Tahoe) nebo novější
- Procesor Apple Silicon nebo Intel
- Xcode 26 (pro sestavení ze zdrojů)

### Sestavení ze zdrojů

1. **Naklonujte repozitář**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Otevřete v Xcode**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **Sestavte a spusťte**
   - Vyberte cílové zařízení
   - Stiskněte `⌘+R` pro sestavení a spuštění
   - Nebo `⌘+B` pouze pro sestavení

### Sestavení z příkazové řádky

Sestavení má dva kroky: nejdřív se ujistěte, že je SwiftUpdater sestavený (potřeba jen poprvé nebo po cleanu), pak sestavte hlavní aplikaci.

**1. Jednorázové předsestavení SwiftUpdateru**

Potřebné jen při prvním naklonování nebo po smazání UpdaterScripts/SwiftUpdater/.build/:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
Výstup je v `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater` a `Run Script Phase` hlavní `App` ho automaticky zkopíruje.

**2. Sestavení hlavní aplikace:**
- Debug sestavení (běžné):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
Výsledek: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release sestavení:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- Release balík (Release + zip + checksum):
```bash
./scripts/release.sh
```

Skript spustí `clean build` v `Release`, zazipuje `AppBoard.app` jako `AppBoard<verze>.zip` do `Build/dist/` a vygeneruje `checksums.txt`.

- Sestavení přímo v Xcode
Otevřete `AppBoard.xcodeproj`, `Cmd+B` pro sestavení, `Cmd+R` pro spuštění. `Xcode` automaticky použije `AppBoard scheme`. `SwiftUpdater` přesto musíte jednou předem sestavit příkazem výše.

**3. Univerzální binárka (Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## Použití

### Rychlý začátek

1. AppBoard při prvním spuštění prohledá všechny nainstalované aplikace
2. Naimportujte rozložení původního Launchpadu nebo začněte s prázdným
3. Aplikace organizujte hledáním, klávesnicí, myší a složkami
4. V Nastavení nastavte engine, režim rozložení, způsob aktivace a automatizaci

### Import Launchpadu

1. Otevřete Nastavení
2. Klikněte na **Import Launchpad**
3. Stávající rozložení a složky se naimportují automaticky

### Enginy a režimy rozložení

- **Legacy Engine** - Zachovává starou cestu vykreslování, priorita kompatibilita
- **Next Engine + Core Animation** - Doporučeno. Lepší celkový zážitek i podpora nových funkcí
- **Kompaktní / Celá obrazovka** - AppBoard podporuje oba režimy a ukládá jejich nastavení odděleně

## Klíčové funkce

### Aktivace a vstup

- **Podpora Hot Corner** - Otevřete AppBoard z nastavitelného rohu obrazovky
- **Experimentální nativní gesta** - Akce pinch / tap čtyřmi prsty
- **Globální klávesové zkratky** - Otevřete AppBoard odkudkoli
- **Přetažení aplikací do Docku** - V engine Core Animation aplikaci předáte přímo Docku macOS

### Aktualizace

- **Centrum aktualizací v aplikaci** - Kontrolujte aktualizace bez opuštění aplikace
- **Poznámky k vydání v Markdownu** - Bohatší obsah zobrazený přímo v Nastavení
- **Moderní Notification API** - Kompatibilní s aktualizovaným notifikačním systémem macOS

### Zálohování a obnova

- Vytvářejte a obnovujte zálohy z Nastavení
- Spolehlivější export záloh
- Bezpečnější zacházení s dočasnými soubory a úklidem

### Přístupnost a navigace

- **Hlasová zpětná vazba** - Ohlašování názvů aplikací a složek během navigace
- **Podpora ovladačů** - Ovládejte AppBoard a složky gamepadem
- **Interakce zaměřená na klávesnici** - Hledání a navigace bez nutnosti používat myš

## Výkon a stabilita

- Chytré ukládání ikon pro plynulé procházení
- Lazy načítání a skenování na pozadí pro velké knihovny aplikací
- Lepší synchronizace stavu Nastavení a navigace
- Vyšší spolehlivost aktualizací, exportu záloh a obnovy gest


## Přispívání

Příspěvky jsou vítány.

1. Forkněte repozitář
2. Vytvořte feature větev (`git checkout -b feature/amazing-feature`)
3. Commitujte změny (`git commit -m 'Add amazing feature'`)
4. Pushněte větev (`git push origin feature/amazing-feature`)
5. Otevřete Pull Request

### Pravidla vývoje

- Dodržujte konvence stylu Swift
- Přidávejte smysluplné komentáře u složité logiky
- Pokud je to možné, testujte na více verzích macOS
- Nerozptylujte experimentální funkce do nesouvisejících souborů
- Odpojitelné integrace držte oddělené

## Budoucnost správy aplikací

Zatímco se Apple vzdaluje od přizpůsobitelných spouštěčů aplikací, AppBoard se snaží zachovat ruční organizaci, uživatelskou kontrolu a efektivní přístup na moderním macOS.

**AppBoard** není jen náhradou Launchpadu — je to praktická odpověď na regresi pracovních postupů.

---

**AppBoard** - Získejte zpět kontrolu nad svým spouštěčem aplikací 🚀

*Pro uživatele macOS, kteří odmítají dělat kompromisy v přizpůsobení.*

## Vývojové nástroje

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
