//
//  Gestures.swift
//  mime
//
//  Created by James Taylor on 2016-08-31.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import UIKit

prefix operator *<
/// maps a `UIGestureRecognizerState` to GestureState by left bit-shifting 1
/// by `UIGestureRecognizerState.rawValue`...
///
/// bit shifting by the raw value could be problematic, like if all of a sudden
/// one of these `UIGestureRecognizerState` get a `rawValue` greater than 63...
private prefix func *< (rhs: UIGestureRecognizerState) -> GestureStates {
    return GestureStates(rawValue: 1 << rhs.rawValue)
}

/// 1:1 mapping of `UIGestureRecognizerState` in `OptionSetType` form
public struct GestureStates: OptionSet {
    
    public let rawValue: Int
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let possible = *<.possible
    public static let began = *<.began
    public static let changed = *<.changed
    public static let ended = *<.ended
    public static let cancelled = *<.cancelled
    public static let failed = *<.failed
    
    public static let all: GestureStates = [.possible, .began, .changed, .ended, .cancelled, .failed]
}

private extension GestureStates {
    
    func contains(_ uiMember: UIGestureRecognizerState) -> Bool {
        // tests by reversing the bit shifting operation used to create the state
        return ((self.rawValue >> uiMember.rawValue) & 1) == 1
    }
}

extension UIGestureRecognizer: Mime {}

public extension Mime where Self: UIGestureRecognizer {
    
    /// implements the objc style `addTarget:selector:` method using swift closures
    @discardableResult
    func mime_on(_ states: GestureStates = .all, closure: @escaping (Self) -> ()) -> Self {
        // setup the target, casting sender to Self
        let target = Target {
            if states.contains($0.state) {
                closure($0 as! Self)
            }
        }
        addTarget(target, action: Target.handler)
        
        // retain the target
        targetCache.append(target)
        return self
    }
    
    /// removes all target/selectors added through `self.mime_on`
    func mime_off() {
        targetCache.forEach {
            removeTarget($0, action: Target.handler)
        }
        targetCache = []
    }
}
