//
//  Created by Steven Boynes on 3/31/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Path constant declaration.
    ///
    func makePathDeclaration(path: TypeInfo.Path) -> Output {
        let name = path.camelCased.lowercasingFirstLetter()
        var lines = SwiftCode.Lines()
        lines.append("extension TypeInfo.Path {")
        lines.append("static let \(name): TypeInfo.Path = \(path)")
        lines.append("}")
        let code = SwiftCode.Block(name: name, lines: lines)
        return Output(code: code)
    }
}
