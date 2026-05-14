# AppBoard

**Idiomas**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe eliminó Launchpad, la nueva experiencia de Apps no satisface las necesidades del usuario ni aprovecha al máximo el Bio GPU del Mac. Sin embargo, Apple no ofrece una opción para volver atrás. AppBoard intenta resolver este problema.

*AppBoard está desarrollado a partir de [LaunchNext](https://github.com/RoversX/LaunchNext) y [LaunchNow](https://github.com/ggkevinnnn/LaunchNow), ¡muchas gracias a los proyectos originales!*

*Tanto LaunchNext como LaunchNow eligieron la licencia GPL 3, y AppBoard se rige por los mismos términos.*

⭐ ¡Considere darle estrella a [LaunchNext](https://github.com/RoversX/LaunchNext) y al proyecto original [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)!


## Lo que ofrece AppBoard
- ✅ **Experiencia idéntica al antiguo LaunchPad** - Hemos intentado replicar al máximo la experiencia del LaunchPad clásico: mantenimiento prolongado para hacer temblar los íconos y gestionar eliminaciones, arrastrar y soltar para combinar apps similares en una carpeta, y más.
- ✅ **Importación con un clic desde el antiguo LaunchPad** - Lee directamente la base SQLite nativa de Launchpad para reconstruir carpetas, posiciones y disposición
- ✅ **Organización manual de apps** - Mueva apps, cree carpetas y mantenga la disposición a su gusto
- ✅ **Dos rutas de renderizado** - `Legacy Engine` para compatibilidad, `Next Engine + Core Animation` para la mejor experiencia
- ✅ **Modos Compacto y Pantalla completa** - Ajustes guardados por separado
- ✅ **Flujo de trabajo centrado en el teclado** - Búsqueda, navegación y lanzamiento rápidos
- ✅ **Hot Corner y gestos nativos** - Múltiples vías globales de apertura
- ✅ **Arrastre apps directamente al Dock** - Disponible en el motor Core Animation
- ✅ **Centro de actualizaciones con notas en Markdown** - Experiencia de actualización más rica dentro de la app
- ✅ **Herramientas de copia de seguridad y restauración** - Exportación y restauración más seguras
- ✅ **Accesibilidad y soporte de mandos** - Realimentación por voz y navegación con gamepad mejoradas
- ✅ **Soporte multiidioma** - Amplia cobertura de localizaciones

## Lo que macOS Tahoe se llevó

- ❌ Sin organización personalizada de apps
- ❌ Sin carpetas creadas por el usuario
- ❌ Sin personalización mediante arrastrar y soltar
- ❌ Sin gestión visual de apps
- ❌ Agrupación por categorías forzada

## Almacenamiento de datos

Los datos de la aplicación se guardan en:

```text
~/Library/Application Support/AppBoard/Data.store
```

## Integración con Launchpad nativo

AppBoard puede leer directamente la base de datos del Launchpad del sistema:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## Instalación

### Requisitos del sistema

- macOS 26 (Tahoe) o superior
- Procesador Apple Silicon o Intel
- Xcode 26 (para compilar desde el código fuente)

### Compilar desde el código

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Abrir en Xcode**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **Compilar y ejecutar**
   - Seleccione el dispositivo de destino
   - Pulse `⌘+R` para compilar y ejecutar
   - O `⌘+B` para solo compilar

### Compilación por línea de comandos

La compilación es un proceso de dos pasos: primero asegúrese de que SwiftUpdater esté compilado (solo necesario en la primera compilación o tras un clean), y luego compile la app principal.

**1. Precompilación única de SwiftUpdater**

Solo es necesario al clonar por primera vez o tras eliminar UpdaterScripts/SwiftUpdater/.build/:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
El binario queda en `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`, y la `Run Script Phase` de la `App` principal lo copia automáticamente.

**2. Compilar la app principal:**
- Build Debug (día a día):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
Resultado: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Build Release:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- Empaquetado de release (Release + zip + checksum):
```bash
./scripts/release.sh
```

Este script ejecuta `clean build` en `Release`, comprime `AppBoard.app` como `AppBoard<versión>.zip` en `Build/dist/`, y genera `checksums.txt`.

- Compilar directamente desde Xcode
Abra `AppBoard.xcodeproj`, `Cmd+B` para compilar, `Cmd+R` para ejecutar. `Xcode` usará automáticamente el `AppBoard scheme`. Aun así debe compilar `SwiftUpdater` una vez con el comando anterior.

**3. Build universal (Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## Uso

### Primeros pasos

1. AppBoard analiza todas las apps instaladas en el primer arranque
2. Importe la disposición de su Launchpad antiguo o empiece con una vacía
3. Organice apps mediante búsqueda, teclado, arrastre con el ratón y carpetas
4. Configure motor, modo de disposición, activación y automatización en Ajustes

### Importar su Launchpad

1. Abra Ajustes
2. Haga clic en **Import Launchpad**
3. Su disposición y carpetas existentes se importan automáticamente

### Motores y modos de disposición

- **Legacy Engine** - Conserva la ruta de renderizado clásica, priorizando compatibilidad
- **Next Engine + Core Animation** - Recomendado. Mejor experiencia general y mejor soporte para nuevas funciones
- **Compacto / Pantalla completa** - AppBoard admite ambos modos y guarda sus ajustes por separado

## Funciones clave

### Activación y entrada

- **Soporte Hot Corner** - Abra AppBoard desde un rincón configurable de la pantalla
- **Soporte experimental de gestos nativos** - Pinch / tap con cuatro dedos
- **Atajos globales** - Abra AppBoard desde cualquier lugar
- **Arrastre apps al Dock** - En el motor Core Animation entrega la app directamente al Dock de macOS

### Experiencia de actualizaciones

- **Centro de actualización integrado** - Compruebe actualizaciones sin salir de la app
- **Notas de versión en Markdown** - Notas más ricas directamente en Ajustes
- **API de notificaciones moderna** - Compatible con el sistema de notificaciones actualizado de macOS

### Copias de seguridad y restauración

- Cree y restaure copias desde Ajustes
- Exportación de copias de seguridad más fiable
- Gestión más segura de archivos temporales y limpieza

### Accesibilidad y navegación

- **Realimentación por voz** - Anuncia nombres de apps y carpetas al navegar
- **Soporte de mandos** - Controle AppBoard y carpetas con un gamepad
- **Interacción centrada en teclado** - Busque y navegue sin necesidad de ratón

## Rendimiento y estabilidad

- Caché de íconos inteligente para una navegación fluida
- Carga diferida y escaneo en segundo plano para librerías grandes
- Mejor sincronización del estado de Ajustes y navegación
- Mayor fiabilidad en la gestión de actualizaciones, exportación de copias y recuperación de gestos


## Contribuir

Las contribuciones son bienvenidas.

1. Haga fork del repositorio
2. Cree una rama de funcionalidad (`git checkout -b feature/amazing-feature`)
3. Confirme los cambios (`git commit -m 'Add amazing feature'`)
4. Suba la rama (`git push origin feature/amazing-feature`)
5. Abra una Pull Request

### Pautas de desarrollo

- Siga las convenciones de estilo de Swift
- Añada comentarios significativos en la lógica compleja
- Pruebe en varias versiones de macOS cuando sea posible
- Evite dispersar funcionalidades experimentales en archivos no relacionados
- Mantenga aisladas las integraciones removibles

## El futuro de la gestión de apps

A medida que Apple se aleja de los lanzadores personalizables, AppBoard busca preservar la organización manual, el control del usuario y el acceso eficiente en el macOS moderno.

**AppBoard** no es solo un sustituto de Launchpad: es una respuesta pragmática a la regresión del flujo de trabajo.

---

**AppBoard** - Recupere el control de su lanzador de apps 🚀

*Pensado para usuarios de macOS que no aceptan ceder en personalización.*

## Herramientas de desarrollo

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
