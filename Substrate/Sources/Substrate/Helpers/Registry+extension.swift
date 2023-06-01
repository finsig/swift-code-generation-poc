//
//  Created by Steven Boynes on 1/11/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {

    func typealiasTuples() async -> [TypealiasTuple] {
        let regex = try! Regex("^typealias\\s.+=.+$")
        var tuples = [TypealiasTuple]()
        
        let url = Substrate.runtime.typeInfoURL
        let registry = await TypeInfo.Registry(url: url)
        
        for entry in registry.entries {
            guard let outputs = try? await makeOutputs(typeInfo: entry.typeInfo) else {
                continue
            }
            for output in outputs {
                for line in output.code.lines {
                    if let match = line.firstMatch(of: regex) {
                        let string = match.0.replacingOccurrences(of: "typealias", with: String.empty)
                        let stringWithoutWhitespace = string.components(separatedBy: .whitespaces).joined()
                        let components = stringWithoutWhitespace.split(separator: "=")
                        let tuple = TypealiasTuple(name: String(components[0]), existingType: String(components[1]))
                    
                        //print("tuple= \(tuple)")
                        tuples.append(tuple)
                    }
                }
                //print("output.code= \(output.code)")
            }
        }
        return tuples
    }
}


fileprivate extension SwiftCodeFactory {
    func makeOutputs(typeInfo: TypeInfo) async throws -> Outputs? {
        switch typeInfo.definition {
        case .array(_):
            let output = await makeArray(typeInfo: typeInfo)
            return [output]
        case .composite(_):
            return try await makeComposite(typeInfo: typeInfo, extendExistingTypes: false)
        case .variant(_):
            return try await makeEnum(typeInfo: typeInfo)
        default:
            return nil
        }
    }
}
