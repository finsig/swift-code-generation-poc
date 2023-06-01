//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Swift representation for a Composite Portable Type.
    ///
    func makeComposite(typeInfo: TypeInfo, extendExistingTypes: Bool = true) async throws -> Outputs {
        switch typeInfo.definition {
        case .composite(let composite):

            if (composite.isCompositeTypealias == true) {
                guard let field = composite.fields.first else {
                    fatalError()
                }
                guard let fieldTypeInfo = try registry.typeInfo(for: field.type) else {
                    fatalError()
                }
                let existingTypeName = await String(describing: fieldTypeInfo, registry: registry)
                
                let path = SwiftCode.Path(typeInfo)
                let name = path.joined(separator: "+")
                var code = SwiftCode.Block(name: name, lines: SwiftCode.Lines())
                code.lines.append("typealias \(path.last!) = \(existingTypeName)")
                let wrapped = wrap(code: code, path: path, extendExistingTypes: extendExistingTypes)
                return [Output(code: wrapped, path: .typealias)]
            }
            else {
                let compositeStruct = try await makeCompositeStruct(typeInfo: typeInfo, extendExistingTypes: extendExistingTypes)
                let SCALEDecodableStructExtension = try await makeCompositeSCALEDecodable(typeInfo: typeInfo)
                let pathExtension = makePathDeclaration(path: typeInfo.path)
                let lines = compositeStruct.code.lines + SCALEDecodableStructExtension.code.lines + pathExtension.code.lines

                let name = SwiftCode.Path(typeInfo).joined(separator: "+")
                
                let code = SwiftCode.Block(name: name, lines: lines)
                let output = Output(code: code, path: Output.Path(typeInfo: typeInfo))
                
                var outputs = try await makeCompositeFieldTypealiases(typeInfo: typeInfo, extendExistingTypes: extendExistingTypes)
                let deduplicatedOutputs = Array( Set(outputs) )
                outputs = deduplicatedOutputs
                outputs.append(output)
                
                return outputs
            }
        default:
            fatalError()
        }
    }
}
