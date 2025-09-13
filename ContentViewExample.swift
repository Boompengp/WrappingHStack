import SwiftUI
import WrappingHStack

struct ContentView: View {
    let tags = ["Swift", "SwiftUI", "iOS", "Xcode", "UIKit", "Combine", "Core Data", "MapKit", "AVFoundation"]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    // 左对齐示例
                    VStack(alignment: .leading, spacing: 16) {
                        Text("左对齐 (.leading)")
                            .font(.headline)

                        WrappingHStack(tags, spacing: 8, lineSpacing: 8, alignment: .leading) { tag in
                            Text(tag)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(16)
                        }
                        .frame(height: 120)
                    }

                    Divider()

                    // 居中对齐示例
                    VStack(alignment: .leading, spacing: 16) {
                        Text("居中对齐 (.center)")
                            .font(.headline)

                        WrappingHStack(tags, spacing: 8, lineSpacing: 8, alignment: .center) { tag in
                            Text(tag)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .cornerRadius(16)
                        }
                        .frame(height: 120)
                    }

                    Divider()

                    // 右对齐示例
                    VStack(alignment: .leading, spacing: 16) {
                        Text("右对齐 (.trailing)")
                            .font(.headline)

                        WrappingHStack(tags, spacing: 8, lineSpacing: 8, alignment: .trailing) { tag in
                            Text(tag)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.purple.opacity(0.2))
                                .foregroundColor(.purple)
                                .cornerRadius(16)
                        }
                        .frame(height: 120)
                    }

                    Divider()

                    // 可选择标签示例
                    SelectableTagsExample()
                }
                .padding()
            }
            .navigationTitle("WrappingHStack Demo")
        }
    }
}

struct SelectableTag: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
}

struct SelectableTagsExample: View {
    @State private var tags = [
        SelectableTag(title: "Beginner"),
        SelectableTag(title: "Intermediate"),
        SelectableTag(title: "Advanced"),
        SelectableTag(title: "Expert"),
        SelectableTag(title: "Professional"),
        SelectableTag(title: "Senior")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("可选择标签")
                .font(.headline)

            WrappingHStack(
                items: tags,
                spacing: 8,
                lineSpacing: 8,
                alignment: .leading
            ) { tag in
                Button(action: {
                    if let index = tags.firstIndex(where: { $0.id == tag.id }) {
                        tags[index].isSelected.toggle()
                    }
                }) {
                    Text(tag.title)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(tag.isSelected ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(tag.isSelected ? .white : .primary)
                        .cornerRadius(16)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}