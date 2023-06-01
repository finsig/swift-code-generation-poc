//
//  Created by Steven Boynes on 1/05/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation


extension SwiftCode.Block {
    /**
     Swift code blocks are equivalent if one of the following are true:
     
     1) the lines of code are identical, verbatim.
     2) the lines of code are identical after replacing typealias names with existing type names.
     
    */
    func isEquivalent(to block: SwiftCode.Block, registry: TypeInfo.Registry? = nil) async -> Bool {

        if self.lines == block.lines {
            return true
        }
        else {
            let url = Polkadot().typeInfoURL
            let registry = await TypeInfo.Registry(url: url)
            let factory = SwiftCodeFactory(registry: registry)
            
            let typealiasTuples = await factory.typealiasTuples()
            
            for tuple in typealiasTuples {
                print("tuple= \(tuple)")
                let blocklines = block.lines.joined(separator: " ").replacingOccurrences(of: tuple.name, with: tuple.existingType)
                
                print("block.lines= \(blocklines)")
                print("self.lines= \(self.lines.joined(separator: " "))")
                
                if self.lines.joined(separator: " ").caseInsensitiveCompare(blocklines) == .orderedSame {
                    print("found match")
                    return true
                }
            }
        }
        return false
    }
}

typealias TypealiasTuple = (name: String, existingType: String)
