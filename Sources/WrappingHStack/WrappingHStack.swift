import SwiftUI

/// A layout container that arranges its children in horizontal lines, wrapping to new lines as needed.
/// Similar to HStack but automatically wraps content to new lines when space is limited.
public struct WrappingHStack: View {
    private let spacing: CGFloat
    private let lineSpacing: CGFloat
    private let alignment: HorizontalAlignment
    private let content: [AnyView]

    @State private var containerWidth: CGFloat = 0
    @State private var itemSizes: [Int: CGSize] = [:]
    @State private var totalHeight: CGFloat?

    // MARK: - Initializers for Collections

    /// Creates a WrappingHStack with Identifiable data
    /// - Parameters:
    ///   - data: A collection of identifiable data
    ///   - spacing: Horizontal spacing between items on the same line
    ///   - lineSpacing: Vertical spacing between lines
    ///   - alignment: Horizontal alignment of lines (.leading, .center, .trailing)
    ///   - content: A view builder that creates a view for each data element
    public init<Data: RandomAccessCollection, Content: View>(
        _ data: Data,
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) where Data.Element: Identifiable {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        self.content = data.map { AnyView(content($0)) }
    }

    /// Creates a WrappingHStack with data identified by KeyPath
    /// - Parameters:
    ///   - data: A collection of data
    ///   - id: KeyPath to a hashable property for identifying elements
    ///   - spacing: Horizontal spacing between items on the same line
    ///   - lineSpacing: Vertical spacing between lines
    ///   - alignment: Horizontal alignment of lines (.leading, .center, .trailing)
    ///   - content: A view builder that creates a view for each data element
    public init<Data: RandomAccessCollection, ID: Hashable, Content: View>(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        self.content = data.map { AnyView(content($0)) }
    }

    // MARK: - ViewBuilder Initializers


    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                // Main content display
                if !itemSizes.isEmpty {
                    VStack(alignment: .leading, spacing: lineSpacing) {
                        let lines = calculateLines()
                        ForEach(0..<lines.count, id: \.self) { lineIndex in
                            alignedHStack(spacing: spacing, alignment: alignment) {
                                ForEach(lines[lineIndex], id: \.self) { itemIndex in
                                    content[itemIndex]
                                        .fixedSize(horizontal: true, vertical: false)
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
                    // Loading placeholder
                    alignedHStack(spacing: spacing, alignment: alignment) {
                        ForEach(0..<content.count, id: \.self) { index in
                            content[index]
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                }
            }
            .overlay(
                HStack(spacing: 0) {
                    ForEach(0..<content.count, id: \.self) { index in
                        content[index]
                            .fixedSize()
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onAppear {
                                            itemSizes[index] = proxy.size
                                        }
                                        .onChange(of: proxy.size) { newSize in
                                            if itemSizes[index] != newSize {
                                                itemSizes[index] = newSize
                                            }
                                        }
                                }
                            )
                    }
                }
                .frame(maxWidth: .infinity)
                .hidden()
            )
            .onAppear {
                containerWidth = geometry.size.width
            }
            .onChange(of: geometry.size.width) { newWidth in
                containerWidth = newWidth
            }
        }
        .frame(height: totalHeight)
    }

    /// Creates an aligned HStack with proper spacers based on alignment
    @ViewBuilder
    private func alignedHStack<Content: View>(
        spacing: CGFloat,
        alignment: HorizontalAlignment,
        @ViewBuilder content: () -> Content
    ) -> some View {
        HStack(spacing: spacing) {
            if alignment == .center || alignment == .trailing {
                Spacer(minLength: 0)
            }
            content()
            if alignment == .leading || alignment == .center {
                Spacer(minLength: 0)
            }
        }
        .frame(maxWidth: .infinity)
    }

    /// Calculates how content should be arranged in lines based on available width
    /// - Returns: Array of arrays, where each inner array contains indices of items for that line
    private func calculateLines() -> [[Int]] {
        guard containerWidth > 0 else { return [] }

        var lines: [[Int]] = []
        var currentLine: [Int] = []
        var currentWidth: CGFloat = 0

        for index in 0..<content.count {
            guard let itemSize = itemSizes[index],
                  itemSize.width > 0 else { continue }

            let requiredWidth = currentWidth + itemSize.width + (currentLine.isEmpty ? 0 : spacing)

            if requiredWidth <= containerWidth || currentLine.isEmpty {
                currentLine.append(index)
                currentWidth = requiredWidth
            } else {
                if !currentLine.isEmpty {
                    lines.append(currentLine)
                }
                currentLine = [index]
                currentWidth = itemSize.width
            }
        }

        if !currentLine.isEmpty {
            lines.append(currentLine)
        }

        return lines
    }
}

// MARK: - ViewBuilder Overloads

extension WrappingHStack {

    // MARK: - Parameter Packs (Swift 5.9+)
    #if swift(>=5.9)
    /// Creates a WrappingHStack using parameter packs (Swift 5.9+, iOS 17+)
    /// Supports unlimited number of views without manual overloads
    @available(iOS 17.0, macOS 14.0, *)
    public init<each Content: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(repeat each Content)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        var views: [AnyView] = []
        for view in repeat each tuple {
            views.append(AnyView(view))
        }
        self.content = views
    }
    #endif

    // MARK: - Manual Overloads (iOS 14+ Fallback)
    public init<V0: View, V1: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1)]
    }

    public init<V0: View, V1: View, V2: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2)]
    }

    public init<V0: View, V1: View, V2: View, V3: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3)]
    }

    public init<V0: View, V1: View, V2: View, V3: View, V4: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4)]
    }

    public init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4), AnyView(tuple.5)]
    }

    public init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View, V6: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5, V6)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4), AnyView(tuple.5), AnyView(tuple.6)]
    }

    public init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View, V6: View, V7: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5, V6, V7)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4), AnyView(tuple.5), AnyView(tuple.6), AnyView(tuple.7)]
    }

    public init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View, V6: View, V7: View, V8: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5, V6, V7, V8)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4), AnyView(tuple.5), AnyView(tuple.6), AnyView(tuple.7), AnyView(tuple.8)]
    }

    public init<V0: View, V1: View, V2: View, V3: View, V4: View, V5: View, V6: View, V7: View, V8: View, V9: View>(
        spacing: CGFloat = 4,
        lineSpacing: CGFloat = 4,
        alignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> TupleView<(V0, V1, V2, V3, V4, V5, V6, V7, V8, V9)>
    ) {
        self.spacing = spacing
        self.lineSpacing = lineSpacing
        self.alignment = alignment
        let tuple = content().value
        self.content = [AnyView(tuple.0), AnyView(tuple.1), AnyView(tuple.2), AnyView(tuple.3), AnyView(tuple.4), AnyView(tuple.5), AnyView(tuple.6), AnyView(tuple.7), AnyView(tuple.8), AnyView(tuple.9)]
    }
}
