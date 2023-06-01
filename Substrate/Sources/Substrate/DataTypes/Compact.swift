//
//  Created by Steven Boynes on 2/23/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// An unsigned integer value that is stored with SCALE "compact" encoding.
///
/// - SeeAlso:
/// [Substrate Documentation](https://docs.substrate.io/v3/advanced/scale-codec/#compactgeneral-integers)
///
struct Compact<T: UnsignedInteger> where T: Codable {
    let type: T.Type
    let value: T
}


extension Compact {
    init(_ value: T) {
        self.type = T.self
        self.value = value
    }
}

extension Compact: Equatable {
    static func == (lhs: Compact<T>, rhs: Compact<T>) -> Bool {
        return (lhs.value == rhs.value)
    }
}

extension Compact: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        type = T.self
        value = try container.decode(T.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}

extension Compact: SCALEDecodable {
    init(from decoder: SCALE.Decoder) throws {
        if T.self == U32.self {
            let value = try decoder.decode(U32.self, .compact)
            self = .init(type: T.self, value: U32(value) as! T)
        }
        else {
            fatalError("failed to scale decode compact")
        }
    }
}
