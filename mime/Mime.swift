//
//  Mime.swift
//  mime
//
//  Created by James Taylor on 2016-08-31.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import UIKit
import AssociatedObjects

prefix operator *< {}
/// maps a `UIGestureRecognizerState` to GestureState by left bit-shifting 1
/// by `UIGestureRecognizerState.rawValue`
private prefix func *< (rhs: UIGestureRecognizerState) -> GestureStates {
    return GestureStates(rawValue: 1 << rhs.rawValue)
}

public struct GestureStates: OptionSetType {
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public static let possible = *<.Possible
    public static let began = *<.Began
    public static let changed = *<.Changed
    public static let ended = *<.Ended
    public static let cancelled = *<.Cancelled
    public static let failed = *<.Failed
    
    public static let all: GestureStates = [.possible, .began, .changed, .ended, .cancelled, .failed]
}

private extension GestureStates {
    
    func contains(uiMember: UIGestureRecognizerState) -> Bool {
        return ((self.rawValue >> uiMember.rawValue) & 1) == 1
    }
}

private class GestureTarget {
    
    static let handler = #selector(handle(_:))
    
    let delegate: (UIGestureRecognizer) -> ()
    
    init(delegate: (UIGestureRecognizer) -> ()) {
        self.delegate = delegate
    }
    
    dynamic func handle(gesture: UIGestureRecognizer) {
        delegate(gesture)
    }
}

extension UIView {
    
    private typealias TargetCache = [UIGestureRecognizer: [GestureTarget]]
    private static var targetCacheKey: Character = "m"
    
    private var targetCache: TargetCache {
        get {
            /// return the existing if it exists otherwise create a new one
            return getAssociatedObject(key: &UIView.targetCacheKey) as? TargetCache ?? {
                let new = TargetCache()
                self.targetCache = new
                return new
                }()
        }
        set {
            setAssociatedObject(newValue, key: &UIView.targetCacheKey)
        }
    }
}

public extension UIView {
    
    func mime_on<Gesture: UIGestureRecognizer>(gesture: Gesture, _ states: GestureStates = .all, doBlock: (Gesture) -> ()) {
        // create and retain the target
        let target = GestureTarget {
            if states.contains($0.state) {
                doBlock($0 as! Gesture)
            }
        }
        targetCache[gesture] = (targetCache[gesture] ?? []) + [target]
        // add the gesture with the target
        gesture.addTarget(target, action: GestureTarget.handler)
        addGestureRecognizer(gesture)
    }
    
    func mime_off(gestures: UIGestureRecognizer...) {
        if gestures.isEmpty {
            targetCache = [:]
        } else {
            for gesture in gestures {
                targetCache[gesture] = nil
            }
        }
    }
}

