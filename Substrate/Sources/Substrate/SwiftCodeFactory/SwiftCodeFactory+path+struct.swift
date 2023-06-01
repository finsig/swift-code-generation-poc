//
//  Created by Steven Boynes on 6/10/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    
    func makeNamespacePath(typeInfo: TypeInfo) throws -> Outputs {
    
        guard typeInfo.path.count > 2 else {
            fatalError("The path is too short to declare an extension.")
        }
        
        var paths = registry.entries.map({ $0.typeInfo.path }).filter({ $0.isEmpty == false })
        
        /*
         Insert Substrate Primitive paths that do not appear in the registry.
         */
        paths.insert( ["sp_arithmetic"], at: .zero)
        //paths.insert( ["frame_system"], at: .zero)
        
        
        guard let registryIndex = paths.firstIndex(of: typeInfo.path) else {
            fatalError("Registry entry not found.")
        }
        paths = Array( paths.prefix(upTo: registryIndex) ) // all paths up to current path in registry
        
        let pathSlice = typeInfo.path.dropLast()
        let pathMatch = largestSlicesMatching(slice: pathSlice, paths: paths)
        
        var lines = SwiftCode.Lines()
        
        if pathMatch.isEmpty {
            let path = SwiftCode.Path( Array(pathSlice) )
            lines = path.map({ "struct \($0) {" })
        }
        else {
            let name = SwiftCode.Path( Array(pathMatch) ).joined(separator: ".")
            lines.append("extension \(name) {")
            
            let rangeToSubtract = pathSlice.firstRange(of: pathMatch)!
            let difference = pathSlice.dropFirst(rangeToSubtract.count)
            lines.append(contentsOf: difference.map({ "struct \($0) {" }) )
        }
        for _ in lines {
            lines.append("}")
        }
        
        let name = SwiftCode.Path( Array(pathSlice) ).joined(separator: "+")
        let code = SwiftCode.Block(name: name, lines: lines)
        return [Output(code: code, path: .path)]
    }
}


fileprivate extension SwiftCodeFactory {
    
    func largestSlicesMatching(slice: ArraySlice<String>, paths: [Array<String>]) -> ArraySlice<String> {
        guard slice.isEmpty == false else {
            return ArraySlice()
        }
        var mutablePaths = paths
        
        for index in stride(from: slice.indices.last!, through: slice.startIndex, by: -1) {
            
            let slice = slice.prefix(through: index)

            mutablePaths = mutablePaths.filter({
                guard $0.indices.contains(index) else {
                    return false
                }
                return ($0.prefix(through: index) == slice)
            })
            
            if mutablePaths.isEmpty == false {
                return slice.prefix(through: index)
            }
        }
        
        if mutablePaths.isEmpty && slice.isEmpty == false {
            return largestSlicesMatching(slice: slice.dropLast(), paths: paths)
        }
        
        return ArraySlice()
    }
}
