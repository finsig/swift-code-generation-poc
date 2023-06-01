//
//  Created by Steven Boynes on 1/18/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCode {
    ///
    /// An array that represents a path in Swift code
    ///
    typealias Path = Array<String>
}


extension SwiftCode.Path {
    
    init(_ path: SwiftCode.Path) {
        var mutablePath = path
        
        if let firstElement = path.first, firstElement.contains("_") == true {
            
            var components = firstElement.components(separatedBy: "_")
            
            if components.first?.caseInsensitiveCompare("frame") == .orderedSame { // FRAME
                components.removeFirst(1)
                mutablePath.removeFirst()
                mutablePath.insert(contentsOf: components, at: .zero)
                mutablePath.insert("FRAME", at: .zero)
            }
            
            if components.first?.caseInsensitiveCompare("finality") == .orderedSame { // Finality
                components.removeFirst(1)
                mutablePath.removeFirst()
                mutablePath.insert(contentsOf: components, at: .zero)
                mutablePath.insert("Finality", at: .zero)
            }
            
            if components.first?.caseInsensitiveCompare("pallet") == .orderedSame { // Pallet
                components.removeFirst(1)
                mutablePath.removeFirst()
                mutablePath.insert(components.camelCased, at: .zero)
            }
            
            if components.first?.caseInsensitiveCompare("polkadot") == .orderedSame { // Polkadot
                components.removeFirst(1)
                mutablePath.removeFirst()
                mutablePath.insert(contentsOf: components, at: .zero)
                mutablePath.insert("Polkadot", at: .zero)
            }
            
            if components.first?.caseInsensitiveCompare("sp") == .orderedSame { // Substrate Primitive
                components.removeFirst(1)
                mutablePath.removeFirst()
                mutablePath.insert(contentsOf: components, at: .zero)
            }
        }
        
        mutablePath = mutablePath.map({ $0.camelCased(fromSeparator: "_").uppercasingFirstLetter() })
        
        self.init(array: mutablePath)
    }
}
