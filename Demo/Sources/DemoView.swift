import SwiftUI
import WrappingHStack

@available(iOS 14.0, *)
public struct DemoView: View {
    let tags = ["Swift", "SwiftUI", "iOS", "Xcode", "UIKit", "Combine", "Core Data", "MapKit", "AVFoundation"]

    public init() {}

    public var body: some View {
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
                    .frame(maxHeight: .infinity)
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
                    .frame(maxHeight: .infinity)
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
                    .frame(maxHeight: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle("WrappingHStack Demo")
    }
}

@available(iOS 14.0, *)
#Preview {
    NavigationView {
        DemoView()
    }
}