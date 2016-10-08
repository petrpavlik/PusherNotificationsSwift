# PusherNotificationsSwift
Wrapper around Pusher's push notification API intended for server-side swift applications.

Pusher currently provides free unlimited notifications for both iOS and Android, which probably makes it together with this SDK the simplest way to start sending push notifications using your server-side swift backend.

Check out [Pusher’s official documentation](https://pusher.com/docs/push_notifications) and the usage example bellow to get started.

## Usage
```swift
let pusher = Pusher(appKey: "a", appSecret: "b", appId: "c")
pusher.notify(interests: ["unittests"], apns: ["aps": ["alert": ["body": "hello world"]]]) { (error) in
    if let error = error {
	    // …
    }
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