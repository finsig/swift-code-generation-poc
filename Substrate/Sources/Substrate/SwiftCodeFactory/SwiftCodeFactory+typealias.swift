//
//  Created by Steven Boynes on 3/31/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Swift Typealias declaration for a composite Portable Type.
    ///
    func makeTypealiasDeclaration(typeInfo: TypeInfo) async throws -> Outputs {
        switch typeInfo.definition {
        case .composite(_):
            let name = String(describing: typeInfo)
            return try await makeFieldTypealiasDeclaration(name: name, typeInfo: typeInfo)
        default:
            fatalError()
        }
    }

    ///  Make a Swift Typealias declaration.
    ///
    func makeTypealiasDeclaration(name: String, existingTypeName: String) -> Output {
        let code = SwiftCode.Block(name: name, lines: ["typealias \(name) = \(existingTypeName)"])
        return Output(code: code)
    }
}


fileprivate extension SwiftCodeFactory {
    func makeFieldTypealiasDeclaration(name: String, typeInfo: TypeInfo) async throws -> Outputs {
        switch typeInfo.definition {
        case .composite(let composite):
            guard composite.fields.count == 1, composite.fields.first?.name == nil, let field = composite.fields.first else {
                fatalError()
            }
            
            guard let existingTypeName = field.typeName?.uppercasingFirstLetter() else {
                guard let existingTypeInfo = try registry.typeInfo(for: field.type) else {
                    fatalError()
                }
                let name = String(describing: typeInfo)
                let existingTypeName = await String(describing: existingTypeInfo, registry: registry)
                let output = makeTypealiasDeclaration(name: name, existingTypeName: existingTypeName)
                return [output]
            }
            
            var outputs = Outputs()
            outputs.append( makeTypealiasDeclaration(name: name, existingTypeName: existingTypeName) )
            
            let typeInfo = try registry.typeInfo(for: field.type)
            switch typeInfo?.definition {
            case .array(let array):
                let code = await makeArray(definition: array)
                outputs.append(Output(code: code))
            default:
                break
            }
            return outputs
        default:
            fatalError()
        }
    }
}
