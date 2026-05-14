# AppBoard

**언어**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe에서 Launchpad가 제거되었고, 새로운 Apps는 사용자 요구를 충족하지 못하며 Mac의 Bio GPU도 충분히 활용하지 못합니다. 그런데 Apple은 되돌릴 옵션을 제공하지 않습니다. AppBoard는 이 문제를 해결하려고 합니다.

*AppBoard는 [LaunchNext](https://github.com/RoversX/LaunchNext)와 [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)를 기반으로 개발되었습니다. 원본 프로젝트에 깊이 감사드립니다!*

*LaunchNext와 LaunchNow 모두 GPL 3 라이선스를 채택하고 있으며, AppBoard 역시 동일한 라이선스 조건을 따릅니다.*

⭐ [LaunchNext](https://github.com/RoversX/LaunchNext)와 원본 프로젝트 [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)에도 별을 눌러 주세요!


## AppBoard가 제공하는 것
- ✅ **이전 LaunchPad와 동일한 사용자 경험** - 길게 눌러 흔들기/삭제 관리, 같은 종류의 앱을 폴더로 드래그해 합치기 등 이전 LaunchPad 경험을 최대한 재현했습니다.
- ✅ **이전 LaunchPad 원클릭 가져오기** - 네이티브 Launchpad SQLite 데이터베이스를 직접 읽어 폴더, 앱 위치, 레이아웃을 재구성
- ✅ **수동 앱 정리** - 앱을 이동하고 폴더를 만들고, 원하는 방식으로 레이아웃을 유지
- ✅ **두 가지 렌더링 경로** - 호환성을 우선하는 `Legacy Engine`과 최고의 경험을 제공하는 `Next Engine + Core Animation`
- ✅ **컴팩트 및 전체 화면 모드** - 각각 별도의 설정 저장 지원
- ✅ **키보드 우선 워크플로** - 빠른 검색, 탐색, 실행
- ✅ **Hot Corner 및 네이티브 제스처 활성화** - 다양한 전역 진입 경로
- ✅ **앱을 Dock으로 직접 드래그** - Core Animation 엔진에서 사용 가능
- ✅ **Markdown 릴리스 노트 지원 업데이트 허브** - 더 풍부한 인앱 업데이트 경험
- ✅ **백업 및 복원 도구** - 더 안전한 내보내기/복원 흐름
- ✅ **접근성 및 컨트롤러 지원** - 음성 피드백과 게임패드 탐색이 강화됨
- ✅ **다국어 지원** - 폭넓은 UI 언어 커버리지

## macOS Tahoe가 가져간 것

- ❌ 앱 정리 커스터마이즈 불가
- ❌ 사용자 폴더 생성 불가
- ❌ 드래그 앤 드롭 커스터마이즈 불가
- ❌ 시각적 앱 관리 불가
- ❌ 강제 카테고리 그룹화

## 데이터 저장 위치

앱 데이터는 다음 경로에 저장됩니다:

```text
~/Library/Application Support/AppBoard/Data.store
```

## 네이티브 Launchpad 통합

AppBoard는 시스템 Launchpad 데이터베이스를 직접 읽을 수 있습니다:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## 설치

### 시스템 요구 사항

- macOS 26(Tahoe) 이상
- Apple Silicon 또는 Intel 프로세서
- Xcode 26(소스에서 빌드할 때 필요)

### 소스에서 빌드

1. **저장소 복제**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Xcode에서 열기**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **빌드 및 실행**
   - 대상 기기 선택
   - `⌘+R`로 빌드 및 실행
   - 또는 `⌘+B`로 빌드만 수행

### 명령줄 빌드

빌드는 두 단계로 나뉩니다. 먼저 SwiftUpdater가 빌드되어 있는지 확인하고(최초 빌드 또는 클린 후에만 필요), 그다음 본체 앱을 빌드합니다.

**1. SwiftUpdater 사전 빌드(한 번만)**

저장소를 처음 받았거나 UpdaterScripts/SwiftUpdater/.build/ 를 삭제한 후에만 실행하면 됩니다:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
산출물은 `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`에 생성되고, 본체 `App`의 `Run Script Phase`가 자동으로 복사합니다.

**2. 본체 앱 빌드:**
- Debug 빌드(일상):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
산출물: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release 빌드:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- 릴리스 패키징(Release + zip + checksum):
```bash
./scripts/release.sh
```

이 스크립트는 `Release`로 `clean build`를 실행한 뒤 `AppBoard.app`을 `AppBoard<버전>.zip`으로 `Build/dist/`에 저장하고, `checksums.txt`도 생성합니다.

- Xcode에서 직접 빌드
`AppBoard.xcodeproj`를 열고 `Cmd+B`로 빌드, `Cmd+R`로 실행하세요. `Xcode`는 자동으로 `AppBoard scheme`을 사용합니다. `SwiftUpdater`는 위 명령으로 미리 한 번 빌드해 둬야 합니다.

**3. 유니버설 바이너리 빌드(Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## 사용법

### 시작하기

1. AppBoard는 처음 실행 시 설치된 모든 앱을 스캔합니다
2. 이전 Launchpad 레이아웃을 가져오거나 빈 레이아웃에서 시작하세요
3. 검색, 키보드 탐색, 마우스 드래그, 폴더로 앱을 정리하세요
4. 설정에서 엔진, 레이아웃 모드, 활성화 방식, 자동화 기능을 구성하세요

### Launchpad 가져오기

1. 설정 열기
2. **Import Launchpad** 클릭
3. 기존 레이아웃과 폴더가 자동으로 가져와집니다

### 엔진 및 레이아웃 모드

- **Legacy Engine** - 호환성을 우선하는 기존 렌더링 경로 유지
- **Next Engine + Core Animation** - 권장. 전반적인 경험과 신규 기능 지원이 우수
- **컴팩트 / 전체 화면** - AppBoard는 두 모드를 모두 지원하며 설정을 따로 저장합니다

## 주요 기능

### 활성화 및 입력

- **Hot Corner 지원** - 구성 가능한 화면 코너에서 AppBoard 열기
- **실험적 네이티브 제스처 지원** - 네 손가락 pinch / tap 동작
- **글로벌 단축키 지원** - 어디서든 AppBoard 열기
- **앱을 Dock으로 드래그** - Core Animation 엔진에서 macOS Dock으로 직접 전달

### 업데이트 경험

- **인앱 업데이트 허브** - 앱을 벗어나지 않고 업데이트 확인
- **Markdown 릴리스 노트** - 설정에서 풍부한 릴리스 노트를 직접 표시
- **최신 알림 API** - 업데이트된 macOS 알림 시스템에 대응

### 백업 및 복원

- 설정에서 백업 생성 및 복원
- 더 안정적인 백업 내보내기 동작
- 임시 파일 처리 및 정리 로직이 더 안전함

### 접근성 및 탐색

- **음성 피드백** - 탐색 시 앱 및 폴더 이름을 읽어줌
- **컨트롤러 지원** - 게임패드로 AppBoard와 폴더를 조작
- **키보드 우선 상호작용** - 마우스 없이 빠르게 검색 및 탐색

## 성능 및 안정성

- 부드러운 탐색을 위한 스마트 아이콘 캐싱
- 대규모 앱 라이브러리를 위한 지연 로딩과 백그라운드 스캐닝
- 설정과 탐색 상태 동기화 개선
- 업데이트 처리, 백업 내보내기, 제스처 복구의 신뢰성 향상


## 기여

기여를 환영합니다.

1. 저장소 Fork
2. 기능 브랜치 생성(`git checkout -b feature/amazing-feature`)
3. 변경 사항 커밋(`git commit -m 'Add amazing feature'`)
4. 브랜치 Push(`git push origin feature/amazing-feature`)
5. Pull Request 열기

### 개발 지침

- Swift 스타일 가이드를 따르기
- 복잡한 로직에는 의미 있는 주석 추가
- 가능한 한 여러 macOS 버전에서 테스트
- 실험적 기능을 관련 없는 파일에 분산시키지 않기
- 제거 가능한 통합은 분리해서 유지

## 앱 관리의 미래

Apple이 커스터마이즈 가능한 앱 런처에서 멀어지는 가운데, AppBoard는 현대적인 macOS에서 수동 정리, 사용자 제어, 효율적인 접근을 지키기 위해 노력합니다.

**AppBoard**는 단순한 Launchpad 대체품이 아니라 워크플로 퇴보에 대한 현실적인 답입니다.

---

**AppBoard** - 당신의 앱 런처를 되찾으세요 🚀

*커스터마이즈에서 타협하지 않는 macOS 사용자를 위해.*

## 개발 도구

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
