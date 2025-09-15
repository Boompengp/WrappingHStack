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

### 3. ViewBuilder 语法（支持最多 10 个视图）

适用于混合内容类型的静态布局：

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

3. **ViewBuilder 语法（1-10 个视图）**
   ```swift
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

查看 `NewAPIExamples.swift` 获取完整的使用示例，包括：

- 多种初始化模式
- 动态对齐切换
- 混合内容类型
- 真实世界的 UI 场景

## 贡献

欢迎贡献！请随时提交 Pull Request。

## 许可证

MIT 许可证

## 作者

由 [@Boompengp](https://github.com/Boompengp) 创建

---

⭐ **如果觉得有帮助，请给这个仓库点个 Star！**