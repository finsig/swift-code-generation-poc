//
//  Created by Steven Boynes on 3/6/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for Sequence type.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeDefSequence.html)
    ///
    struct Sequence {
        static let key = "sequence"
        let type: TypeInfo.Registry.Entry.Identifier
    }
}


extension TypeInfo.Definition.Sequence: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.Sequence
    fileprivate typealias TypeDictionary = Dictionary<String,TypeInfo.Registry.Entry.Identifier>
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let dictionary = try? container.decode(Dictionary<String,TypeDictionary>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard let typeDictionary = dictionary[Definition.key] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid type definition dictionary.")
        }
        guard let identifier = typeDictionary[.type] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid type definition value.")
        }
        self = .init(type: identifier)
    }
}

fileprivate extension String {
    static let type = "type"
}
