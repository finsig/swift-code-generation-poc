//
//  Created by Steven Boynes on 6/24/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

/*
import Foundation

extension SwiftCodeFactory {
    class func cleanedPath(typeInfo: TypeInfo) -> TypeInfo.Path {
        
        var path = typeInfo.path
        
        if typeInfo.isPalletExtension, let segment = typeInfo.path.first, let name = segment.split(separator: "_").last {
            path.remove(at: .zero)
            path.insert(String(name).uppercasingFirstLetter(), at: .zero)
        }
        
        if typeInfo.isPolkadotExtension, let segment = typeInfo.path.first, let name = segment.split(separator: "_").last {
            path.remove(at: .zero)
            path.insert(String(name).uppercasingFirstLetter(), at: .zero)
            path.insert(String("Polkadot").uppercasingFirstLetter(), at: .zero)
        }
        
        if typeInfo.isSubstratePrimitiveExtension, let segment = typeInfo.path.first, let name = segment.split(separator: "_").last {
            path.remove(at: .zero)
            path.insert(String(name).uppercasingFirstLetter(), at: .zero)
        }

        if typeInfo.isFRAMEExtension, let segment = typeInfo.path.first, let name = segment.split(separator: "_").last {
            path.remove(at: .zero)
            path.insert(String(name).uppercasingFirstLetter(), at: .zero)
            path.insert("FRAME", at: .zero)
        }
        
        if typeInfo.isFinalityGRANDPAExtension {
            path.remove(at: .zero)
            path.insert("GRANDPA", at: .zero)
            path.insert("Finality", at: .zero)
        }
        
        if typeInfo.isGenericType {
            path.removeLast()
            let itemName = typeInfo.path.last!.uppercasingFirstLetter() + "<" + typeInfo.parameters.map({ $0.name.uppercasingFirstLetter() }).joined(separator: ",") + ">"
            path.append(itemName)
        }

        path = path.map({ segment in
            
            if segment.contains("_") {
                return String(segment).camelCased(fromSeparator: "_").uppercasingFirstLetter()
            }
            else {
                return String(segment).uppercasingFirstLetter()
            }
        })
        
        path = path.map({ $0.uppercasingFirstLetter() })
        
        path = path.map({ segment in
            
            if segment.caseInsensitiveCompare("grandpa") == .orderedSame {
                print("found grandpa segment= \(segment)")
                return segment.replacingOccurrences(of: "grandpa", with: "GRANDPA", options: .caseInsensitive)
            }
            if segment.contains("Grandpa") {
                print("contains grandpa  segment= \(segment)")
                return segment.replacingOccurrences(of: "grandpa", with: "GRANDPA", options: .caseInsensitive)
            }
            if segment.contains("Babe") {
                print("contains babe  segment= \(segment)")
                return segment.replacingOccurrences(of: "babe", with: "BABE", options: .caseInsensitive)
            }
   
            return String(segment)
            
        })
    
        
        return path
    }
}
*/
