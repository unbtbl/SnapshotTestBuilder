# SnapshotBuilder

This is an extension to the [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) library that adds a SwiftUI result builder to make snapshot testing SwiftUI views even easier.

## Usage

For iOS, just use `@DeviceSnapshotBuilder` on a test function, then create the view you want to test.

The following example is a fully functional snapshot test case:

```swift
import SnapshotTestBuilder

final class MyAppTests: XCTestCase {
    @DeviceSnapshotTestBuilder
    func testContentViewSnapshot() {
        ContentView()
    }
}
``` 
