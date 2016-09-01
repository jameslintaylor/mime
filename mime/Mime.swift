//
//  Mime.swift
//  mime
//
//  Created by James Taylor on 2016-08-31.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation
import AssociatedObjects

/// you're not meant to implement this protocol, it's just here to make use of swift generics
public protocol Mime: AssociatedObjects {}

// the key we'll use for our target cache
private var targetCacheKey = "_"

// implement target cache associated object
internal extension Mime {
    
    typealias TargetCache = [Target]
    
    var targetCache: TargetCache {
        get {
            /// return the existing cache if it exists otherwise create a new one
            return getAssociatedObject(key: &targetCacheKey) as? TargetCache ?? {
                let new = TargetCache()
                self.targetCache = new
                return new
                }()
        }
        set {
            setAssociatedObject(newValue, key: &targetCacheKey)
        }
    }
}