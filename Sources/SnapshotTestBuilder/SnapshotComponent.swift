import SwiftUI

/// A single entry of a snapshot test.
public struct SnapshotComponent {
    enum Kind {
        case view(AnyView, SwiftUISnapshotConfiguration)
        case name(String)
    }

    var kind: Kind
    var file: StaticString
    var testName: String
    var line: UInt

    init<V>(_ view: V, configuration: SwiftUISnapshotConfiguration, file: StaticString, testName: String, line: UInt) where V: View {
        self.kind = .view(AnyView(view), configuration)
        self.file = file
        self.testName = testName
        self.line = line
    }

    init(name: String, file: StaticString, testName: String, line: UInt) {
        self.kind = .name(name)
        self.file = file
        self.testName = testName
        self.line = line
    }
}
