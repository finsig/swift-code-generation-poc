//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Swift fixed capacity array Struct from type definition.
    ///
    func makeArray(typeInfo: TypeInfo) async -> Output {
        switch typeInfo.definition {
        case .array(let array):
            let code = await makeArray(definition: array)
            return Output(code: code, path: Output.Path(typeInfo: typeInfo))
        default:
            fatalError()
        }
    }
    
    func makeArray(definition: TypeInfo.Definition.Array) async -> SwiftCode.Block {
        let name = String(describing: definition)
        var lines = ["struct \(name)<T: SCALEDecodable>: FixedCapacityArray {"]
        lines.append("static var capacity: U32 { return .capacity }")
        lines.append("var value: [T] = [T]()")
        lines.append("}")
        lines.append(contentsOf: SCALEDecodableExtensionDeclaration(name: name))
        lines.append(contentsOf: U32ExtensionDeclaration(capacity: definition.length))
        return SwiftCode.Block(name: name, lines: lines)
    }
}

fileprivate typealias SCALEDecodableExtensionDeclaration = SwiftCode.Lines

extension SCALEDecodableExtensionDeclaration {
    init(name: String) {
        var lines = ["extension \(name): SCALEDecodable {"]
        lines.append("init(from decoder: SCALE.Decoder) throws {")
        lines.append("let capacity = UInt(\(name).capacity)")
        lines.append("value = try decoder.decode( .fixed(capacity) ) as [T]")
        lines.append("}")
        lines.append("}")
        self.init(array: lines)
    }
}

fileprivate typealias U32ExtensionDeclaration = SwiftCode.Lines

extension U32ExtensionDeclaration {
    init(capacity: U32) {
        var lines = ["fileprivate extension U32 {"]
        lines.append("static let capacity = U32(\(capacity))")
        lines.append("}")
        self.init(array: lines)
    }
}
