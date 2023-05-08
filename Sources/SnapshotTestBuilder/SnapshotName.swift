/// The name for a snapshot.
/// Use this in a SnapshotBuilder block to name a snapshot.
public struct SnapshotName {
    /// The name of the snapshot.
    public var name: String
    
    /// Creates a snapshot name from a string.
    /// - Parameter name: The name of the snapshot.
    public init(_ name: String) {
        self.name = name
    }
    
    /// Creates a snapshot name from a subsequence.
    /// - Parameter name: The name of the snapshot.
    public init(_ name: String.SubSequence) {
        self.name = String(name)
    }
    
    /// Creates a snapshot name from any type that supports `CustomStringConvertible`.
    /// - Parameter name: The name of the snapshot.
    public init<Name>(_ name: Name) where Name: CustomStringConvertible {
        self.name = name.description
    }
}
