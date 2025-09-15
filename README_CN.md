# WrappingHStack

一个灵活的 SwiftUI 布局容器，可以将视图水平排列，当空间不足时自动换行到新的行。

[![Swift](https://img.shields.io/badge/Swift-5.3+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-14.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-11.0+-blue.svg)](https://developer.apple.com/macos/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

中文文档 | [English](README.md)

## 功能特性

- ✅ **多种 API 模式**：支持 ForEach、ViewBuilder 和数组初始化
- ✅ **智能换行**：当空间不足时自动将内容换行到新行
- ✅ **灵活对齐**：支持 leading、center 和 trailing 对齐
- ✅ **可定制间距**：独立控制水平和垂直间距
- ✅ **无限制视图**：Swift 5.9+ 参数包支持无限视图，iOS 14+ 回退支持（最多 10 个视图）
- ✅ **类型安全**：完整的泛型支持和正确的类型约束
- ✅ **性能优化**：使用隐藏测量层进行高效布局计算
- ✅ **SwiftUI 原生**：完全使用 SwiftUI 最佳实践构建

## 安装

### Swift Package Manager

通过 Xcode 添加 WrappingHStack：

1. **File → Add Package Dependencies**
2. **输入仓库 URL**
3. **选择版本并添加到项目**

或者添加到你的 `Package.swift`：

```swift
dependencies: [
    .package(url: "https://github.com/Boompengp/WrappingHStack.git", from: "1.0.0")
]
```

### 运行示例应用

要运行完整的演示应用：

1. **克隆仓库**
   ```bash
   git clone https://github.com/Boompengp/WrappingHStack.git
   cd WrappingHStack
   ```

2. **打开示例项目**
   ```bash
   open Example/Example/Example.xcodeproj
   ```

3. **在 Xcode 中添加必要的依赖：**
   - 添加本地 WrappingHStack 包（指向 `../..`）
   - 添加 [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI) 用于 iOS 14+ 图片加载

4. **构建并运行**，查看所有演示场景！

## 使用方法

### 1. ForEach 配合 Identifiable 数据

适用于动态数据集合：

```swift
import WrappingHStack

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let category: String
}

let items = [
    Item(name: "iPhone", category: "设备"),
    Item(name: "iPad", category: "设备"),
    Item(name: "MacBook", category: "电脑")
]

WrappingHStack(items, spacing: 8, lineSpacing: 8, alignment: .center) { item in
    VStack {
        Text(item.name)
            .font(.caption)
        Text(item.category)
            .font(.caption2)
            .foregroundColor(.secondary)
    }
    .padding()
    .background(Color.orange.opacity(0.2))
    .cornerRadius(8)
}
```

### 2. 数组配合 KeyPath ID

适用于不遵循 Identifiable 的数据：

```swift
let tags = ["Swift", "SwiftUI", "iOS", "Xcode", "UIKit"]

WrappingHStack(tags, id: \.self, spacing: 8, lineSpacing: 8, alignment: .trailing) { tag in
    Text(tag)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.cyan.opacity(0.2))
        .foregroundColor(.cyan)
        .cornerRadius(16)
}
```

### 3. ViewBuilder 语法（Swift 5.9+ 支持无限视图）

适用于混合内容类型的静态布局：
- **Swift 5.9+ (iOS 17+)**：使用参数包支持无限数量视图
- **iOS 14+ 回退支持**：使用手动重载最多支持 10 个视图

```swift
WrappingHStack(spacing: 12, lineSpacing: 12, alignment: .leading) {
    // 文本标签
    Text("热销")
        .font(.caption)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(4)

    // 评分
    HStack(spacing: 4) {
        Image(systemName: "star.fill")
        Text("4.8")
    }
    .font(.caption)
    .foregroundColor(.orange)

    // 按钮
    Button("加入购物车") {
        // 动作
    }
    .font(.caption)
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(Color.blue)
    .foregroundColor(.white)
    .cornerRadius(8)

    // 徽章
    Text("包邮")
        .font(.caption2)
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(Color.green.opacity(0.2))
        .foregroundColor(.green)
        .cornerRadius(6)
}
```

### 对齐选项

```swift
// 左对齐（默认）
WrappingHStack(tags, alignment: .leading) { tag in ... }

// 居中对齐
WrappingHStack(tags, alignment: .center) { tag in ... }

// 右对齐
WrappingHStack(tags, alignment: .trailing) { tag in ... }
```

### 动态对齐演示

```swift
struct ContentView: View {
    @State private var selectedAlignment: HorizontalAlignment = .center
    let tags = ["Swift", "SwiftUI", "iOS", "Xcode"]

    var body: some View {
        VStack {
            // 对齐控制
            HStack {
                Button("左对齐") { selectedAlignment = .leading }
                Button("居中") { selectedAlignment = .center }
                Button("右对齐") { selectedAlignment = .trailing }
            }

            // 动态 WrappingHStack
            WrappingHStack(tags, id: \.self, alignment: selectedAlignment) { tag in
                Text(tag)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
}
```

## API 参考

### WrappingHStack

一个将子视图水平排列的布局容器，当需要时自动换行到新行。

#### 初始化参数

- **spacing**: `CGFloat` - 同一行项目之间的水平间距（默认：4）
- **lineSpacing**: `CGFloat` - 行与行之间的垂直间距（默认：4）
- **alignment**: `HorizontalAlignment` - 行的水平对齐方式（默认：.center）
  - `.leading`：左对齐
  - `.center`：居中对齐
  - `.trailing`：右对齐

#### 可用的初始化器

1. **ForEach 配合 Identifiable 数据**
   ```swift
   init<Data, Content>(_ data: Data, spacing: CGFloat = 4, lineSpacing: CGFloat = 4, alignment: HorizontalAlignment = .center, @ViewBuilder content: @escaping (Data.Element) -> Content)
   where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View
   ```

2. **数组配合 KeyPath ID**
   ```swift
   init<Data, Content>(_ data: Data, id: KeyPath<Data.Element, some Hashable>, spacing: CGFloat = 4, lineSpacing: CGFloat = 4, alignment: HorizontalAlignment = .center, @ViewBuilder content: @escaping (Data.Element) -> Content)
   where Data: RandomAccessCollection, Content: View
   ```

3. **ViewBuilder 语法（Swift 5.9+ 支持无限视图）**
   ```swift
   // Swift 5.9+ (iOS 17+)：参数包支持无限视图
   init<each Content: View>(spacing: CGFloat = 4, lineSpacing: CGFloat = 4, alignment: HorizontalAlignment = .center, @ViewBuilder content: () -> TupleView<(repeat each Content)>)

   // iOS 14+ 回退支持：手动重载（最多 10 个视图）
   init(spacing: CGFloat = 4, lineSpacing: CGFloat = 4, alignment: HorizontalAlignment = .center, @ViewBuilder content: () -> some View)
   ```

## 性能说明

- **高效布局**：使用隐藏测量层预先计算项目尺寸
- **最少重新渲染**：仅在容器尺寸变化时重新计算布局
- **内存优化**：AnyView 类型擦除最大程度减少内存开销
- **SwiftUI 原生**：完全使用 SwiftUI API 构建，获得最佳性能

## 系统要求

- iOS 14.0+ / macOS 11.0+
- Swift 5.3+
- Xcode 12.0+

## 示例

### 实时演示应用

查看 `Example/` 目录中的完整**示例应用**，功能包括：

- 📱 **交互式对齐控制** - 实时切换左对齐、居中、右对齐
- 📝 **静态文字测试** - 多语言和不同长度的文本
- 🖼️ **动态图片调整** - 滑块调节图片大小 (30-100pt)
- 🎨 **图文混排场景**：
  - **社交媒体风格** - 头像、文字气泡和话题标签
  - **产品标签风格** - 功能、图片、评分和价格
  - **新闻动态风格** - 完整的社交媒体帖子布局
- 🔄 **实时布局更新** - 所有示例都响应对齐和尺寸变化

### 代码示例

示例应用演示了所有三种 API 模式：

- **基于集合的初始化** 配合动态数据
- **ViewBuilder 语法** 用于静态布局
- **混合内容布局** 结合图片和文字
- **iOS 14+ 兼容性** 使用 WebImage 加载网络图片


## 许可证

MIT 许可证

## 致谢

- 感谢 [@dkk](https://github.com/dkk) 提供设计思路，项目架构参考了他的 [WrappingHStack](https://github.com/dkk/WrappingHStack)
- 感谢 [Claude](https://claude.ai/code) 提供代码协助，绝大部分代码都是通过 AI 协助完成

---

⭐ **如果觉得有帮助，请给这个仓库点个 Star！**
