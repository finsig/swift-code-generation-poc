//
//  Created by Steven Boynes on 3/4/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension DecodingError {
    /// An extension to create type mismatch error with container context.
    ///
    static func typeMismatch(_ type: Any.Type, container: SingleValueDecodingContainer, description: String) -> DecodingError {
        let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: description)
        return DecodingError.typeMismatch(type, context)
    }
}
