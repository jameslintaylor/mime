## `UIGestureRecognizer`, for swift!

### adding gestures...
*without mime*
```swift
let tap = UITapGestureRecognizer(target: self, action: #selector(...handleTap(_:))
view.addGestureRecognizer(tap)

dynamic func handleTap(tap: UITapGestureRecognizer) {
    print("tap at \(tap.locationInView(view))!")
}
```
*with mime*
```swift
let tap = UITapGestureRecognizer()
view.mime_on(tap) { [weak view]
    print("tap at \($0.locationInView(view))!")
}
```
💥**bonus!**💥 mime can also do state filtering
```swift
let pan = UIPanGestureRecognizer()
view.mime_on(pan, [.began, .changed]) { _ in
    print("meh... I'm not really interested in being called when the pan ends")
}
```

### removing gestures
removing gestures is easy too!
```swift
// to remove all gestures that mime has registered to the view, we can do
view.mime_off()

// to remove a specific gesture, pass the reference to that gesture
let swipe = UISwipeGestureRecognizer()
swipe.direction = .Left
view.mime_on(swipe) { _ in }
view.mime_off(swipe)

// you can actually pass as many gestures to `mime_off` as you'd like
let tap = ...
let pan = ...
let pinch = ...
...
view.mime_off(tap, pan, pinch)
```

### a note on retain cycles
```swift
// when calling `view.mime_on`, note that `view` will hold a reference to the closure
view.mime_on(tap) {
    print("I'm being retained!")
}

// if you plan on referencing `view` from within the closure, make sure to do so weakly
view.mime_on(tap) { [weak view]
    print("I'm being retained but it's cool cause I don't really care about \(view)")
}

// the same goes for view controllers (here `self` is a `UIViewController`)
self.view.mime_on(tap) { [weak self]
    ...
}
```

### installation
`pod 'mime'` and you're set
