//
//  Created by Steven Boynes on 5/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Swift Struct to represent a Composite Portable Type.
    ///
    func makeCompositeStruct(typeInfo: TypeInfo, extendExistingTypes: Bool = true) async throws -> Output {
        switch typeInfo.definition {
        case .composite(_):
            let path = SwiftCode.Path(typeInfo)
            let name = await String(describing: typeInfo, registry: registry)
            
            if typeInfo.isExtension {
                let code = try await makeStruct(name: name, typeInfo: typeInfo)
                let wrapped = wrap(code: code, path: path, extendExistingTypes: extendExistingTypes)
                return Output(code: wrapped)
            }
            else {
                var code = try await makeStruct(name: name, typeInfo: typeInfo)
                code.name = path.joined(separator: "+")
                return Output(code: code)
            }
        default:
            fatalError()
        }
    }
}


internal extension SwiftCodeFactory {
    func wrap(code: SwiftCode.Block, path: TypeInfo.Path, extendExistingTypes: Bool = true) -> SwiftCode.Block {
        guard extendExistingTypes == true else {
            return code
        }
        var wrapped = SwiftCode.Block(name: path.joined(separator: "+"), lines: SwiftCode.Lines())
        
        var name = path.dropLast().joined(separator: ".")
        if name.isEmpty {
            name = "Substrate"
        }
        
        
        wrapped.lines.append("extension \(name) {")
        wrapped.lines.append(contentsOf: code.lines)
        wrapped.lines.append("}")
        return wrapped
    }
}

fileprivate extension SwiftCodeFactory {
    func makeStruct(name: String, typeInfo: TypeInfo) async throws -> SwiftCode.Block {
        switch typeInfo.definition {
        case .composite(let composite):
            var lines = ["struct \(name): CompositeType {"]
            for field in composite.fields {
                guard let name = field.name?.camelCased(fromSeparator: "_").replacingUnallowedCharacters().lowercasingFirstLetter() else {
                    continue
                }
                let line = "let \(name): \( try await String(describingTypeName: field, registry: registry) )"
                lines.append(line)
            }
            lines.append("}")
            return SwiftCode.Block(name: name, lines: lines)
        default:
            fatalError()
        }
    }
}
