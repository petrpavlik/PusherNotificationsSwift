import PackageDescription

let package = Package(
    name: "PusherNotificationsSwift",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2)
    ]
)
