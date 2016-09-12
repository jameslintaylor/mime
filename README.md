# from target-action to closure! (and beyond 🚀)
**mime** provides an alternate way of interacting with the objective-c style target-action pattern using swift closures

### gestures...
target-action
```swift
let tap = UITapGestureRecognizer(target: self, action: #selector(...handleTap(_:))
view.addGestureRecognizer(tap)

dynamic func handleTap(tap: UITapGestureRecognizer) {
    print("tap at \(tap.locationInView(view))!")
}
```
**mime**
```swift
let tap = UITapGestureRecognizer()
tap.mime_on { 
    print("tap at \($0.locationInView($0.view))!")
}
view.addGestureRecognizer(tap)
```
💥**bonus!**💥 **mime** can also do gesture state filtering
```swift
let pan = UIPanGestureRecognizer()
pan.mime_on([.began, .changed]) { _ in
    print("meh... I'm not really interested in being called when the pan ends")
}
view.addGestureRecognizer(pan)
```

### controls...
```swift
let button = UIButton()
button.mime_on(.allTouchEvents) { 
    print("getting all touchy with \($0.currentTitle)...")
}
view.addSubview(button)
```

### removing a mime closure...
`mime_off` removes all closures set up with `mime_on`
```swift
tap.mime_off()
button.mime_off()
```

### a note on retain cycles...
```swift
// when calling `T.mime_on`, note that `T` will hold a reference to the closure
tap.mime_on {
    print("I'm being retained!")
}

// if you plan on referencing an object that holds reference to `T` from inside the closure, make sure to do so weakly
tap.mime_on { [weak view] in
    print("I'm being retained but it's cool cause I don't really care about \(view)")
}
view.addGestureRecognizer(tap)
```

### installation
`pod 'mime'` and you're set!
