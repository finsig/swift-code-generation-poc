//
//  Created by Steven Boynes on 5/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    func makePalletConstants(metadata pallet: Metadata.Pallet) async throws -> Output {
        var code = SwiftCode.Block()
        for constant in pallet.constants {
            let output = try await makePalletConstant(metadata: constant)
            code.lines.append(contentsOf: output.code.lines)
        }
        return Output(code: code)
    }
}


fileprivate extension SwiftCodeFactory {
    func makePalletConstant(metadata constant: Metadata.Pallet.Constant) async throws -> Output {
        let name = constant.name.lowercasingFirstLetter()
        let typeName = try await typeName(for: constant.type)
        
        var code = SwiftCode.Block(name: name)
        code.lines.append("static var \(name): \(typeName) = {")
        code.lines.append("return try! SCALEDecoder().decode(\(typeName).self, from: SCALE(\"\(constant.value.prefixedString)\"))")
        code.lines.append("}()")
        return Output(code: code)
    }
    
    func makePalletConstantTypealias(metadata constant: Metadata.Pallet.Constant) async throws -> Output {
        let name = constant.name.uppercasingFirstLetter()
        let existingTypeName = try await typeName(for: constant.type)
        return makeTypealiasDeclaration(name: name, existingTypeName: existingTypeName)
    }
    
    static func makePalletConstantTypealiasExtension(metadata constant: Metadata.Pallet.Constant) async throws -> Output {
        let name = constant.name.uppercasingFirstLetter()
        
        var code = SwiftCode.Block(name: name)
        code.lines.append("fileprivate extension \(name) {")
        code.lines.append("init(decoding scale: SCALE) {")
        code.lines.append("try! self.init(decoding: Data(hexadecimal: scale)! )")
        code.lines.append("}")
        code.lines.append("}")
        return Output(code: code)
    }
}
