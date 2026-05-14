# AppBoard

**語言**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe 移除了 Launchpad，新的 Apps 無法滿足使用者的需求，也無法充分利用電腦的 Bio GPU。但 Apple 並未提供回退選項，AppBoard 試圖解決這個問題。

*AppBoard 基於 [LaunchNext](https://github.com/RoversX/LaunchNext) 與 [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) 開發，非常感謝原專案！*

*LaunchNext 與 LaunchNow 皆採用 GPL 3 授權，AppBoard 也遵循相同的授權條款。*

⭐ 歡迎為 [LaunchNext](https://github.com/RoversX/LaunchNext) 與原專案 [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) 加星！


## AppBoard 提供什麼
- ✅ **與舊系統 LaunchPad 一致的使用者體驗** - 盡可能還原並實作了舊系統中 LaunchPad 的使用者體驗，包含長按 App 抖動與刪除管理、拖曳合併同類型 App 至資料夾等等。
- ✅ **一鍵匯入舊系統 LaunchPad** - 直接讀取你原生 Launchpad 的 SQLite 資料庫，重建資料夾、應用位置與佈局
- ✅ **手動整理應用** - 移動應用、建立資料夾，並依你的方式保留佈局
- ✅ **兩套渲染路徑** - `Legacy Engine` 強調相容性，`Next Engine + Core Animation` 提供最佳體驗
- ✅ **緊湊與全螢幕模式** - 支援分別儲存設定
- ✅ **鍵盤優先工作流程** - 快速搜尋、導覽與啟動
- ✅ **Hot Corner 與原生手勢啟動** - 提供多種全域開啟方式
- ✅ **直接拖曳應用到 Dock** - 在 Core Animation 引擎中可用
- ✅ **支援 Markdown 發行說明的更新中心** - 更豐富的應用內更新體驗
- ✅ **備份與還原工具** - 更安全的匯出與還原流程
- ✅ **無障礙與控制器支援** - 語音回饋與遊戲手把導覽皆有強化
- ✅ **多語系支援** - 介面語言覆蓋廣泛

## macOS Tahoe 拿走了什麼

- ❌ 無法自訂應用整理
- ❌ 無法建立使用者資料夾
- ❌ 無拖曳自訂功能
- ❌ 無視覺化應用管理
- ❌ 強制分類分組

## 資料儲存

應用資料儲存在：

```text
~/Library/Application Support/AppBoard/Data.store
```

## 原生 Launchpad 整合

AppBoard 可直接讀取系統 Launchpad 資料庫：

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## 安裝

### 系統需求

- macOS 26（Tahoe）或更新版本
- Apple Silicon 或 Intel 處理器
- Xcode 26（從原始碼建置時需要）

### 從原始碼建置

1. **複製儲存庫**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **在 Xcode 開啟**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **建置並執行**
   - 選擇目標裝置
   - 按 `⌘+R` 建置並執行
   - 或按 `⌘+B` 僅建置

### 命令列建置

建置分兩步：先確認 SwiftUpdater 已建置過（首次或清理後才需要），然後再建置主 App。

**1. 一次性預先建置 SwiftUpdater**

首次拉取程式碼，或刪除過 UpdaterScripts/SwiftUpdater/.build/ 之後才需要執行一次：

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
產物位於 `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`，主 `App` 的 `Run Script Phase` 會自動複製它。

**2. 建置主 App：**
- Debug 建置（日常）：
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
產物：`~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release 建置：
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- 發行打包（Release + zip + checksum）：
```bash
./scripts/release.sh
```

這個指令會做 `clean build` 跑 `Release`，並把 `AppBoard.app` 打包成 `AppBoard<版本號>.zip` 放到 `Build/dist/`，並產生 `checksums.txt`。

- 直接在 Xcode 建置
打開 `AppBoard.xcodeproj`，`Cmd+B` 建置，`Cmd+R` 執行。`Xcode` 會自動採用 `AppBoard scheme`。`SwiftUpdater` 仍需先用上面那條指令手動執行一次。

**3. 通用二進位建置（Intel + Apple Silicon）：**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## 使用方式

### 快速開始

1. AppBoard 首次啟動時會掃描所有已安裝應用
2. 匯入舊版 Launchpad 佈局，或從空白佈局開始
3. 透過搜尋、鍵盤導覽、滑鼠拖曳與資料夾整理應用
4. 在設定中設定引擎、佈局模式、啟動方式與自動化功能

### 匯入你的 Launchpad

1. 開啟設定
2. 點選 **Import Launchpad**
3. 現有的佈局與資料夾會自動匯入

### 引擎與佈局模式

- **Legacy Engine** - 保留舊渲染路徑，優先相容性
- **Next Engine + Core Animation** - 推薦，整體體驗與新功能支援較佳
- **緊湊 / 全螢幕** - AppBoard 支援兩種模式並可分別儲存設定

## 主要功能

### 啟動與輸入

- **Hot Corner 支援** - 從可設定的螢幕角落開啟 AppBoard
- **實驗性原生手勢支援** - 四指 pinch / tap 動作
- **全域捷徑支援** - 從任何位置開啟 AppBoard
- **拖曳應用到 Dock** - 在 Core Animation 引擎中將應用直接交給 macOS Dock

### 更新體驗

- **應用內更新中心** - 不離開應用即可檢查更新
- **Markdown 發行說明** - 在設定中直接顯示更豐富的發行說明
- **新版通知 API** - 適配更新後的 macOS 通知機制

### 備份與還原

- 在設定中建立與還原備份
- 更可靠的備份匯出行為
- 更安全的暫存檔處理與清理邏輯

### 無障礙與導覽

- **語音回饋** - 導覽時播報應用與資料夾名稱
- **控制器支援** - 可用遊戲手把操作 AppBoard 與資料夾
- **鍵盤優先互動** - 不依賴滑鼠也能快速搜尋與導覽

## 效能與穩定性

- 智慧型圖示快取，保證瀏覽流暢
- 延遲載入與背景掃描，適合大型應用程式庫
- 更佳的設定與導覽狀態同步
- 更新處理、備份匯出與手勢回復的可靠性提升


## 貢獻

歡迎貢獻。

1. Fork 儲存庫
2. 建立功能分支（`git checkout -b feature/amazing-feature`）
3. 提交變更（`git commit -m 'Add amazing feature'`）
4. 推送分支（`git push origin feature/amazing-feature`）
5. 開啟 Pull Request

### 開發守則

- 遵循 Swift 風格約定
- 為複雜邏輯加上有意義的註解
- 盡可能在多個 macOS 版本上測試
- 避免將實驗性功能散落於無關檔案
- 盡量隔離可移除的整合

## 應用程式管理的未來

隨著 Apple 逐漸遠離可自訂的應用啟動介面，AppBoard 試圖在現代 macOS 上保留手動整理、使用者控制與高效存取。

**AppBoard** 不只是 Launchpad 的替代品，而是對工作流退化的一種務實回應。

---

**AppBoard** - 重新掌控你的應用啟動器 🚀

*為拒絕在自訂上妥協的 macOS 使用者打造。*

## 開發工具

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
