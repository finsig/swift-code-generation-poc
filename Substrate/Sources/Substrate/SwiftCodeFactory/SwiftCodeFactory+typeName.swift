//
//  Created by Steven Boynes on 5/13/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Returns the Swift Type name for a registry entry.
    ///
    func typeName(for identifier: TypeInfo.Registry.Entry.Identifier) async throws -> String {
        guard let typeInfo = try registry.typeInfo(for: identifier) else {
            fatalError("identifier= \(identifier) registry.count=\(registry.entries.count)")
        }
        switch typeInfo.definition {
        case .array(let array):
            let parameter = try! await typeName(for: array.type)
            return String(describing: array) + "<" + parameter + ">"
            
        case .bitSequence(_):
            return "BitVector"
        
        case .compact(_):
            return "Compact"
            
        case .composite(let composite):
            if let field = composite.fields.last, composite.fields.count == 1 && field.name == nil {
                if typeInfo.parameters.isEmpty {
                    return try await typeName(for: field.type)
                }
                else {
                    return try await typeName(for: field.type) + "<" + typeInfo.parameters.map({ $0.name }).joined(separator: ",") + ">"
                }
            }
            else {
                return String(describing: typeInfo)
            }

        case .primitive(let primitive):
            return primitive.name.rawValue.uppercasingFirstLetter()
            
        case .sequence(let sequence):
            guard let typeInfo = try registry.typeInfo(for: sequence.type) else {
                fatalError()
            }
            switch typeInfo.definition {
            case .primitive(let primitive):
                let parameter = primitive.name.rawValue.uppercasingFirstLetter()
                return "Vec<\(parameter)>"

            case .composite(_):
                if typeInfo.isGenericType {
                    let parameterType = typeInfo.parameters.map({ $0.type }).last
                    let parameter = try await typeName(for: parameterType!!).uppercasingFirstLetter()
                    return "Vec" + "<" + typeInfo.path.camelCased + "<" + parameter + ">" + ">"
                }
                else {
                    return "Vec" + "<" + String(describing: typeInfo) + ">"
                }
            case .compact(_):
                return "Compact"
            case .tuple(let tuple):
                var types = [String]()
                for identifier in tuple.typeIdentifiers {
                    guard let typeInfo = try registry.typeInfo(for: identifier) else {
                        continue
                    }
                    types.append( await String(describing: typeInfo, registry: registry) )
                }
                return "(" + types.joined(separator: ",") + ")"
                
            default:
                fatalError("identifier= \(identifier) sequence= \(sequence)")
            }
            
        case .tuple(let tuple):
            var types = [String]()
            for identifier in tuple.typeIdentifiers {
                guard let typeInfo = try registry.typeInfo(for: identifier) else {
                    continue
                }
                types.append( await String(describing: typeInfo, registry: registry) )
            }
            return "(" + types.joined(separator: ",") + ")"
            
        case .variant(let variant):
            if variant.isOptionEnum {
                guard let value = variant.variants.filter({ $0.name.caseInsensitiveCompare("some") == .orderedSame }).last else {
                    fatalError()
                }
                guard let field = value.fields.first else {
                    fatalError()
                }
                guard let typeName = try? await typeName(for: field.type) else {
                    fatalError()
                }
                return "Optional" + "<" + typeName + ">"
            }
            else {
                return String(describing: typeInfo)
            }
        }
    }
}
