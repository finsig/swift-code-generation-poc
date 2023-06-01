//
//  Created by Steven Boynes on 5/5/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Struct representation of a Pallet.
    ///
    func makePallet(metadata pallet: Metadata.Pallet) async throws -> Output {
        let name = String(describing: pallet)
        var code = SwiftCode.Block(name: name)
        code.lines.append("public struct \(name) {")
        let constants = try await makePalletConstants(metadata: pallet)
        code.lines.append(contentsOf: constants.code.lines)
        code.lines.append("}")

        return Output(code: code, path: .pallet)
    }
}
