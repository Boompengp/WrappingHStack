import SwiftUI

@available(iOS 14.0, *)
public struct WrappingHStack<Item: Identifiable, ItemView: View>: View {
    private let items: [Item]
    private let spacing: CGFloat
    private let lineSpacing: CGFloat
    private let alignment: HorizontalAlignment
    private let itemView: (Item) -> ItemView
    private let shouldShow: ((Item) -> Bool)?

    @State private var containerWidth: CGFloat = 0
    @State private var itemSizes: [Item.ID: CGSize] = [:]
    @State private var totalHeight: CGFloat = 30

    public init(
        items: [Item],
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .leading,
        shouldShow: ((Item) -> Bool)? = nil,
        @ViewBuilder itemView: @escaping (Item) -> ItemView
    ) {
        self.items = items
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        self.shouldShow = shouldShow
        self.itemView = itemView
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // 隐藏的测量层
                HStack(spacing: 0) {
                    ForEach(visibleItems, id: \.id) { item in
                        itemView(item)
                            .fixedSize()
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            itemSizes[item.id] = proxy.size
                                        }
                                        .onChange(of: proxy.size) { newSize in
                                            if itemSizes[item.id] != newSize {
                                                itemSizes[item.id] = newSize
                                            }
                                        }
                                }
                            )
                            .opacity(0)
                    }
                }

                // 实际显示的内容
                if !itemSizes.isEmpty {
                    VStack(alignment: alignment, spacing: lineSpacing) {
                        let lines = calculateLines()
                        ForEach(0..<lines.count, id: \.self) { lineIndex in
                            HStack(spacing: spacing) {
                                if alignment == .center {
                                    Spacer(minLength: 0)
                                }
                                ForEach(lines[lineIndex], id: \.id) { item in
                                    itemView(item)
                                }
                                if alignment == .leading || alignment == .center {
                                    Spacer(minLength: 0)
                                }
                            }
                        }
                    }
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    totalHeight = proxy.size.height
                                }
                                .onChange(of: proxy.size.height) { height in
                                    totalHeight = height
                                }
                        }
                    )
                } else {
                    // 加载状态的占位符
                    HStack(spacing: spacing) {
                        if alignment == .center {
                            Spacer(minLength: 0)
                        }
                        ForEach(visibleItems, id: \.id) { item in
                            itemView(item)
                        }
                        if alignment == .leading || alignment == .center {
                            Spacer(minLength: 0)
                        }
                    }
                }
            }
            .onAppear {
                containerWidth = geometry.size.width
            }
            .onChange(of: geometry.size.width) { newWidth in
                containerWidth = newWidth
            }
        }
        .frame(height: totalHeight)
    }

    private var visibleItems: [Item] {
        if let shouldShow = shouldShow {
            return items.filter(shouldShow)
        }
        return items
    }

    private func calculateLines() -> [[Item]] {
        guard containerWidth > 0 else { return [] }

        var lines: [[Item]] = []
        var currentLine: [Item] = []
        var currentWidth: CGFloat = 0

        for item in visibleItems {
            guard let itemSize = itemSizes[item.id],
                  itemSize.width > 0 else { continue }

            let requiredWidth = currentWidth + itemSize.width + (currentLine.isEmpty ? 0 : spacing)

            if requiredWidth <= containerWidth || currentLine.isEmpty {
                currentLine.append(item)
                currentWidth = requiredWidth
            } else {
                if !currentLine.isEmpty {
                    lines.append(currentLine)
                }
                currentLine = [item]
                currentWidth = itemSize.width
            }
        }

        if !currentLine.isEmpty {
            lines.append(currentLine)
        }

        return lines
    }
}

// MARK: - 便利初始化器

@available(iOS 14.0, *)
extension WrappingHStack where Item == HashableItem {
    public init<T: Hashable>(
        _ items: [T],
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .leading,
        shouldShow: ((T) -> Bool)? = nil,
        @ViewBuilder content: @escaping (T) -> ItemView
    ) {
        let wrappedItems = items.map { HashableItem(value: $0) }
        self.init(
            items: wrappedItems,
            spacing: spacing,
            lineSpacing: lineSpacing,
            alignment: alignment,
            shouldShow: shouldShow.map { show in { item in show(item.value as! T) } },
            itemView: { item in content(item.value as! T) }
        )
    }
}

public struct HashableItem: Identifiable {
    public let id = UUID()
    public let value: AnyHashable

    public init(value: AnyHashable) {
        self.value = value
    }
}