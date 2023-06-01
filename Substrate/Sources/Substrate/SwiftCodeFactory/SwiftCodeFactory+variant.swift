//
//  Created by Steven Boynes on 6/16/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Swift Enum from a Variant type definition.
    ///
    func makeEnum(typeInfo: TypeInfo) async throws -> Outputs {
        switch typeInfo.definition {
        case .variant(let variant):
            if variant.isOptionEnum {
                return Outputs()
            }
            else {
                guard typeInfo.path.count > 1 else {
                    return Outputs()
                }
                
                let blockName = SwiftCode.Path(typeInfo).joined(separator: "+")
                let path = SwiftCode.Path(typeInfo).dropLast().joined(separator: ".")
                let name = await String(describing: typeInfo, registry: registry)

                var code = SwiftCode.Block(name: "\(blockName)")
                code.lines.append("extension \(path) {")
                code.lines.append("enum \(name) {")
                for variant in variant.variants {
                    code.lines.append("case \( try await String(describingVariant: variant, registry: registry) )")
                }
                code.lines.append("}")
                code.lines.append("}")
                
                var outputs = Outputs()
                
                outputs.append(Output(code: code, path: .enum))
                

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

                /*
                 Create typealiases for variant fields
                */
                
                for variant in variant.variants {
                    for field in variant.fields {
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
                }

                return outputs
            }
        default:
            fatalError()
        }
    }
}


fileprivate extension String {
    init(describingVariant variant: TypeInfo.Definition.Variant.Value, registry: TypeInfo.Registry) async throws {
        var types = Array<String>()
        var labels = Array<String?>()
        
        for field in variant.fields {
            types.append( try await String(describingTypeName: field, registry: registry) )
            labels.append(field.name)
        }
        
        assert(labels.count == types.count)
    
        if types.isEmpty == true {
            self.init( variant.name.lowercasingFirstLetter() )
        }
        else {
            if labels.compactMap({ $0 }).isEmpty == true {
                self.init( variant.name.lowercasingFirstLetter() + "(" + types.joined(separator:",") + ")" )
            }
            else {
                assert(labels.compactMap({ $0 }).count == types.count)
                
                var labeledTypes = Array<String>()
                for index in .zero...labels.compactMap({ $0 }).indices.last! {
                    let label = labels[index]!.camelCased(fromSeparator: "_").lowercasingFirstLetter()
                    labeledTypes.append( label + ": " + types[index] )
                }
                self.init( variant.name.lowercasingFirstLetter() + "(" + labeledTypes.joined(separator:", ") + ")" )
            }
        }
    }
}
