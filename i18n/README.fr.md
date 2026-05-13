# AppBoard

**Langues**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe a supprimé Launchpad, la nouvelle expérience Apps ne répond pas aux besoins des utilisateurs et n'exploite pas le Bio GPU du Mac. Pourtant Apple n'offre aucune option de retour en arrière. AppBoard tente de résoudre ce problème.

*AppBoard est construit à partir de [LaunchNext](https://github.com/RoversX/LaunchNext) et [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) (auteur : ggkevinnnn) — un grand merci aux projets originaux ! ❤️*

*LaunchNext et LaunchNow sont tous deux sous licence GPL 3, et AppBoard suit les mêmes conditions de licence.*

⭐ Pensez à mettre une étoile à [LaunchNext](https://github.com/RoversX/LaunchNext) et au projet d'origine [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) !


## Ce que propose AppBoard
- ✅ **Expérience fidèle à l'ancien LaunchPad** - Nous avons recréé au maximum l'expérience de l'ancien LaunchPad, y compris le maintien long pour faire trembler les icônes, la gestion des suppressions, et le glisser-déposer pour regrouper les apps similaires dans un dossier.
- ✅ **Import en un clic depuis l'ancien LaunchPad** - Lit directement votre base SQLite native Launchpad pour reconstituer dossiers, positions et mises en page
- ✅ **Organisation manuelle des apps** - Déplacez les apps, créez des dossiers, conservez votre mise en page comme vous le souhaitez
- ✅ **Deux moteurs de rendu** - `Legacy Engine` pour la compatibilité, `Next Engine + Core Animation` pour la meilleure expérience
- ✅ **Modes Compact et Plein écran** - Réglages sauvegardés séparément
- ✅ **Workflow centré clavier** - Recherche, navigation et lancement rapides
- ✅ **Hot Corner et gestes natifs** - Plusieurs points d'entrée globaux
- ✅ **Glisser des apps directement vers le Dock** - Disponible dans le moteur Core Animation
- ✅ **Centre de mises à jour avec notes en Markdown** - Une expérience de mise à jour intégrée plus riche
- ✅ **Outils de sauvegarde et restauration** - Export et restauration plus sûrs
- ✅ **Accessibilité et support de manettes** - Retour vocal et navigation manette améliorés
- ✅ **Localisation étendue** - Large couverture linguistique

## Ce que macOS Tahoe a retiré

- ❌ Plus d'organisation personnalisée des apps
- ❌ Plus de dossiers créés par l'utilisateur
- ❌ Plus de personnalisation par glisser-déposer
- ❌ Plus de gestion visuelle des apps
- ❌ Regroupement par catégorie imposé

## Stockage des données

Les données de l'application sont enregistrées dans :

```text
~/Library/Application Support/AppBoard/Data.store
```

## Intégration Launchpad natif

AppBoard peut lire directement la base de données Launchpad du système :

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## Installation

### Prérequis système

- macOS 26 (Tahoe) ou ultérieur
- Processeur Apple Silicon ou Intel
- Xcode 26 (pour compiler depuis les sources)

### Compiler depuis les sources

1. **Cloner le dépôt**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Ouvrir dans Xcode**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **Compiler et exécuter**
   - Sélectionnez l'appareil cible
   - Appuyez sur `⌘+R` pour compiler et lancer
   - Ou `⌘+B` pour compiler uniquement

### Compilation en ligne de commande

La compilation se fait en deux étapes : d'abord s'assurer que SwiftUpdater a été compilé (uniquement à la première compilation ou après un clean), puis compiler l'app principale.

**1. Pré-compilation unique de SwiftUpdater**

Nécessaire seulement à la première récupération du code, ou après suppression de UpdaterScripts/SwiftUpdater/.build/ :

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
Le binaire est produit dans `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`, et la `Run Script Phase` de l'`App` principale le copie automatiquement.

**2. Compiler l'app principale :**
- Build Debug (quotidien) :
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
Produit : `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Build Release :
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- Packaging de release (Release + zip + checksum) :
```bash
./scripts/release.sh
```

Ce script exécute un `clean build` en `Release`, puis zippe `AppBoard.app` sous le nom `AppBoard<version>.zip` dans `Build/dist/`, et produit `checksums.txt`.

- Compiler directement dans Xcode
Ouvrez `AppBoard.xcodeproj`, `Cmd+B` pour compiler, `Cmd+R` pour exécuter. `Xcode` utilise automatiquement le `AppBoard scheme`. Il faut quand même lancer `SwiftUpdater` une fois avec la commande ci-dessus.

**3. Build universel (Intel + Apple Silicon) :**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## Utilisation

### Démarrage rapide

1. AppBoard scanne toutes les apps installées au premier lancement
2. Importez la disposition de votre ancien Launchpad, ou partez d'un layout vide
3. Organisez vos apps via la recherche, le clavier, la souris et les dossiers
4. Configurez le moteur, le mode de mise en page, l'activation et l'automatisation dans Réglages

### Importer votre Launchpad

1. Ouvrez Réglages
2. Cliquez sur **Import Launchpad**
3. Votre mise en page et vos dossiers existants sont importés automatiquement

### Moteurs et modes de mise en page

- **Legacy Engine** - Conserve l'ancien rendu, privilégie la compatibilité
- **Next Engine + Core Animation** - Recommandé. Meilleure expérience générale et meilleur support des nouvelles fonctionnalités
- **Compact / Plein écran** - AppBoard prend en charge les deux modes et conserve leurs réglages séparément

## Fonctionnalités clés

### Activation et saisie

- **Support Hot Corner** - Ouvrir AppBoard depuis un coin d'écran configurable
- **Support expérimental des gestes natifs** - Pinch / tap à quatre doigts
- **Raccourcis globaux** - Ouvrir AppBoard depuis n'importe où
- **Glisser une app vers le Dock** - Dans le moteur Core Animation, l'app passe directement au Dock macOS

### Expérience de mise à jour

- **Hub de mise à jour intégré** - Vérifiez les mises à jour sans quitter l'app
- **Notes de version en Markdown** - Affichage enrichi directement dans Réglages
- **API de notifications moderne** - Compatible avec le système macOS mis à jour

### Sauvegarde et restauration

- Créez et restaurez des sauvegardes depuis Réglages
- Comportement d'export de sauvegarde plus fiable
- Gestion plus sûre des fichiers temporaires et du nettoyage

### Accessibilité et navigation

- **Retour vocal** - Annonce des noms d'apps et de dossiers pendant la navigation
- **Support manette** - Utilisation d'une manette pour AppBoard et les dossiers
- **Interaction centrée clavier** - Recherche et navigation sans avoir à utiliser la souris

## Performances et stabilité

- Cache d'icônes intelligent pour une navigation fluide
- Chargement paresseux et scan en arrière-plan pour les grandes bibliothèques d'apps
- Meilleure synchronisation de l'état des Réglages et de la navigation
- Fiabilité accrue pour la mise à jour, l'export de sauvegarde et la récupération des gestes


## Contribuer

Les contributions sont les bienvenues.

1. Forker le dépôt
2. Créer une branche de fonctionnalité (`git checkout -b feature/amazing-feature`)
3. Committer vos changements (`git commit -m 'Add amazing feature'`)
4. Pousser la branche (`git push origin feature/amazing-feature`)
5. Ouvrir une Pull Request

### Lignes directrices de développement

- Respecter les conventions de style Swift
- Ajouter des commentaires utiles pour la logique complexe
- Tester sur plusieurs versions de macOS quand c'est possible
- Éviter de disséminer les fonctionnalités expérimentales dans des fichiers non liés
- Isoler les intégrations amovibles

## L'avenir de la gestion d'apps

Alors qu'Apple s'éloigne des lanceurs d'apps personnalisables, AppBoard s'attache à préserver l'organisation manuelle, le contrôle utilisateur et l'accès efficace sur le macOS moderne.

**AppBoard** est plus qu'un remplacement de Launchpad — c'est une réponse pragmatique à la régression du workflow.

---

**AppBoard** - Reprenez le contrôle de votre lanceur d'apps 🚀

*Conçu pour les utilisateurs macOS qui refusent de transiger sur la personnalisation.*

## Outils de développement

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
