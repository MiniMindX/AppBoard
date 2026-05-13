# AppBoard

**语言**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe 移除了 Launchpad，新的Apps不能满足用户的需求，也不能充分利用电脑的 Bio GPU。但是苹果并没有给出回退的选项。AppBoard试图解决这个问题。

*AppBoard基于 [LaunchNext](https://github.com/RoversX/LaunchNext) 和 [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)（作者 ggkevinnnn）开发——非常感谢原项目！❤️*

*LaunchNext和LaunchNow 均选择了 GPL 3 许可证，AppBoard 也遵循相同的许可条款。*

⭐ 请考虑为 [LaunchNext](https://github.com/RoversX/LaunchNext) 和原项目 [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) 点 star！


## AppBoard 提供什么
- ✅ **与旧系统 LaunchPad 一致的用户体验** - 我们尽可能还原和实现了旧系统中LaunchPad的用户体验，包括长按App抖动和删除管理、拖拽合并同类型App到某个文件夹等等。
- ✅ **一键导入旧系统 LaunchPad** - 直接读取你的原生 Launchpad SQLite 数据库，重建文件夹、应用位置和布局
- ✅ **手动整理应用** - 移动应用、创建文件夹，并按你的方式保留布局
- ✅ **两套渲染路径** - `Legacy Engine` 用于兼容性，`Next Engine + Core Animation` 提供最佳体验
- ✅ **紧凑和全屏模式** - 支持分别保存设置
- ✅ **键盘优先工作流** - 快速搜索、导航与启动
- ✅ **Hot Corner 与原生手势激活** - 提供多种全局打开方式
- ✅ **直接拖动应用到 Dock** - 在 Core Animation 引擎中可用
- ✅ **支持 Markdown 发布说明的更新中心** - 更丰富的应用内更新体验
- ✅ **备份与恢复工具** - 更安全的导出与恢复流程
- ✅ **可访问性与控制器支持** - 语音反馈和手柄导航都有增强
- ✅ **多语言支持** - 覆盖较广的本地化语言

## macOS Tahoe 拿走了什么

- ❌ 无法自定义应用组织
- ❌ 无法创建用户文件夹
- ❌ 无拖拽定制功能
- ❌ 无可视化应用管理
- ❌ 强制分类分组

## 数据存储

应用数据保存在：

```text
~/Library/Application Support/AppBoard/Data.store
```

## 原生 Launchpad 集成

AppBoard 可以直接读取系统 Launchpad 数据库：

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## 安装

### 系统要求

- macOS 26（Tahoe）或更高版本
- Apple Silicon 或 Intel 处理器
- Xcode 26（从源码构建时需要）

### 从源码构建

1. **克隆仓库**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **在 Xcode 中打开**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **构建并运行**
   - 选择目标设备
   - 按 `⌘+R` 构建并运行
   - 或按 `⌘+B` 仅构建

### 命令行构建

构建分两步：先确保 SwiftUpdater 已经构建过（首次或清理后才需要），然后构建主 App。

**1. 一次性预构建 SwiftUpdater**

首次拉代码、或者删过 UpdaterScripts/SwiftUpdater/.build/ 之后才需要执行一次：

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
跑完产物在 `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`，主 `App` 的 `Run Script Phase` 会自动拷贝它。

**2. 构建主 App：**
- Debug 构建（日常）：
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
产物：`~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release 构建：
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- 发布打包（Release + zip + checksum）：
```bash
./scripts/release.sh
```

这个脚本会做 `clean build` 跑 `Release`，再把 `AppBoard.app` 打成 `AppBoard<版本号>.zip` 放到 `Build/dist/`，并生成 `checksums.txt`。

- Xcode 里直接构建
直接打开 `AppBoard.xcodeproj`，`Cmd+B` 构建, `Cmd+R` 运行。`Xcode` 会自动用 `AppBoard scheme`。`SwiftUpdater` 还是要先按上面那条命令手工跑一次。

**3. 通用二进制构建（Intel + Apple Silicon）：**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## 使用方法

### 快速开始

1. AppBoard 首次启动时会扫描所有已安装应用
2. 导入旧 Launchpad 布局，或从空布局开始
3. 通过搜索、键盘导航、鼠标拖拽和文件夹整理应用
4. 在设置中配置引擎、布局模式、激活方式和自动化功能

### 导入你的 Launchpad

1. 打开设置
2. 点击 **Import Launchpad**
3. 现有布局和文件夹会自动导入

### 引擎与布局模式

- **Legacy Engine** - 保留旧渲染路径，优先兼容性
- **Next Engine + Core Animation** - 推荐，整体体验和新功能支持更好
- **紧凑 / 全屏** - AppBoard 支持两种模式，并可分别保存设置

## 关键功能

### 激活与输入

- **Hot Corner 支持** - 从可配置的屏幕角落打开 AppBoard
- **实验性原生手势支持** - 四指 pinch / tap 动作
- **全局快捷键支持** - 从任何位置打开 AppBoard
- **拖动应用到 Dock** - 在 Core Animation 引擎中将应用直接交给 macOS Dock

### 更新体验

- **应用内更新中心** - 不离开应用即可检查更新
- **Markdown 发布说明** - 在设置中直接显示更丰富的发布说明
- **现代通知 API** - 适配更新后的 macOS 通知机制

### 备份与恢复

- 在设置中创建和恢复备份
- 更可靠的备份导出行为
- 更安全的临时文件和清理逻辑处理

### 可访问性与导航

- **语音反馈支持** - 导航时播报应用和文件夹名称
- **控制器支持** - 可用游戏手柄操作 AppBoard 和文件夹
- **键盘优先交互** - 不依赖鼠标也能快速搜索和导航

## 性能与稳定性

- 智能图标缓存，保证浏览流畅
- 延迟加载和后台扫描，适配大型应用库
- 更好的设置和导航状态同步
- 更新处理、备份导出和手势恢复的可靠性提升


## 贡献

欢迎贡献。

1. Fork 仓库
2. 创建功能分支（`git checkout -b feature/amazing-feature`）
3. 提交更改（`git commit -m 'Add amazing feature'`）
4. 推送分支（`git push origin feature/amazing-feature`）
5. 打开 Pull Request

### 开发指南

- 遵循 Swift 风格约定
- 为复杂逻辑添加有意义的注释
- 尽可能在多个 macOS 版本上测试
- 避免把实验性功能散落到无关文件中
- 尽量隔离可移除的集成

## 应用管理的未来

随着 Apple 逐渐远离可自定义的应用启动界面，AppBoard 试图在现代 macOS 上保留手动组织、用户控制和高效访问。

**AppBoard** 不只是 Launchpad 的替代品，它是对工作流退化的一种实际回应。

---

**AppBoard** - 重新掌控你的应用启动器 🚀

*为拒绝在定制化上妥协的 macOS 用户打造。*

## 开发工具

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
