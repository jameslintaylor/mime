//
//  Target.swift
//  mime
//
//  Created by James Taylor on 2016-08-31.
//  Copyright © 2016 James Taylor. All rights reserved.
//

import Foundation

/// used to link between objc style target-selector and swift's closures
///
/// delegates it's `handle(_:)` method to the `self.delegate` closure
internal class Target {
    
    let delegate: (AnyObject) -> ()
    init(delegate: @escaping (AnyObject) -> ()) {
        self.delegate = delegate
    }
    
    /// selector pointing to the `handle(_:) method`
    static let handler = #selector(handle(_:))
    
    /// just calls `self.delegate`
    dynamic func handle(_ sender: AnyObject) {
        delegate(sender)
    }
}
