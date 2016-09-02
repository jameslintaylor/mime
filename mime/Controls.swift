//
//  Controls.swift
//  mime
//
//  Created by James Taylor on 2016-08-31.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import UIKit

/// let's have this until swift 3 (and the grand renamification)
public extension UIControlEvents {
    static let touchDown = UIControlEvents.TouchDown
    static let touchDownRepeat = UIControlEvents.TouchDownRepeat
    static let touchDragInside = UIControlEvents.TouchDragInside
    static let touchDragOutside = UIControlEvents.TouchDragOutside
    static let touchDragEnter = UIControlEvents.TouchDragEnter
    static let touchDragExit = UIControlEvents.TouchDragExit
    static let touchUpInside = UIControlEvents.TouchUpInside
    static let touchUpOutside = UIControlEvents.TouchUpOutside
    static let touchCancel = UIControlEvents.TouchCancel
    static let valueChanged = UIControlEvents.ValueChanged
    static let primaryActionTriggered = UIControlEvents.PrimaryActionTriggered
    static let editingDidBegin = UIControlEvents.EditingDidBegin
    static let editingChanged = UIControlEvents.EditingChanged
    static let editingDidEnd = UIControlEvents.EditingDidEnd
    static let editingDidEndOnExit = UIControlEvents.EditingDidEndOnExit
    static let allTouchEvents = UIControlEvents.AllTouchEvents
    static let allEditingEvents = UIControlEvents.AllEditingEvents
    static let applicationReserved = UIControlEvents.ApplicationReserved
    static let systemReserved = UIControlEvents.SystemReserved
    static let allEvents = UIControlEvents.AllEvents
}

extension UIControl: Mime {}

public extension Mime where Self: UIControl {
    
    /// wraps the objc style `addTarget:selector:forControlEvents` method using swift closures
    func mime_on(events: UIControlEvents = .AllEvents, closure: (Self) -> ()) -> Self {
        // setup the target, casting sender to Self
        let target = Target { closure($0 as! Self) }
        addTarget(target, action: Target.handler, forControlEvents: events)
        
        // retain the target
        targetCache.append(target)
        return self
    }
    
    /// removes all target/selectors added through `self.mime_on`
    func mime_off() {
        targetCache.forEach {
            removeTarget($0, action: Target.handler, forControlEvents: .AllEvents)
        }
        targetCache = []
    }
}
