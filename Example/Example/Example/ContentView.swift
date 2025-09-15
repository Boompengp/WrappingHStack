//
//  ContentView.swift
//  Example
//
//  Created by 彭少辰 on 2025/9/15.
//

import SwiftUI
import WrappingHStack
import SDWebImageSwiftUI

struct ContentView: View {
    @State private var selectedAlignment: HorizontalAlignment = .center
    @State private var imageSize: CGFloat = 60

    let staticTexts = [
        "短文本", "Medium Text", "这是一个比较长的中文文本用于测试",
        "Short", "Very Long English Text for Testing Wrapping",
        "Swift", "SwiftUI", "iOS开发", "移动应用", "用户界面"
    ]

    let imageUrls = [
        "https://picsum.photos/100/100?random=1",
        "https://picsum.photos/100/100?random=2",
        "https://picsum.photos/100/100?random=3",
        "https://picsum.photos/100/100?random=4",
        "https://picsum.photos/100/100?random=5",
        "https://picsum.photos/100/100?random=6"
    ]

    let socialMediaPosts = [
        SocialPost(type: .text, content: "SwiftUI is amazing! 🚀"),
        SocialPost(type: .image, content: "https://picsum.photos/80/80?random=10"),
        SocialPost(type: .text, content: "Love coding in Swift"),
        SocialPost(type: .hashtag, content: "#iOS"),
        SocialPost(type: .text, content: "Building great apps"),
        SocialPost(type: .image, content: "https://picsum.photos/60/60?random=11"),
        SocialPost(type: .hashtag, content: "#SwiftUI"),
        SocialPost(type: .text, content: "Clean architecture matters"),
        SocialPost(type: .image, content: "https://picsum.photos/90/90?random=12"),
        SocialPost(type: .hashtag, content: "#CleanCode"),
        SocialPost(type: .text, content: "WWDC was incredible this year! 🎉"),
        SocialPost(type: .image, content: "https://picsum.photos/70/70?random=13")
    ]

    let productTags = [
        ProductTag(type: .feature, title: "AI Powered", icon: "brain"),
        ProductTag(type: .image, title: "https://picsum.photos/40/40?random=20", icon: ""),
        ProductTag(type: .category, title: "Technology", icon: "laptopcomputer"),
        ProductTag(type: .rating, title: "4.9★", icon: "star.fill"),
        ProductTag(type: .image, title: "https://picsum.photos/35/35?random=21", icon: ""),
        ProductTag(type: .feature, title: "Machine Learning", icon: "cpu"),
        ProductTag(type: .price, title: "$99", icon: "dollarsign.circle"),
        ProductTag(type: .image, title: "https://picsum.photos/45/45?random=22", icon: ""),
        ProductTag(type: .category, title: "Productivity", icon: "chart.bar"),
        ProductTag(type: .feature, title: "Cloud Sync", icon: "icloud")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {

                    // Alignment Control
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Alignment Control")
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

                    // Static Text Test
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Static Text Test")
                            .font(.headline)

                        WrappingHStack(staticTexts, id: \.self, spacing: 8, lineSpacing: 8, alignment: selectedAlignment) { text in
                            Text(text)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(16)
                        }
                    }

                    Divider()

                    // ViewBuilder Static Test
                    VStack(alignment: .leading, spacing: 16) {
                        Text("ViewBuilder Static Test")
                            .font(.headline)

                        WrappingHStack(spacing: 8, lineSpacing: 8, alignment: selectedAlignment) {
                            Text("短")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.red.opacity(0.2))
                                .cornerRadius(8)

                            Text("Medium Length")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(8)

                            Text("Very Long Text Label")
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.orange.opacity(0.2))
                                .cornerRadius(8)

                            Button("Button") {
                                print("Button tapped")
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.purple.opacity(0.2))
                            .cornerRadius(8)

                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }

                    Divider()

                    // Dynamic Image Test
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Dynamic Image Test")
                            .font(.headline)

                        HStack {
                            Text("Image Size:")
                            Slider(value: $imageSize, in: 30...100, step: 5)
                            Text("\(Int(imageSize))pt")
                        }

                        WrappingHStack(imageUrls, id: \.self, spacing: 8, lineSpacing: 8, alignment: selectedAlignment) { imageUrl in
                            WebImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: imageSize, height: imageSize)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: imageSize, height: imageSize)
                                    .overlay(
                                        ProgressView()
                                            .scaleEffect(0.5)
                                    )
                            }
                        }
                    }

                    Divider()

                    // Mixed Content Test
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Mixed Content Test")
                            .font(.headline)

                        WrappingHStack(spacing: 12, lineSpacing: 12, alignment: selectedAlignment) {
                            // Badge
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
                                print("Add to cart")
                            }
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)

                            // Shipping Badge
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

                            // Progress
                            HStack {
                                Text("Progress")
                                    .font(.caption2)
                                ProgressView(value: 0.7)
                                    .frame(width: 60)
                            }
                        }
                    }

                    Divider()

                    // Social Media Style
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Social Media Style")
                            .font(.headline)

                        WrappingHStack(socialMediaPosts, spacing: 6, lineSpacing: 8, alignment: selectedAlignment) { post in
                            switch post.type {
                            case .text:
                                Text(post.content)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(12)

                            case .hashtag:
                                Text(post.content)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.purple.opacity(0.2))
                                    .foregroundColor(.purple)
                                    .cornerRadius(8)

                            case .image:
                                WebImage(url: URL(string: post.content)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 50, height: 50)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                                .font(.caption)
                                        )
                                }
                            }
                        }
                    }

                    Divider()

                    // Product Tags Style
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Product Tags Style")
                            .font(.headline)

                        WrappingHStack(productTags, spacing: 8, lineSpacing: 10, alignment: selectedAlignment) { tag in
                            switch tag.type {
                            case .feature:
                                HStack(spacing: 4) {
                                    Image(systemName: tag.icon)
                                        .font(.caption2)
                                    Text(tag.title)
                                        .font(.caption)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.green.opacity(0.2))
                                .foregroundColor(.green)
                                .cornerRadius(12)

                            case .category:
                                HStack(spacing: 4) {
                                    Image(systemName: tag.icon)
                                        .font(.caption2)
                                    Text(tag.title)
                                        .font(.caption)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .background(Color.orange.opacity(0.2))
                                .foregroundColor(.orange)
                                .cornerRadius(8)

                            case .price:
                                HStack(spacing: 4) {
                                    Image(systemName: tag.icon)
                                        .font(.caption2)
                                    Text(tag.title)
                                        .font(.caption)
                                        .fontWeight(.bold)
                                }
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.red.opacity(0.2))
                                .foregroundColor(.red)
                                .cornerRadius(16)

                            case .rating:
                                HStack(spacing: 2) {
                                    Image(systemName: tag.icon)
                                        .font(.caption2)
                                        .foregroundColor(.yellow)
                                    Text(tag.title)
                                        .font(.caption)
                                        .fontWeight(.medium)
                                }
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.yellow.opacity(0.1))
                                .foregroundColor(.black)
                                .cornerRadius(10)

                            case .image:
                                WebImage(url: URL(string: tag.title)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 35, height: 35)
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                } placeholder: {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 35, height: 35)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .foregroundColor(.gray)
                                                .font(.caption2)
                                        )
                                }
                            }
                        }
                    }

                    Divider()

                    // News Feed Style
                    VStack(alignment: .leading, spacing: 16) {
                        Text("News Feed Style")
                            .font(.headline)

                        WrappingHStack(spacing: 10, lineSpacing: 12, alignment: selectedAlignment) {
                            // Author Avatar
                            WebImage(url: URL(string: "https://picsum.photos/40/40?random=30")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 35, height: 35)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 35, height: 35)
                            }

                            // Username
                            Text("@john_doe")
                                .font(.caption)
                                .fontWeight(.medium)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(6)

                            // Content Text
                            Text("Just shipped a new feature! 🎉")
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)

                            // Photo
                            WebImage(url: URL(string: "https://picsum.photos/60/60?random=31")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 45, height: 45)
                            }

                            // Hashtags
                            Text("#iOS")
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(4)

                            Text("#Swift")
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(4)

                            // Reaction
                            HStack(spacing: 2) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                Text("24")
                            }
                            .font(.caption2)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 3)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(12)

                            // Time
                            Text("2h ago")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("WrappingHStack Demo")
        }
    }
}

// MARK: - Data Models

struct SocialPost: Identifiable {
    let id = UUID()
    let type: PostType
    let content: String

    enum PostType {
        case text, hashtag, image
    }
}

struct ProductTag: Identifiable {
    let id = UUID()
    let type: TagType
    let title: String
    let icon: String

    enum TagType {
        case feature, category, price, rating, image
    }
}

#Preview {
    ContentView()
}
