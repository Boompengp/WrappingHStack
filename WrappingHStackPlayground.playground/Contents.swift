import SwiftUI
import PlaygroundSupport

// 注意：您需要先将 WrappingHStack.swift 文件添加到 Playground 的 Sources 文件夹中

struct ContentView: View {
    let tags = ["Swift", "SwiftUI", "iOS", "Xcode", "UIKit", "Combine"]

    var body: some View {
        VStack(spacing: 20) {
            Text("WrappingHStack 演示")
                .font(.title)

            // 这里需要导入您的 WrappingHStack
            // WrappingHStack(tags, alignment: .center) { tag in
            //     Text(tag)
            //         .padding()
            //         .background(Color.blue.opacity(0.2))
            //         .cornerRadius(8)
            // }
        }
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ContentView())