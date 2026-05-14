# AppBoard

**言語**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe で Launchpad が削除され、新しい Apps はユーザーのニーズを満たさず、Mac の Bio GPU も活かしきれません。しかし Apple は元に戻す選択肢を用意していません。AppBoard はこの問題に応えます。

*AppBoard は [LaunchNext](https://github.com/RoversX/LaunchNext) と [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) をベースに開発されています。原プロジェクトに心より感謝します！*

*LaunchNext と LaunchNow は共に GPL 3 ライセンスを採用しており、AppBoard も同じライセンス条件に従います。*

⭐ [LaunchNext](https://github.com/RoversX/LaunchNext) と原プロジェクト [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) にもぜひスターをお願いします！


## AppBoard が提供するもの
- ✅ **旧 LaunchPad と同等のユーザー体験** - 長押しでアイコンを揺らして削除管理、同種アプリをフォルダにドラッグしてまとめるなど、旧 LaunchPad の体験を可能な限り再現しています。
- ✅ **旧 LaunchPad からのワンクリック取り込み** - ネイティブ Launchpad の SQLite データベースを直接読み込み、フォルダ・アプリ位置・レイアウトを再構築
- ✅ **手動でのアプリ整理** - アプリを移動し、フォルダを作成し、好みのレイアウトを保持
- ✅ **2 系統のレンダリング** - 互換性重視の `Legacy Engine`、最良体験の `Next Engine + Core Animation`
- ✅ **コンパクトとフルスクリーンの両モード** - それぞれ別々の設定を保存
- ✅ **キーボードファーストなワークフロー** - 高速検索・ナビゲーション・起動
- ✅ **Hot Corner とネイティブジェスチャ起動** - 複数のグローバル起動経路
- ✅ **アプリを直接 Dock へドラッグ** - Core Animation エンジンで利用可能
- ✅ **Markdown リリースノート対応の更新ハブ** - アプリ内でリッチな更新体験
- ✅ **バックアップ・復元ツール** - より安全なエクスポートと復元
- ✅ **アクセシビリティとコントローラー対応** - 音声フィードバックとゲームパッド操作を強化
- ✅ **多言語対応** - 幅広い UI 言語をカバー

## macOS Tahoe が奪ったもの

- ❌ アプリ整理のカスタマイズ不可
- ❌ ユーザーフォルダの作成不可
- ❌ ドラッグ＆ドロップによるカスタマイズ不可
- ❌ 視覚的なアプリ管理不可
- ❌ 強制的なカテゴリーグループ化

## データの保存場所

アプリのデータは次の場所に保存されます：

```text
~/Library/Application Support/AppBoard/Data.store
```

## ネイティブ Launchpad との統合

AppBoard はシステムの Launchpad データベースを直接読み込めます：

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## インストール

### 動作環境

- macOS 26（Tahoe）以降
- Apple Silicon または Intel プロセッサ
- Xcode 26（ソースからビルドする場合）

### ソースからビルド

1. **リポジトリをクローン**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Xcode で開く**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **ビルドして実行**
   - ターゲットデバイスを選択
   - `⌘+R` でビルド＆実行
   - `⌘+B` でビルドのみ

### コマンドラインビルド

ビルドは 2 段階に分かれます。まず SwiftUpdater がビルド済みであることを確認し（初回またはクリーン後のみ必要）、そのあと本体アプリをビルドします。

**1. SwiftUpdater の事前ビルド（1 回のみ）**

初回チェックアウト、または UpdaterScripts/SwiftUpdater/.build/ を削除した後だけ実行してください：

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
成果物は `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater` に出力され、本体 `App` の `Run Script Phase` が自動的にコピーします。

**2. 本体アプリのビルド：**
- Debug ビルド（日常）：
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
成果物：`~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release ビルド：
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- リリース用パッケージング（Release + zip + checksum）：
```bash
./scripts/release.sh
```

このスクリプトは `clean build` で `Release` を実行し、`AppBoard.app` を `AppBoard<バージョン>.zip` として `Build/dist/` に出力し、`checksums.txt` も生成します。

- Xcode で直接ビルド
`AppBoard.xcodeproj` を開き、`Cmd+B` でビルド、`Cmd+R` で実行。`Xcode` は自動で `AppBoard scheme` を使用します。`SwiftUpdater` は事前に上記コマンドで一度ビルドしておく必要があります。

**3. ユニバーサルバイナリのビルド（Intel + Apple Silicon）：**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## 使い方

### はじめに

1. AppBoard は初回起動時にインストール済みアプリをすべてスキャンします
2. 旧 Launchpad のレイアウトをインポートするか、空のレイアウトから始めます
3. 検索・キーボード操作・マウスドラッグ・フォルダでアプリを整理します
4. 設定でエンジン、レイアウトモード、起動方法、自動化機能を設定します

### Launchpad のインポート

1. 設定を開く
2. **Import Launchpad** をクリック
3. 既存のレイアウトとフォルダが自動的にインポートされます

### エンジンとレイアウトモード

- **Legacy Engine** - 旧レンダリングを保持し、互換性を優先
- **Next Engine + Core Animation** - 推奨。全体的な体験と新機能対応が良好
- **コンパクト / フルスクリーン** - AppBoard は両方をサポートし、設定を別々に保存できます

## 主な機能

### 起動と入力

- **Hot Corner 対応** - 設定可能な画面のコーナーから AppBoard を開く
- **実験的なネイティブジェスチャ対応** - 4 本指 pinch / tap 操作
- **グローバルショートカット対応** - どこからでも AppBoard を起動
- **アプリを Dock へドラッグ** - Core Animation エンジンで macOS Dock に直接ドラッグ可能

### 更新体験

- **アプリ内更新ハブ** - アプリを離れずに更新を確認
- **Markdown 形式のリリースノート** - 設定で直接、リッチな内容を表示
- **モダンな通知 API** - 最新の macOS 通知システムに対応

### バックアップと復元

- 設定からバックアップの作成・復元
- より信頼性の高いバックアップエクスポート
- 一時ファイルとクリーンアップ処理がより安全

### アクセシビリティとナビゲーション

- **音声フィードバック** - ナビゲーション中にアプリ名・フォルダ名を読み上げ
- **コントローラー対応** - ゲームパッドで AppBoard とフォルダを操作
- **キーボードファーストな操作** - マウスに頼らず素早く検索・操作

## パフォーマンスと安定性

- 賢いアイコンキャッシュで滑らかなブラウジング
- 大規模なアプリライブラリ向けの遅延読み込みとバックグラウンドスキャン
- 設定とナビゲーションの状態同期を改善
- 更新処理、バックアップエクスポート、ジェスチャ回復の信頼性向上


## コントリビュート

コントリビュートを歓迎します。

1. リポジトリを Fork
2. 機能ブランチを作成（`git checkout -b feature/amazing-feature`）
3. 変更をコミット（`git commit -m 'Add amazing feature'`）
4. ブランチを Push（`git push origin feature/amazing-feature`）
5. Pull Request を開く

### 開発ガイドライン

- Swift のスタイル規約に従う
- 複雑なロジックには意味のあるコメントを追加
- 可能な限り複数の macOS バージョンでテスト
- 実験的な機能を無関係なファイルに散らさない
- 取り外し可能な統合は分離して保つ

## アプリ管理の未来

Apple がカスタマイズ可能な起動画面から離れていく中、AppBoard はモダンな macOS 上で手動整理、ユーザー制御、効率的なアクセスを保つことを目指します。

**AppBoard** は単なる Launchpad の代替ではなく、ワークフロー退化に対する現実的な答えです。

---

**AppBoard** - あなたのアプリランチャーを取り戻そう 🚀

*カスタマイズの妥協を拒む macOS ユーザーのために。*

## 開発ツール

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
