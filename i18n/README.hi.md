# AppBoard

**भाषाएँ**: [English](../README.md) | [简体中文](README.zh.md) | [繁體中文](README.zh-TW.md) | [日本語](README.ja.md) | [한국어](README.ko.md) | [Français](README.fr.md) | [Español](README.es.md) | [Deutsch](README.de.md) | [Русский](README.ru.md) | [हिन्दी](README.hi.md) | [Tiếng Việt](README.vi.md) | [Italiano](README.it.md) | [Čeština](README.cs.md)

macOS Tahoe ने Launchpad हटा दिया, नया Apps अनुभव उपयोगकर्ताओं की ज़रूरतें पूरी नहीं करता और Mac की Bio GPU का पूरा उपयोग भी नहीं करता। फिर भी Apple वापस जाने का विकल्प नहीं देता। AppBoard इस समस्या को हल करने का प्रयास करता है।

*AppBoard को [LaunchNext](https://github.com/RoversX/LaunchNext) और [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) (लेखक: ggkevinnnn) के आधार पर बनाया गया है — मूल प्रोजेक्ट्स का तहे दिल से धन्यवाद! ❤️*

*LaunchNext और LaunchNow दोनों GPL 3 लाइसेंस का उपयोग करते हैं, AppBoard भी इन्हीं शर्तों का पालन करता है।*

⭐ कृपया [LaunchNext](https://github.com/RoversX/LaunchNext) और मूल प्रोजेक्ट [LaunchNow](https://github.com/ggkevinnnn/LaunchNow) को स्टार देने पर विचार करें!


## AppBoard क्या प्रदान करता है
- ✅ **पुराने LaunchPad जैसा अनुभव** - हमने पुराने LaunchPad के अनुभव को यथासंभव दोबारा तैयार किया है, जिसमें ऐप पर लंबे प्रेस से जिग्गल/डिलीट प्रबंधन, समान ऐप्स को ड्रैग करके एक फ़ोल्डर में मर्ज करना आदि शामिल हैं।
- ✅ **पुराने LaunchPad से एक-क्लिक इम्पोर्ट** - आपके नेटिव Launchpad SQLite डेटाबेस को सीधे पढ़कर फ़ोल्डर, ऐप पोज़िशन और लेआउट को पुनःस्थापित करता है
- ✅ **मैनुअल ऐप व्यवस्थापन** - ऐप्स को मूव करें, फ़ोल्डर बनाएँ और अपने अनुसार लेआउट रखें
- ✅ **दो रेंडरिंग पथ** - संगतता के लिए `Legacy Engine`, सबसे अच्छे अनुभव के लिए `Next Engine + Core Animation`
- ✅ **Compact और Fullscreen मोड** - सेटिंग्स अलग-अलग सेव होती हैं
- ✅ **कीबोर्ड-फर्स्ट वर्कफ़्लो** - तेज़ खोज, नेविगेशन और लॉन्च
- ✅ **Hot Corner और नेटिव जेस्चर एक्टिवेशन** - कई वैश्विक प्रवेश बिंदु
- ✅ **ऐप्स को सीधे Dock में खींचें** - Core Animation इंजन में उपलब्ध
- ✅ **Markdown रिलीज़ नोट्स वाला अपडेट हब** - समृद्ध इन-ऐप अपडेट अनुभव
- ✅ **बैकअप और रीस्टोर टूल्स** - सुरक्षित निर्यात/पुनःस्थापना प्रवाह
- ✅ **एक्सेसिबिलिटी और कंट्रोलर सपोर्ट** - वॉइस फीडबैक और गेमपैड नेविगेशन बेहतर
- ✅ **बहुभाषी समर्थन** - व्यापक UI भाषा कवरेज

## macOS Tahoe ने क्या छीन लिया

- ❌ कस्टम ऐप व्यवस्था नहीं
- ❌ उपयोगकर्ता द्वारा बनाए गए फ़ोल्डर नहीं
- ❌ ड्रैग-एंड-ड्रॉप कस्टमाइज़ेशन नहीं
- ❌ विज़ुअल ऐप मैनेजमेंट नहीं
- ❌ ज़बरदस्ती कैटेगरीवार समूहन

## डेटा स्टोरेज

ऐप्लिकेशन डेटा यहाँ सुरक्षित होता है:

```text
~/Library/Application Support/AppBoard/Data.store
```

## नेटिव Launchpad एकीकरण

AppBoard सिस्टम Launchpad डेटाबेस को सीधे पढ़ सकता है:

```bash
/private$(getconf DARWIN_USER_DIR)com.apple.dock.launchpad/db/db
```

## इंस्टॉलेशन

### सिस्टम आवश्यकताएँ

- macOS 26 (Tahoe) या उच्चतर
- Apple Silicon या Intel प्रोसेसर
- Xcode 26 (सोर्स से बिल्ड करने के लिए)

### सोर्स से बिल्ड

1. **रिपॉज़िटरी क्लोन करें**
   ```bash
   git clone https://github.com/MiniMindX/AppBoard.git
   cd AppBoard
   ```

2. **Xcode में खोलें**
   ```bash
   open AppBoard.xcodeproj
   ```

3. **बिल्ड और रन**
   - टारगेट डिवाइस चुनें
   - `⌘+R` दबाएँ बिल्ड और रन करने के लिए
   - या केवल बिल्ड के लिए `⌘+B`

### कमांड लाइन बिल्ड

बिल्ड दो चरणों में होता है: पहले सुनिश्चित करें कि SwiftUpdater बिल्ड हो चुका है (सिर्फ़ पहली बार या clean के बाद आवश्यक), फिर मुख्य ऐप बिल्ड करें।

**1. एक बार का SwiftUpdater प्री-बिल्ड**

केवल पहली बार कोड लाने पर, या UpdaterScripts/SwiftUpdater/.build/ हटाने के बाद ज़रूरी है:

```bash
cd UpdaterScripts/SwiftUpdater
swift build --configuration release --arch arm64 --arch x86_64 --product SwiftUpdater
cd ../../
```
आर्टिफ़ैक्ट `UpdaterScripts/SwiftUpdater/.build/apple/Products/Release/SwiftUpdater` पर मिलेगा, और मुख्य `App` का `Run Script Phase` उसे अपने आप कॉपी कर लेगा।

**2. मुख्य ऐप बिल्ड करें:**
- Debug बिल्ड (रोज़मर्रा):
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Debug -destination 'platform=macOS' build
```
आर्टिफ़ैक्ट: `~/Library/Developer/Xcode/DerivedData/AppBoard-<hash>/Build/Products/Debug/AppBoard.app`

- Release बिल्ड:
```bash
xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release -destination 'platform=macOS' build
```

- रिलीज़ पैकेजिंग (Release + zip + checksum):
```bash
./scripts/release.sh
```

यह स्क्रिप्ट `Release` में `clean build` करती है, फिर `AppBoard.app` को `AppBoard<संस्करण>.zip` के रूप में `Build/dist/` में डालती है और `checksums.txt` बनाती है।

- Xcode में सीधे बिल्ड
`AppBoard.xcodeproj` खोलें, `Cmd+B` से बिल्ड, `Cmd+R` से रन। `Xcode` स्वतः `AppBoard scheme` का उपयोग करेगा। `SwiftUpdater` को फिर भी ऊपर दिए कमांड से एक बार बिल्ड करना ज़रूरी है।

**3. यूनिवर्सल बाइनरी (Intel + Apple Silicon):**
```bash
  xcodebuild -project AppBoard.xcodeproj -scheme AppBoard -configuration Release \
    -destination 'generic/platform=macOS' \
    ARCHS="arm64 x86_64" \
    ONLY_ACTIVE_ARCH=NO \
    clean build
```

## उपयोग

### शीघ्र शुरुआत

1. AppBoard पहली बार चलाने पर सभी इंस्टॉल किए गए ऐप्स स्कैन करता है
2. अपने पुराने Launchpad लेआउट को इम्पोर्ट करें या खाली लेआउट से शुरू करें
3. खोज, कीबोर्ड नेविगेशन, माउस ड्रैग और फ़ोल्डर के ज़रिए ऐप्स व्यवस्थित करें
4. Settings में इंजन, लेआउट मोड, एक्टिवेशन और ऑटोमेशन कॉन्फ़िगर करें

### अपना Launchpad इम्पोर्ट करें

1. Settings खोलें
2. **Import Launchpad** पर क्लिक करें
3. आपका मौजूदा लेआउट और फ़ोल्डर स्वतः इम्पोर्ट हो जाएँगे

### इंजन और लेआउट मोड

- **Legacy Engine** - पुराने रेंडरिंग पथ को बरकरार रखता है, संगतता को प्राथमिकता
- **Next Engine + Core Animation** - अनुशंसित। समग्र अनुभव और नई सुविधाओं के लिए बेहतर
- **Compact / Fullscreen** - AppBoard दोनों मोड का समर्थन करता है और सेटिंग्स अलग-अलग सहेजता है

## मुख्य विशेषताएँ

### एक्टिवेशन और इनपुट

- **Hot Corner समर्थन** - कॉन्फ़िगर करने योग्य स्क्रीन कोने से AppBoard खोलें
- **प्रायोगिक नेटिव जेस्चर समर्थन** - चार-उंगली pinch / tap क्रियाएँ
- **ग्लोबल शॉर्टकट समर्थन** - कहीं से भी AppBoard खोलें
- **ऐप्स को Dock में खींचें** - Core Animation इंजन में ऐप सीधे macOS Dock को सौंपा जाता है

### अपडेट अनुभव

- **इन-ऐप अपडेट हब** - ऐप छोड़े बिना अपडेट जाँचें
- **Markdown रिलीज़ नोट्स** - Settings में सीधे समृद्ध सामग्री दिखाई देती है
- **आधुनिक Notification API** - अद्यतन macOS नोटिफ़िकेशन सिस्टम के अनुकूल

### बैकअप और रीस्टोर

- Settings से बैकअप बनाएँ और रीस्टोर करें
- अधिक विश्वसनीय बैकअप एक्सपोर्ट व्यवहार
- अस्थायी फ़ाइलों और सफ़ाई का सुरक्षित प्रबंधन

### एक्सेसिबिलिटी और नेविगेशन

- **वॉइस फ़ीडबैक** - नेविगेशन के दौरान ऐप और फ़ोल्डर नाम बोले जाते हैं
- **कंट्रोलर समर्थन** - गेमपैड से AppBoard और फ़ोल्डर चलाएँ
- **कीबोर्ड-फर्स्ट इंटरैक्शन** - बिना माउस के तेज़ खोज और नेविगेशन

## प्रदर्शन और स्थिरता

- सुगम ब्राउज़िंग के लिए स्मार्ट आइकन कैशिंग
- बड़ी ऐप लाइब्रेरी के लिए लेज़ी लोडिंग और बैकग्राउंड स्कैनिंग
- Settings और नेविगेशन स्थिति की बेहतर समकालन
- अपडेट प्रबंधन, बैकअप एक्सपोर्ट और जेस्चर रिकवरी की बेहतर विश्वसनीयता


## योगदान

योगदान का स्वागत है।

1. रिपॉज़िटरी फ़ोर्क करें
2. फ़ीचर ब्रांच बनाएँ (`git checkout -b feature/amazing-feature`)
3. परिवर्तन कमिट करें (`git commit -m 'Add amazing feature'`)
4. ब्रांच पुश करें (`git push origin feature/amazing-feature`)
5. Pull Request खोलें

### विकास दिशानिर्देश

- Swift स्टाइल कन्वेंशन का पालन करें
- जटिल लॉजिक के लिए सार्थक टिप्पणियाँ जोड़ें
- जब संभव हो, कई macOS संस्करणों पर परीक्षण करें
- प्रायोगिक सुविधाओं को असंबंधित फ़ाइलों में बिखरने से बचाएँ
- हटाई जा सकने वाली इंटीग्रेशन को अलग रखें

## ऐप प्रबंधन का भविष्य

जैसे-जैसे Apple अनुकूलन योग्य लॉन्चर से दूर होता जा रहा है, AppBoard आधुनिक macOS पर मैन्युअल संगठन, उपयोगकर्ता नियंत्रण और कुशल पहुँच बनाए रखने की कोशिश करता है।

**AppBoard** सिर्फ़ Launchpad का विकल्प नहीं है, यह वर्कफ़्लो की पीछे जाती दिशा पर एक व्यावहारिक उत्तर है।

---

**AppBoard** - अपने ऐप लॉन्चर पर फिर से नियंत्रण पाएँ 🚀

*उन macOS उपयोगकर्ताओं के लिए बनाया गया जो कस्टमाइज़ेशन में समझौता नहीं करना चाहते।*

## डेवलपमेंट टूल्स

- Claude Code
- Cursor
- OpenAI Codex CLI
- Perplexity
- Google
