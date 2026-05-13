# AppBoard

**Lingue**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe ha rimosso Launchpad e la nuova esperienza Apps non soddisfa le esigenze degli utenti né sfrutta appieno la Bio GPU del Mac. Apple però non offre alcuna opzione per tornare indietro. AppBoard prova a colmare questa lacuna.

*AppBoard si basa su [LaunchNext](https://github.com/RoversX/LaunchNext) e [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) (autore: ggkevinnnn) — un enorme grazie ai progetti originali! ❤️*

*LaunchNext e LaunchNow adottano entrambi la licenza GPL 3, e AppBoard segue gli stessi termini.*

⭐ Lascia una stella a [LaunchNext](https://github.com/RoversX/LaunchNext) e al progetto originale [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)!


## Cosa offre AppBoard
- ✅ **Esperienza fedele al vecchio LaunchPad** - Cerchiamo di ricreare al massimo l'esperienza del LaunchPad classico, inclusi la pressione prolungata che fa tremare le icone per gestire le rimozioni, il trascinamento per unire app simili in una cartella e altro ancora.
- ✅ **Importazione con un clic dal vecchio LaunchPad** - Legge direttamente il database SQLite nativo di Launchpad per ricostruire cartelle, posizioni delle app e layout
- ✅ **Organizzazione manuale delle app** - Sposta le app, crea cartelle e mantieni il layout esattamente come vuoi
- ✅ **Due percorsi di rendering** - `Legacy Engine` per la compatibilità, `Next Engine + Core Animation` per la migliore esperienza
- ✅ **Modalità Compact e Schermo intero** - Impostazioni salvate separatamente
- ✅ **Workflow orientato alla tastiera** - Ricerca, navigazione e avvio rapidi
- ✅ **Hot Corner e gesti nativi** - Diversi punti di accesso globali
- ✅ **Trascina le app direttamente sul Dock** - Disponibile nel motore Core Animation
- ✅ **Hub aggiornamenti con note in Markdown** - Esperienza di aggiornamento in-app più ricca
- ✅ **Strumenti di backup e ripristino** - Esportazione e ripristino più sicuri
- ✅ **Supporto per accessibilità e controller** - Feedback vocale e navigazione con gamepad migliorati
- ✅ **Ampia localizzazione** - Copertura linguistica estesa

## Cosa ci ha tolto macOS Tahoe

- ❌ Niente organizzazione personalizzata delle app
- ❌ Niente cartelle create dall'utente
- ❌ Niente personalizzazione tramite drag-and-drop
- ❌ Niente gestione visuale delle app
- ❌ Raggruppamento forzato per categoria

## Archiviazione dei dati

I dati dell'applicazione vengono salvati in:

```text
~/Library/Application Support/AppBoard/Data.store
```

## Integrazione con Launchpad nativo

AppBoard può leggere direttamente il database Launchpad di sistema:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## Installazione

### Requisiti

- macOS 26 (Tahoe) o successivo
- Processore Apple Silicon o Intel
- Xcode 26 (per compilare da sorgenti)

### Compilare dai sorgenti

1. **Clona il repository**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Apri in Xcode**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **Compila ed esegui**
   - Seleziona il dispositivo di destinazione
   - Premi `⌘+R` per compilare ed eseguire
   - Oppure `⌘+B` per solo compilare

### Compilazione da riga di comando

La compilazione avviene in due passi: prima assicurati che SwiftUpdater sia stato compilato (necessario solo al primo build o dopo un clean), poi compila l'app principale.

**1. Pre-build una tantum di SwiftUpdater**

Serve solo al primo checkout o dopo aver cancellato UpdaterScripts/SwiftUpdater/.build/:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
L'artefatto si trova in `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`, e la `Run Script Phase` dell'`App` principale lo copia automaticamente.

**2. Compila l'app principale:**
- Build Debug (quotidiano):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
Output: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Build Release:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- Packaging di release (Release + zip + checksum):
```bash
./scripts/release.sh
```

Questo script esegue un `clean build` in `Release`, comprime `AppBoard.app` in `AppBoard<versione>.zip` dentro `Build/dist/` e genera `checksums.txt`.

- Compilare direttamente in Xcode
Apri `AppBoard.xcodeproj`, `Cmd+B` per compilare, `Cmd+R` per eseguire. `Xcode` userà automaticamente il `AppBoard scheme`. `SwiftUpdater` va comunque compilato una volta con il comando sopra.

**3. Build universale (Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## Utilizzo

### Per iniziare

1. AppBoard analizza tutte le app installate al primo avvio
2. Importa il layout del vecchio Launchpad o parti da uno vuoto
3. Organizza le app tramite ricerca, tastiera, trascinamento e cartelle
4. Configura motore, modalità di layout, attivazione e automazione nelle Impostazioni

### Importa il tuo Launchpad

1. Apri le Impostazioni
2. Fai clic su **Import Launchpad**
3. Il layout e le cartelle esistenti vengono importati automaticamente

### Motori e modalità di layout

- **Legacy Engine** - Mantiene il percorso di rendering precedente, priorità alla compatibilità
- **Next Engine + Core Animation** - Consigliato. Migliore esperienza generale e supporto delle nuove funzioni
- **Compact / Schermo intero** - AppBoard supporta entrambe le modalità e ne salva le impostazioni separatamente

## Funzionalità chiave

### Attivazione e input

- **Supporto Hot Corner** - Apri AppBoard da un angolo dello schermo configurabile
- **Supporto sperimentale ai gesti nativi** - Azioni pinch / tap a quattro dita
- **Scorciatoia globale** - Apri AppBoard da qualsiasi punto
- **Trascina le app sul Dock** - Nel motore Core Animation l'app passa direttamente al Dock di macOS

### Esperienza di aggiornamento

- **Hub aggiornamenti in-app** - Verifica gli aggiornamenti senza uscire dall'app
- **Note di rilascio in Markdown** - Contenuti più ricchi mostrati direttamente nelle Impostazioni
- **API di notifica moderne** - Compatibili con il sistema di notifiche macOS aggiornato

### Backup e ripristino

- Crea e ripristina backup dalle Impostazioni
- Comportamento di esportazione del backup più affidabile
- Gestione più sicura di file temporanei e pulizia

### Accessibilità e navigazione

- **Feedback vocale** - Annuncia i nomi di app e cartelle durante la navigazione
- **Supporto controller** - Controlla AppBoard e le cartelle con un gamepad
- **Interazione orientata alla tastiera** - Cerca e naviga senza dover usare il mouse

## Prestazioni e stabilità

- Cache intelligente delle icone per una navigazione fluida
- Caricamento lazy e scansione in background per librerie di app grandi
- Migliore sincronizzazione dello stato di Impostazioni e navigazione
- Maggiore affidabilità di aggiornamenti, esportazione di backup e recupero dei gesti


## Contribuire

I contributi sono benvenuti.

1. Esegui il fork del repository
2. Crea un branch di funzionalità (`git checkout -b feature/amazing-feature`)
3. Esegui il commit delle modifiche (`git commit -m 'Add amazing feature'`)
4. Pusha il branch (`git push origin feature/amazing-feature`)
5. Apri una Pull Request

### Linee guida di sviluppo

- Segui le convenzioni di stile Swift
- Aggiungi commenti significativi per la logica complessa
- Quando possibile, testa su più versioni di macOS
- Evita di sparpagliare funzionalità sperimentali in file non correlati
- Tieni isolate le integrazioni rimovibili

## Il futuro della gestione delle app

Mentre Apple si allontana dai launcher personalizzabili, AppBoard cerca di preservare organizzazione manuale, controllo dell'utente e accesso efficiente sul macOS moderno.

**AppBoard** non è solo un sostituto di Launchpad — è una risposta pragmatica alla regressione dei flussi di lavoro.

---

**AppBoard** - Riprendi il controllo del tuo app launcher 🚀

*Costruito per gli utenti macOS che non vogliono scendere a compromessi sulla personalizzazione.*

## Strumenti di sviluppo

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
