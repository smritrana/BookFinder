//
//  Dynamic.swift
//  BookFinder
//
//  Created by Smriti Rana on 15/12/22.
//

import Foundation

/// To bind and fire event on value change
class Dynamic<T>:NSObject {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
