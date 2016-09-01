//
//  Controls.swift
//  mime
//
//  Created by James Taylor on 2016-08-31.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import UIKit

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
