//
//  Created by Steven Boynes on 3/31/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    ///
    ///  Make a Struct representing a Portable Type tuple.
    ///
    func makeTuple(tuple: Substrate.Tuple, name: String) -> SwiftCode.Lines {
        let elements = tuple.elements.map({ String(describing: $0) }).joined(separator: ", ")
        let count = tuple.elements.count
        
        var lines = ["struct \(name)Tuple: SCALEDecodable {"]
        lines.append("let tuple: STuple\(count)<\(elements)>")
        lines.append("init(from decoder: SCALE.Decoder) throws {")
        lines.append("tuple = try decoder.decode(STuple\(count)<\(elements)>.self)")
        lines.append("}")
        lines.append("}")
        lines.append("typealias \(name) = [\(name)Tuple]")
        return lines
    }
}
