//
//  Created by Steven Boynes on 3/28/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition.Variant {
    ///
    /// A Rust Option Enum variant definition.
    ///
    /// - SeeAlso:
    /// [Rust Documentation](https://doc.rust-lang.org/book/ch06-01-defining-an-enum.html)
    ///
    var isOptionEnum: Bool {
        return variants.map({ $0.name.lowercased() }).sorted() == ["none", "some"].sorted()
    }

    var some: TypeInfo.Definition.Variant.Value? {
        return variants.filter({ $0.name.caseInsensitiveCompare("Some") == .orderedSame }).last
    }
}
