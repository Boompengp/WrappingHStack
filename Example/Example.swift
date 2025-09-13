import SwiftUI

// MARK: - 示例用法

// 1. 基本的字符串标签
struct BasicTagsExample: View {
    let tags = ["iOS", "SwiftUI", "UIKit", "Combine", "Core Data", "MapKit", "AVFoundation"]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Basic String Tags - Leading")
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

            Text("Basic String Tags - Center")
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

            Text("Basic String Tags - Trailing")
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
        .padding()
    }
}

// 2. 可选择的标签（带状态）
struct SelectableTag: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool = false
}

struct SelectableTagsExample: View {
    @State private var selectableTags = [
        SelectableTag(title: "Beginner"),
        SelectableTag(title: "Intermediate"),
        SelectableTag(title: "Advanced"),
        SelectableTag(title: "Expert"),
        SelectableTag(title: "Professional"),
        SelectableTag(title: "Senior")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Selectable Tags")
                .font(.headline)

            WrappingHStack(
                items: selectableTags,
                spacing: 8,
                lineSpacing: 8,
                alignment: .leading
            ) { tag in
                Button(action: {
                    if let index = selectableTags.firstIndex(where: { $0.id == tag.id }) {
                        selectableTags[index].isSelected.toggle()
                    }
                }) {
                    Text(tag.title)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(tag.isSelected ? Color.green : Color.gray.opacity(0.2))
                        .foregroundColor(tag.isSelected ? .white : .primary)
                        .cornerRadius(16)
                }
            }
        }
        .padding()
    }
}

// 3. 带过滤功能的标签
struct FilterableTag: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    var isVisible: Bool = true
}

struct FilterableTagsExample: View {
    @State private var filterableTags = [
        FilterableTag(title: "Swift", category: "Language"),
        FilterableTag(title: "Kotlin", category: "Language"),
        FilterableTag(title: "Python", category: "Language"),
        FilterableTag(title: "iOS", category: "Platform"),
        FilterableTag(title: "Android", category: "Platform"),
        FilterableTag(title: "Web", category: "Platform"),
        FilterableTag(title: "Junior", category: "Level"),
        FilterableTag(title: "Senior", category: "Level")
    ]

    @State private var selectedCategory = "All"

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Filterable Tags")
                .font(.headline)

            Picker("Category", selection: $selectedCategory) {
                Text("All").tag("All")
                Text("Language").tag("Language")
                Text("Platform").tag("Platform")
                Text("Level").tag("Level")
            }
            .pickerStyle(SegmentedPickerStyle())

            WrappingHStack(
                items: filterableTags,
                spacing: 8,
                lineSpacing: 8,
                alignment: .center,
                shouldShow: { tag in
                    selectedCategory == "All" || tag.category == selectedCategory
                }
            ) { tag in
                Text(tag.title)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(categoryColor(tag.category))
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
        }
        .padding()
    }

    private func categoryColor(_ category: String) -> Color {
        switch category {
        case "Language": return .blue
        case "Platform": return .green
        case "Level": return .orange
        default: return .gray
        }
    }
}

// 4. 用户标签示例（类似你原来的实现）
struct UserTag: Identifiable {
    let id = UUID()
    let type: UserTagType
    let data: Any?

    enum UserTagType {
        case flag
        case level(Int)
        case vip
        case achievement(String)
    }
}

struct UserTagsExample: View {
    let userTags = [
        UserTag(type: .flag, data: "🇨🇳"),
        UserTag(type: .level(25), data: nil),
        UserTag(type: .vip, data: nil),
        UserTag(type: .achievement("First Login"), data: nil)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("User Tags Example")
                .font(.headline)

            WrappingHStack(
                items: userTags,
                spacing: 6,
                lineSpacing: 6,
                alignment: .leading,
                shouldShow: { tag in
                    // 自定义显示逻辑
                    switch tag.type {
                    case .vip:
                        return true // 总是显示VIP
                    case .level(let level):
                        return level > 10 // 只显示等级大于10的
                    default:
                        return true
                    }
                }
            ) { tag in
                tagView(for: tag)
            }
        }
        .padding()
    }

    @ViewBuilder
    private func tagView(for tag: UserTag) -> some View {
        switch tag.type {
        case .flag:
            if let flag = tag.data as? String {
                Text(flag)
                    .font(.system(size: 20))
                    .frame(width: 24, height: 20)
            }
        case .level(let level):
            HStack(spacing: 2) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 12))
                Text("\(level)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.purple)
            .cornerRadius(8)
        case .vip:
            Text("VIP")
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(LinearGradient(
                    colors: [.yellow, .orange],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .cornerRadius(8)
        case .achievement(let name):
            HStack(spacing: 2) {
                Image(systemName: "trophy.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 10))
                Text(name)
                    .font(.system(size: 10))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color.blue)
            .cornerRadius(8)
        }
    }
}

#if DEBUG
struct WrappingHStack_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 32) {
                BasicTagsExample()
                Divider()
                SelectableTagsExample()
                Divider()
                FilterableTagsExample()
                Divider()
                UserTagsExample()
            }
        }
    }
}
#endif