//
//  Created by Steven Boynes on 3/2/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for a Compact wrapper type.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeDefCompact.html)
    ///
    struct Compact: Equatable {
        static let key = "compact"
        var value: UInt
    }
}


extension TypeInfo.Definition.Compact: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.Compact
    fileprivate typealias TypeDictionary = Dictionary<String,UInt>
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let dictionary = try? container.decode(Dictionary<String,TypeDictionary>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard let typeDictionary = dictionary[Definition.key] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid type definition dictionary.")
        }
        guard let uInt = typeDictionary[.type] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid type definition value.")
        }
        self = .init(value: uInt)
    }
}

fileprivate extension String {
    static let type = "type"
}
