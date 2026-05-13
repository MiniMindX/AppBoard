# AppBoard

**Ngôn ngữ**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe đã loại bỏ Launchpad, trải nghiệm Apps mới không đáp ứng nhu cầu người dùng và cũng không tận dụng Bio GPU của Mac. Tuy nhiên, Apple không cung cấp lựa chọn để quay lại. AppBoard cố gắng giải quyết vấn đề này.

*AppBoard được phát triển dựa trên [LaunchNext](https://github.com/RoversX/LaunchNext) và [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) (tác giả: ggkevinnnn) — chân thành cảm ơn các dự án gốc! ❤️*

*LaunchNext và LaunchNow đều chọn giấy phép GPL 3, AppBoard cũng tuân theo các điều khoản đó.*

⭐ Hãy gắn sao cho [LaunchNext](https://github.com/RoversX/LaunchNext) và dự án gốc [LaunchNow](https://github.com/ggkevinnnn/LaunchNow)!


## AppBoard cung cấp những gì
- ✅ **Trải nghiệm giống hệt LaunchPad cũ** - Chúng tôi cố gắng tái tạo trải nghiệm của LaunchPad cũ ở mức tối đa, gồm nhấn giữ để rung/quản lý xoá, kéo thả để gộp app cùng loại vào một thư mục và nhiều hơn nữa.
- ✅ **Nhập một-cú-nhấp từ LaunchPad cũ** - Đọc trực tiếp cơ sở dữ liệu SQLite Launchpad gốc để dựng lại thư mục, vị trí và bố cục
- ✅ **Sắp xếp app thủ công** - Di chuyển app, tạo thư mục và giữ bố cục theo ý bạn
- ✅ **Hai đường render** - `Legacy Engine` ưu tiên tương thích, `Next Engine + Core Animation` cho trải nghiệm tốt nhất
- ✅ **Chế độ Compact và Toàn màn hình** - Lưu cấu hình riêng biệt
- ✅ **Workflow ưu tiên bàn phím** - Tìm kiếm, điều hướng và mở app nhanh
- ✅ **Hot Corner và cử chỉ gốc** - Nhiều cách kích hoạt toàn cục
- ✅ **Kéo app trực tiếp vào Dock** - Khả dụng trong engine Core Animation
- ✅ **Trung tâm cập nhật với Markdown release notes** - Trải nghiệm cập nhật trong app phong phú hơn
- ✅ **Công cụ sao lưu và khôi phục** - Xuất và khôi phục an toàn hơn
- ✅ **Hỗ trợ trợ năng và tay cầm** - Phản hồi giọng nói và điều hướng tay cầm được nâng cấp
- ✅ **Hỗ trợ đa ngôn ngữ** - Phạm vi bản địa hoá rộng

## Những gì macOS Tahoe lấy đi

- ❌ Không thể tuỳ chỉnh cách sắp xếp app
- ❌ Không thể tạo thư mục người dùng
- ❌ Không có tuỳ chỉnh bằng kéo thả
- ❌ Không quản lý app bằng giao diện trực quan
- ❌ Buộc nhóm theo danh mục

## Lưu trữ dữ liệu

Dữ liệu ứng dụng được lưu tại:

```text
~/Library/Application Support/AppBoard/Data.store
```

## Tích hợp Launchpad gốc

AppBoard có thể đọc trực tiếp cơ sở dữ liệu Launchpad của hệ thống:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## Cài đặt

### Yêu cầu hệ thống

- macOS 26 (Tahoe) trở lên
- Bộ xử lý Apple Silicon hoặc Intel
- Xcode 26 (khi build từ mã nguồn)

### Build từ mã nguồn

1. **Clone repository**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Mở bằng Xcode**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **Build và chạy**
   - Chọn thiết bị đích
   - Nhấn `⌘+R` để build và chạy
   - Hoặc `⌘+B` để chỉ build

### Build qua dòng lệnh

Quá trình build có hai bước: trước tiên đảm bảo SwiftUpdater đã được build (chỉ cần lần đầu hoặc sau khi clean), sau đó build app chính.

**1. Build trước SwiftUpdater một lần**

Chỉ cần khi mới clone repo, hoặc sau khi xoá UpdaterScripts/SwiftUpdater/.build/:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
Kết quả nằm tại `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater`, `Run Script Phase` của `App` chính sẽ tự sao chép.

**2. Build app chính:**
- Build Debug (hằng ngày):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
Kết quả: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Build Release:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- Đóng gói phát hành (Release + zip + checksum):
```bash
./scripts/release.sh
```

Script này chạy `clean build` ở `Release`, sau đó nén `AppBoard.app` thành `AppBoard<phiên bản>.zip` tại `Build/dist/`, đồng thời tạo `checksums.txt`.

- Build trực tiếp trong Xcode
Mở `AppBoard.xcodeproj`, `Cmd+B` để build, `Cmd+R` để chạy. `Xcode` sẽ tự dùng `AppBoard scheme`. Vẫn cần chạy lệnh build `SwiftUpdater` ở trên một lần.

**3. Build universal (Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## Sử dụng

### Bắt đầu nhanh

1. AppBoard quét tất cả app đã cài khi khởi chạy lần đầu
2. Nhập bố cục Launchpad cũ hoặc bắt đầu với bố cục trống
3. Sắp xếp app qua tìm kiếm, bàn phím, kéo chuột và thư mục
4. Cấu hình engine, chế độ bố cục, cách kích hoạt và tự động hoá trong Cài đặt

### Nhập Launchpad của bạn

1. Mở Cài đặt
2. Bấm **Import Launchpad**
3. Bố cục và thư mục hiện có sẽ được nhập tự động

### Engine và chế độ bố cục

- **Legacy Engine** - Giữ đường render cũ, ưu tiên tương thích
- **Next Engine + Core Animation** - Khuyên dùng. Trải nghiệm tổng thể và hỗ trợ tính năng mới tốt hơn
- **Compact / Toàn màn hình** - AppBoard hỗ trợ cả hai và lưu cài đặt riêng

## Tính năng chính

### Kích hoạt và nhập liệu

- **Hỗ trợ Hot Corner** - Mở AppBoard từ góc màn hình có thể cấu hình
- **Hỗ trợ cử chỉ gốc thử nghiệm** - Pinch / tap bốn ngón
- **Phím tắt toàn cục** - Mở AppBoard từ mọi nơi
- **Kéo app vào Dock** - Trong engine Core Animation, app được giao thẳng vào Dock của macOS

### Trải nghiệm cập nhật

- **Trung tâm cập nhật trong app** - Kiểm tra cập nhật mà không rời app
- **Release notes dạng Markdown** - Hiển thị nội dung phong phú ngay trong Cài đặt
- **API thông báo hiện đại** - Tương thích với hệ thống thông báo macOS mới

### Sao lưu và khôi phục

- Tạo và khôi phục bản sao lưu trong Cài đặt
- Hành vi xuất bản sao lưu đáng tin cậy hơn
- Xử lý tệp tạm và dọn dẹp an toàn hơn

### Trợ năng và điều hướng

- **Phản hồi giọng nói** - Đọc tên app và thư mục khi điều hướng
- **Hỗ trợ tay cầm** - Điều khiển AppBoard và thư mục bằng gamepad
- **Tương tác ưu tiên bàn phím** - Tìm kiếm và điều hướng mà không cần chuột

## Hiệu năng và độ ổn định

- Bộ nhớ đệm biểu tượng thông minh giúp duyệt mượt
- Tải lười và quét nền cho thư viện app lớn
- Đồng bộ trạng thái Cài đặt và điều hướng tốt hơn
- Tăng độ tin cậy khi xử lý cập nhật, xuất sao lưu và phục hồi cử chỉ


## Đóng góp

Chào mừng mọi đóng góp.

1. Fork repository
2. Tạo nhánh tính năng (`git checkout -b feature/amazing-feature`)
3. Commit thay đổi (`git commit -m 'Add amazing feature'`)
4. Push nhánh (`git push origin feature/amazing-feature`)
5. Mở Pull Request

### Hướng dẫn phát triển

- Tuân theo quy ước phong cách Swift
- Thêm chú thích có ý nghĩa cho logic phức tạp
- Kiểm thử trên nhiều phiên bản macOS nếu có thể
- Tránh rải tính năng thử nghiệm vào các file không liên quan
- Cô lập các tích hợp có thể tháo gỡ

## Tương lai của việc quản lý app

Khi Apple ngày càng rời xa các trình khởi chạy có thể tuỳ biến, AppBoard cố gắng giữ lại việc sắp xếp thủ công, quyền kiểm soát của người dùng và truy cập hiệu quả trên macOS hiện đại.

**AppBoard** không chỉ là một bản thay thế Launchpad — đó là câu trả lời thực dụng cho sự thụt lùi của trải nghiệm làm việc.

---

**AppBoard** - Giành lại quyền kiểm soát trình khởi chạy app của bạn 🚀

*Dành cho người dùng macOS không chấp nhận thoả hiệp về tuỳ biến.*

## Công cụ phát triển

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
