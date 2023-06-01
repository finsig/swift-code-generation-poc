//
//  Created by Steven Boynes on 4/27/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Swift SCALE decodable Struct extension from a Composite Portable Type definition.
    ///
    func makeCompositeSCALEDecodable(typeInfo: TypeInfo) async throws -> Output {
        switch typeInfo.definition {
        case .composite(_):
            let name = SwiftCode.Path(typeInfo).joined(separator: ".")
            var lines = await makeSCALEDecodableInitializer(typeInfo: typeInfo)
            
            if typeInfo.parameters.isEmpty == true {
                lines.insert("extension \(name): SCALEDecodable {", at: .zero)
            }
            else {
                let parameterTypeNames = typeInfo.parameters.map({ $0.name.uppercasingFirstLetter() + ": SCALEDecodable" }).joined(separator: ",")
                lines.insert("extension \(name.removingParameters()): SCALEDecodable where " + parameterTypeNames + " {", at: .zero)
            }
            lines.append("}")
            
            let outputName = SwiftCode.Path(typeInfo).joined(separator: "+")
            let code = SwiftCode.Block(name: outputName, lines: lines)
            return Output(code: code)
        default:
            fatalError()
        }
    }
}


fileprivate extension SwiftCodeFactory {
    func makeSCALEDecodableInitializer(typeInfo: TypeInfo) async -> SwiftCode.Lines {
        var lines = ["init(from decoder: SCALE.Decoder) throws {"]
        switch typeInfo.definition {
        case .composite(let composite):
            for field in composite.fields {
                guard let statement = await makeCompositeFieldAssignment(field: field, typeInfo: typeInfo) else {
                    continue
                }
                lines.append(statement)
            }
        default:
            fatalError()
        }
        lines.append("}")
        return lines
    }
}

fileprivate extension SwiftCodeFactory {
    func makeCompositeFieldAssignment(field: TypeInfo.Definition.Composite.Field, typeInfo: TypeInfo) async -> SwiftCode.Line? {
        guard let name = field.name?.camelCased(fromSeparator: "_").replacingUnallowedCharacters().lowercasingFirstLetter() else {
            return nil
        }
        let typeName = try! await String(describingTypeName: field, registry: registry)
        return "\(name) = try decoder.decode(\(typeName).self)"
    }
}
