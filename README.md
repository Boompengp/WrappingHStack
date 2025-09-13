# WrappingHStack

一个通用的 SwiftUI 水平换行布局组件。

## 功能特性

- ✅ 通用的水平换行布局组件
- ✅ 支持水平对齐 (.leading, .center, .trailing)
- ✅ 自定义间距配置
- ✅ 可选的条件显示过滤
- ✅ 支持任意 SwiftUI 视图作为子元素
- ✅ 支持 iOS 14+ 和 macOS 10.15+

## 安装

### Swift Package Manager

在 Xcode 中添加 Swift Package：

1. File → Add Package Dependencies
2. 输入仓库 URL
3. 选择版本并添加到项目

或在 `Package.swift` 中添加：

```swift
dependencies: [
    .package(url: "YOUR_REPO_URL", from: "1.0.0")
]
```

## 使用方法

### 基本用法

```swift
import WrappingHStack

// 简单的字符串标签
let tags = ["iOS", "SwiftUI", "UIKit", "Combine"]

WrappingHStack(tags, spacing: 8, lineSpacing: 8, alignment: .leading) { tag in
    Text(tag)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Color.blue.opacity(0.2))
        .foregroundColor(.blue)
        .cornerRadius(16)
}
```

### 自定义数据模型

```swift
struct Tag: Identifiable {
    let id = UUID()
    let title: String
    let isSelected: Bool
}

@State private var tags = [...]

WrappingHStack(
    items: tags,
    spacing: 8,
    lineSpacing: 8,
    alignment: .center
) { tag in
    Text(tag.title)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(tag.isSelected ? Color.blue : Color.gray.opacity(0.2))
        .cornerRadius(16)
}
```

### 条件显示

```swift
WrappingHStack(
    items: items,
    spacing: 8,
    lineSpacing: 8,
    alignment: .trailing,
    shouldShow: { item in
        // 自定义显示条件
        item.isVisible && item.category == selectedCategory
    }
) { item in
    // 视图构建
}
```

### 对齐方式示例

```swift
// 左对齐（默认）
WrappingHStack(tags, alignment: .leading) { tag in ... }

// 居中对齐
WrappingHStack(tags, alignment: .center) { tag in ... }

// 右对齐
WrappingHStack(tags, alignment: .trailing) { tag in ... }
```

## API 文档

### WrappingHStack

水平方向的换行布局，当内容宽度超过容器宽度时自动换行。

#### 初始化参数

- `items`: 要显示的数据数组，必须遵循 `Identifiable` 协议
- `spacing`: 同一行内元素之间的间距（默认: 4）
- `lineSpacing`: 行与行之间的间距（默认: 4）
- `alignment`: 水平对齐方式（默认: `.leading`）
  - `.leading`: 左对齐
  - `.center`: 居中对齐
  - `.trailing`: 右对齐
- `shouldShow`: 可选的过滤函数，返回 `true` 的元素才会显示
- `itemView`: 视图构建闭包，定义每个元素的显示样式

#### 便利初始化器

对于遵循 `Hashable` 的简单数据类型：

```swift
WrappingHStack(
    ["item1", "item2", "item3"],
    spacing: 8,
    lineSpacing: 8,
    alignment: .center
) { item in
    Text(item)
}
```

## 示例项目

查看 `Example/Example.swift` 了解更多使用示例：

- 基本字符串标签（展示不同对齐方式）
- 可选择的标签（带状态）
- 可过滤的标签
- 用户标签示例

## 系统要求

- iOS 14.0+
- macOS 10.15+
- Swift 5.3+

## 许可证

MIT License