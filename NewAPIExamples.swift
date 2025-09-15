import SwiftUI
import WrappingHStack

@available(iOS 14.0, macOS 11.0, *)
struct NewAPIExamples: View {
    let tags = ["Swift", "SwiftUI", "iOS", "Xcode", "UIKit", "Combine", "Core Data"]
    let items = [
        Item(name: "iPhone", category: "Device"),
        Item(name: "iPad", category: "Device"),
        Item(name: "MacBook", category: "Computer"),
        Item(name: "iMac", category: "Computer")
    ]

    @State private var selectedAlignment: HorizontalAlignment = .center

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {

                // Alignment 控制器
                VStack(alignment: .leading, spacing: 16) {
                    Text("Alignment 控制")
                        .font(.headline)

                    HStack(spacing: 16) {
                        Button("Leading") {
                            selectedAlignment = .leading
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selectedAlignment == .leading ? Color.blue : Color.gray.opacity(0.3))
                        .foregroundColor(selectedAlignment == .leading ? .white : .primary)
                        .cornerRadius(8)

                        Button("Center") {
                            selectedAlignment = .center
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selectedAlignment == .center ? Color.blue : Color.gray.opacity(0.3))
                        .foregroundColor(selectedAlignment == .center ? .white : .primary)
                        .cornerRadius(8)

                        Button("Trailing") {
                            selectedAlignment = .trailing
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selectedAlignment == .trailing ? Color.blue : Color.gray.opacity(0.3))
                        .foregroundColor(selectedAlignment == .trailing ? .white : .primary)
                        .cornerRadius(8)

                        Spacer()
                    }
                }

                Divider()

                // 1. ViewBuilder 方式 - 类似 HStack 的声明方式
                VStack(alignment: .leading, spacing: 16) {
                    Text("1. ViewBuilder 方式 (类似 HStack)")
                        .font(.headline)

                    WrappingHStack(spacing: 8, lineSpacing: 8, alignment: selectedAlignment) {
                        Text("First Item")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)

                        Button("Button") { }
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)

                        Circle()
                            .fill(Color.red)
                            .frame(width: 40, height: 40)

                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.title)

                        Text("Last Item")
                            .padding()
                            .background(Color.purple.opacity(0.2))
                            .cornerRadius(8)
                    }
                }

                Divider()

                // 2. ForEach 方式 - 使用 Identifiable 数据
                VStack(alignment: .leading, spacing: 16) {
                    Text("2. ForEach 方式 (Identifiable 数据)")
                        .font(.headline)

                    WrappingHStack(items, spacing: 8, lineSpacing: 8, alignment: selectedAlignment) { item in
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
                }

                Divider()

                // 3. 数组方式 - 使用 KeyPath ID
                VStack(alignment: .leading, spacing: 16) {
                    Text("3. 数组方式 (KeyPath ID)")
                        .font(.headline)

                    WrappingHStack(tags, id: \.self, spacing: 8, lineSpacing: 8, alignment: selectedAlignment) { tag in
                        Text(tag)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.cyan.opacity(0.2))
                            .foregroundColor(.cyan)
                            .cornerRadius(16)
                    }
                }

                Divider()

                // 4. 混合复杂内容示例
                VStack(alignment: .leading, spacing: 16) {
                    Text("4. 混合复杂内容")
                        .font(.headline)

                    WrappingHStack(spacing: 12, lineSpacing: 12, alignment: selectedAlignment) {
                        // 文本标签
                        Text("Hot")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(4)

                        // 图标
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                            Text("4.8")
                        }
                        .font(.caption)
                        .foregroundColor(.orange)

                        // 按钮
                        Button("Add to Cart") {
                            // Action
                        }
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)

                        // 徽章
                        Text("Free Shipping")
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.green.opacity(0.2))
                            .foregroundColor(.green)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.green, lineWidth: 1)
                            )

                        // 进度条
                        HStack {
                            Text("Progress")
                                .font(.caption2)
                            ProgressView(value: 0.7)
                                .frame(width: 60)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("新 API 示例")
    }
}

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let category: String
}

@available(iOS 14.0, macOS 11.0, *)
#Preview {
    NavigationView {
        NewAPIExamples()
    }
}