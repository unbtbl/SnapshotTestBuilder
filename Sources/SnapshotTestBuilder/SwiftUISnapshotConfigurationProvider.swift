import SwiftUI

// TODO: It might be nicer for this to be generic so we don't need AnyView, perhaps using a function/closure to create the snapshotting.
public struct SwiftUISnapshotConfiguration {
    public var snapshotting: Snapshotting<AnyView, UIImage>
    public var timeout: TimeInterval
    public var record: Bool
    // TODO: Add a configurable `namePrefix` (so snapshots can be named ".dark" and ".light" for example)

    public init(
        snapshotting: Snapshotting<AnyView, UIImage> = .image(),
        timeout: TimeInterval = 5,
        record: Bool = false
    ) {
        self.snapshotting = snapshotting
        self.timeout = timeout
        self.record = record
    }
}

public protocol SwiftUISnapshotConfigurationProvider {
    static var configurations: [SwiftUISnapshotConfiguration] { get }
}

#if os(iOS)
public struct DeviceLayoutConfigurationProvider: SwiftUISnapshotConfigurationProvider {
    public static var configurations: [SwiftUISnapshotConfiguration] = [
        .init(
            snapshotting: .image(layout: .device(config: .iPhone13))
        )
    ]
}
#endif

public struct DefaultConfigurationProvider: SwiftUISnapshotConfigurationProvider {
    /// Configurations for `DefaultConfigurationProvider`.
    /// These configurations are used by default in `SnapshotTestBuilder`.
    public static var configurations: [SwiftUISnapshotConfiguration] = defaultConfigurations

    /// Reset configurations for `DefaultConfigurationProvider` to default.
    public static func restore() {
        configurations = defaultConfigurations
    }

    /// Default configurations for `DefaultConfigurationProvider`, should you want to reset them.
    public static let defaultConfigurations: [SwiftUISnapshotConfiguration] = [
        .init(),
    ]
}
