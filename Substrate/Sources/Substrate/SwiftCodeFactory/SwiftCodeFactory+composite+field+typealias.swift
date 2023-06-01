//
//  Created by Steven Boynes on 5/4/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    func makeCompositeFieldTypealiases(typeInfo: TypeInfo, extendExistingTypes: Bool = true) async throws -> Outputs {
        var outputs = Outputs()
        switch typeInfo.definition {
        case .composite(let composite):
            #warning("this should be similar to aliases for variant fields")
            /*
            for field in composite.fields {
               
                /*
                let typeName = try await String(describing: field, registry: registry)
                
                let fieldTypeInfo = try registry.typeInfo(for: field.type)
                let registryTypeName = await String(describing: fieldTypeInfo!, registry: registry)
                
                guard typeName.caseInsensitiveCompare(registryTypeName) != .orderedSame else {
                    continue
                }
                guard typeName.split(separator: "<").count == 1 else {
                    continue
                }
                guard typeName.caseInsensitiveCompare("T") != .orderedSame else {
                    continue
                }
                guard typeName.contains(":") == false else {
                    continue
                }
                guard TypeInfo.Definition.Primitive.Name.allCases.map({ $0.rawValue }).contains(typeName) == false else {
                    continue
                }
                
                if let fieldTypeInfo = fieldTypeInfo, fieldTypeInfo.path.count > 2 {
                    let structs = try makeNamespacePath(typeInfo: fieldTypeInfo)
                    outputs.append(contentsOf: structs)
                }

                if typeInfo.isExtension {
                    var path = SwiftCode.Path(typeInfo)
                    path.append(typeName)

                    print("* path_composite= \(path) typeName= \(typeName)")
                    
                    var code = SwiftCode.Block(name: path.joined(separator: "+"), lines: SwiftCode.Lines())
                    code.lines.append("typealias \(typeName) = \(registryTypeName)")
                    let wrapped = wrap(code: code, path: path, extendExistingTypes: extendExistingTypes)
                    let output = Output(code: wrapped, path: .typealias)
                    outputs.append(output)
                }
                 */
                
            }
             */
            guard typeInfo.path.count > 1 else {
                return Outputs()
            }
            
            let blockName = SwiftCode.Path(typeInfo).joined(separator: "+")
            let path = SwiftCode.Path(typeInfo).dropLast().joined(separator: ".")
            let name = await String(describing: typeInfo, registry: registry)

            

            // Create typealiases for parameters
            let nonGenericParameters = typeInfo.parameters.filter({ $0.type != nil && $0.name.count > 1})
            if nonGenericParameters.isEmpty == false {
                for parameter in nonGenericParameters {
                    guard let type = parameter.type, let typeInfo = try registry.typeInfo(for: type) else {
                        continue
                    }
                    let existingTypeName = await String(describing: typeInfo, registry: registry)
                
    
                    guard path.contains("<") == false else {
                        continue
                    }
                    guard parameter.name.caseInsensitiveCompare(existingTypeName) != .orderedSame else {
                        continue
                    }
                    
                    let blockName = path.replacingOccurrences(of: ".", with: "+") + "+" + parameter.name
                    var code = SwiftCode.Block(name: blockName)
                    code.lines.append("extension \(path) {")
                    code.lines.append("typealias \(parameter.name) = \(existingTypeName)")
                    code.lines.append("}")
                    outputs.append(Output(code: code, path: .typealias))
                    print("alias code  = 'typealias \(parameter.name) = \(existingTypeName)' \(path) ")
                }
            }

            for field in composite.fields {
                guard let name = field.name else {
                    continue
                }

                let typeInfo = try registry.typeInfo(for: field.type)!
                let existingTypeName = await String(describing: typeInfo, registry: registry)
                let aliasName = name.camelCased(fromSeparator: "_").uppercasingFirstLetter()
                let blockName = path.appending(".").appending(aliasName).replacingOccurrences(of: ".", with: "+")
 
                guard aliasName.caseInsensitiveCompare(existingTypeName) != .orderedSame else {
                    continue
                }
                guard let typeName = field.typeName, typeName.contains("::") == false else {
                    continue
                }
                guard let typeName = field.typeName, typeName.contains("<") == false else {
                    continue
                }
                var code = SwiftCode.Block(name: blockName)
                code.lines.append("extension \(path) {")
                code.lines.append("typealias \(aliasName) = \(existingTypeName)")
                code.lines.append("}")
                
                print("alias code= \(code) field.name= \(name) field.typeName= \(field.typeName)")
                outputs.append(Output(code: code, path: .typealias))
            }
            
        default:
            fatalError()
        }
        return outputs
    }
}
