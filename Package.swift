import PackageDescription

let package = Package(
    name: "PusherNotificationsSwift",
    dependencies: [
        .Package(url: "https://github.com/vapor/crypto.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/engine.git", majorVersion: 1)
    ]
)
