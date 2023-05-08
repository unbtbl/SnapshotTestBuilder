import SwiftUI

#if os(iOS)
public typealias DeviceSnapshotTestBuilder = CustomSnapshotTestBuilder<DeviceLayoutConfigurationProvider>
#endif

/// A builder for snapshot tests with the default configuration.
/// Custom configurations can be provided by conforming to `SwiftUISnapshotConfigurationProvider` and using `SnapshotBuilder<CustomConfigurationProvider>`.
/// The behavior of the default snapshot test builder can be customized by configuring `DefaultConfigurationProvider.configurations`.
public typealias SnapshotTestBuilder = CustomSnapshotTestBuilder<DefaultConfigurationProvider>

@resultBuilder
public struct CustomSnapshotTestBuilder<Configuration: SwiftUISnapshotConfigurationProvider> {
    public static func buildExpression<V: View>(
        _ expression: V,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) -> [SnapshotComponent] {
        Configuration.configurations.map { configuration in
            SnapshotComponent(expression, configuration: configuration, file: file, testName: testName, line: line)
        }
    }
    
    public static func buildExpression(
        _ expression: SnapshotName,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) -> [SnapshotComponent] {
        [SnapshotComponent(name: expression.name, file: file, testName: testName, line: line)]
    }
    
    /// Allows assignment, e.g. `isRecording = true`
    public static func buildExpression(_ expression: ()) -> [SnapshotComponent] {
        []
    }
    
    public static func buildBlock(
        _ content: [SnapshotComponent]...
    ) -> [SnapshotComponent] {
        Array(content.joined())
    }
    
    public static func buildArray(_ components: [[SnapshotComponent]]) -> [SnapshotComponent] {
        Array(components.joined())
    }
    
    public static func buildFinalResult(_ components: [SnapshotComponent]) -> Void {
        var name: String?
        var snapshotCount = 0
        
        // TODO: Custom names currently don't work properly with multiple configurations
        
        for component in components {
            switch component.kind {
            case .view(let view, let configuration):
                snapshotCount += 1
                assertSnapshot(
                    matching: view,
                    as: configuration.snapshotting,
                    named: name ?? (snapshotCount > 1 ? "\(snapshotCount)" : nil),
                    record: configuration.record,
                    timeout: configuration.timeout,
                    file: component.file,
                    testName: component.testName,
                    line: component.line
                )
                name = nil // Multiple snapshots with the same name would override each other
            case .name(let newName):
                name = newName
            }
        }
    }
}
