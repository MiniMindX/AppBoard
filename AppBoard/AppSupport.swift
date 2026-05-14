import Foundation

/// Single source of truth for AppBoard's on-disk data locations.
///
/// All persistent data (SwiftData store, custom icons, backups, updater config,
/// CLI history) and cache data (CLI socket) live under a container folder named
/// after the bundle identifier. Resolve paths through this enum instead of
/// hardcoding the folder name.
enum AppSupport {
    /// Container folder name used under Application Support and Caches.
    static let containerName = "com.minimindx.appboard"

    /// `~/Library/Application Support/<containerName>`, created on demand.
    static func directory() throws -> URL {
        try container(in: .applicationSupportDirectory)
    }

    /// `~/Library/Caches/<containerName>`, created on demand.
    static func cachesDirectory() throws -> URL {
        try container(in: .cachesDirectory)
    }

    private static func container(in searchPath: FileManager.SearchPathDirectory) throws -> URL {
        let fm = FileManager.default
        let base = try fm.url(for: searchPath, in: .userDomainMask, appropriateFor: nil, create: true)
        let dir = base.appendingPathComponent(containerName, isDirectory: true)
        if !fm.fileExists(atPath: dir.path) {
            try fm.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir
    }
}
