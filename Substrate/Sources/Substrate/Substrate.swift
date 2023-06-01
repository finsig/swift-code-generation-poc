//
//  File.swift
//  
//
//  Created by Steven Boynes on 5/20/22.
//

import Foundation


public struct Substrate {
    public private(set) var text = "Hello, World!"

    public init() {
    }
    
    static let runtime: Runtime = Polkadot()
}
