# Example App Setup

This example app demonstrates WrappingHStack with various use cases including image and text mixing.

## Dependencies Required

To run this example app, you need to add the following dependencies in Xcode:

1. **Local WrappingHStack Package**
   - Add local package: `../..` (pointing to the root WrappingHStack package)

2. **SDWebImageSwiftUI** (for iOS 14+ compatibility)
   - Repository URL: `https://github.com/SDWebImage/SDWebImageSwiftUI.git`
   - Version: `2.0.0` or later

## Adding Dependencies in Xcode

1. Open `Example.xcodeproj`
2. Select the project in navigator
3. Go to **Package Dependencies** tab
4. Click **+** to add packages:
   - Add local package for WrappingHStack
   - Add SDWebImageSwiftUI from GitHub

## Features Demonstrated

- ✅ Static text wrapping with different lengths
- ✅ Dynamic image resizing with slider control
- ✅ ViewBuilder syntax examples
- ✅ Mixed content layouts (Social Media, Product Tags, News Feed)
- ✅ Real-time alignment switching
- ✅ Image and text combination scenarios

## iOS 14+ Compatibility

This example uses `WebImage` from SDWebImageSwiftUI instead of `AsyncImage` to support iOS 14+.