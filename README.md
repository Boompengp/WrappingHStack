# WrappingHStack

A flexible SwiftUI layout container that arranges views in horizontal lines, automatically wrapping to new lines when space is limited.

[![Swift](https://img.shields.io/badge/Swift-5.3+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-14.0+-blue.svg)](https://developer.apple.com/ios/)
[![macOS](https://img.shields.io/badge/macOS-11.0+-blue.svg)](https://developer.apple.com/macos/)
[![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

[中文文档](README_CN.md) | English

## Features

- ✅ **Multiple API Patterns**: ForEach, ViewBuilder, and Array-based initialization
- ✅ **Smart Wrapping**: Automatically wraps content to new lines when space is limited
- ✅ **Flexible Alignment**: Support for leading, center, and trailing alignment
- ✅ **Customizable Spacing**: Independent control of horizontal and vertical spacing
- ✅ **Type Safety**: Full generic support with proper type constraints
- ✅ **Performance Optimized**: Efficient layout calculation with hidden measurement layer
- ✅ **SwiftUI Native**: Built with SwiftUI best practices and conventions

## Installation

### Swift Package Manager

Add WrappingHStack to your project through Xcode:

1. **File → Add Package Dependencies**
2. **Enter repository URL**
3. **Select version and add to project**

Or add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Boompengp/WrappingHStack.git", from: "1.0.0")
]
```

## Usage

### 1. ForEach with Identifiable Data

Perfect for dynamic data collections:

```swift
import WrappingHStack

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let category: String
}

let items = [
    Item(name: "iPhone", category: "Device"),
    Item(name: "iPad", category: "Device"),
    Item(name: "MacBook", category: "Computer")
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

### 2. Array with KeyPath ID

For data without Identifiable conformance:

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

### 3. ViewBuilder Syntax (up to 10 views)

For static layouts with mixed content types:

```swift
WrappingHStack(spacing: 12, lineSpacing: 12, alignment: .leading) {
    // Text label
    Text("Hot")
        .font(.caption)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.red)
        .foregroundColor(.white)
        .cornerRadius(4)

    // Rating
    HStack(spacing: 4) {
        Image(systemName: "star.fill")
        Text("4.8")
    }
    .font(.caption)
    .foregroundColor(.orange)

    // Button
    Button("Add to Cart") {
        // Action
    }
    .font(.caption)
    .padding(.horizontal, 12)
    .padding(.vertical, 6)
    .background(Color.blue)
    .foregroundColor(.white)
    .cornerRadius(8)

    // Badge
    Text("Free Shipping")
        .font(.caption2)
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(Color.green.opacity(0.2))
        .foregroundColor(.green)
        .cornerRadius(6)
}
```

### Alignment Options

```swift
// Leading alignment (default)
WrappingHStack(tags, alignment: .leading) { tag in ... }

// Center alignment
WrappingHStack(tags, alignment: .center) { tag in ... }

// Trailing alignment
WrappingHStack(tags, alignment: .trailing) { tag in ... }
```

### Dynamic Alignment Demo

```swift
struct ContentView: View {
    @State private var selectedAlignment: HorizontalAlignment = .center
    let tags = ["Swift", "SwiftUI", "iOS", "Xcode"]

    var body: some View {
        VStack {
            // Alignment Control
            HStack {
                Button("Leading") { selectedAlignment = .leading }
                Button("Center") { selectedAlignment = .center }
                Button("Trailing") { selectedAlignment = .trailing }
            }

            // Dynamic WrappingHStack
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

## API Reference

### WrappingHStack

A layout container that arranges its children in horizontal lines, wrapping to new lines as needed.

#### Initialization Parameters

- **spacing**: `CGFloat` - Horizontal spacing between items on the same line (default: 4)
- **lineSpacing**: `CGFloat` - Vertical spacing between lines (default: 4)
- **alignment**: `HorizontalAlignment` - Horizontal alignment of lines (default: .center)
  - `.leading`: Left-aligned
  - `.center`: Center-aligned
  - `.trailing`: Right-aligned

#### Available Initializers

1. **ForEach with Identifiable Data**
   ```swift
   init<Data, Content>(_ data: Data, spacing: CGFloat = 4, lineSpacing: CGFloat = 4, alignment: HorizontalAlignment = .center, @ViewBuilder content: @escaping (Data.Element) -> Content)
   where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View
   ```

2. **Array with KeyPath ID**
   ```swift
   init<Data, Content>(_ data: Data, id: KeyPath<Data.Element, some Hashable>, spacing: CGFloat = 4, lineSpacing: CGFloat = 4, alignment: HorizontalAlignment = .center, @ViewBuilder content: @escaping (Data.Element) -> Content)
   where Data: RandomAccessCollection, Content: View
   ```

3. **ViewBuilder Syntax (1-10 views)**
   ```swift
   init(spacing: CGFloat = 4, lineSpacing: CGFloat = 4, alignment: HorizontalAlignment = .center, @ViewBuilder content: () -> some View)
   ```

## Performance Notes

- **Efficient Layout**: Uses a hidden measurement layer to pre-calculate item sizes
- **Minimal Re-renders**: Layout recalculation only occurs when container size changes
- **Memory Optimized**: AnyView type erasure minimizes memory overhead
- **SwiftUI Native**: Built entirely with SwiftUI APIs for optimal performance

## System Requirements

- iOS 14.0+ / macOS 11.0+
- Swift 5.3+
- Xcode 12.0+

## Examples

Check out `NewAPIExamples.swift` for comprehensive usage examples including:

- Multiple initialization patterns
- Dynamic alignment switching
- Mixed content types
- Real-world UI scenarios

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License

## Author

Created by [@Boompengp](https://github.com/Boompengp)

---

⭐ **Star this repo if you found it helpful!**