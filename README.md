# PusherNotificationsSwift
Wrapper around Pusher's push notification API intended for server-side swift applications.

Pusher currently provides free unlimited notifications for both iOS and Android, which probably makes it together with this SDK the simplest way to start sending push notifications using your server-side swift backend.

Check out [Pusher’s official documentation](https://pusher.com/docs/push_notifications) and the usage example bellow to get started.

[![Build Status](https://travis-ci.org/petrpavlik/PusherNotificationsSwift.svg?branch=master)](https://travis-ci.org/petrpavlik/PusherNotificationsSwift)
[![Latest Release](https://img.shields.io/github/release/petrpavlik/PusherNotificationsSwift.svg)](https://github.com/petrpavlik/PusherNotificationsSwift/releases/latest)
![Platforms](https://img.shields.io/badge/platforms-Linux%20%7C%20OS%20X-blue.svg)
![Package Managers](https://img.shields.io/badge/package%20managers-SwiftPM-yellow.svg)

## Basic Usage
```swift
let pusher = Pusher(appKey: "a", appSecret: "b", appId: "c")
do {
    try pusher.notify(interests: ["donuts"], apns: ["aps": ["alert": ["body": "hello world"]]])
} catch {
    // ...
}

```

## Installation
### Swift Package Manager
Add `PusherNotificationsSwift` to your dependencies in `Package.swift`
```Swift
.Package(url: "https://github.com/petrpavlik/PusherNotificationsSwift.git", majorVersion: 0),
```

## License
MIT

### Author
Petr Pavlik - [@ptrpavlik](https://twitter.com/ptrpavlik)
