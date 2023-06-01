//
//  Created by Steven Boynes on 3/7/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for Tuple type.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeDefTuple.html)
    ///
    struct Tuple {
        static let key = "tuple"
        let typeIdentifiers: [TypeInfo.Registry.Entry.Identifier]
    }
}


extension TypeInfo.Definition.Tuple: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.Tuple
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let dictionary = try? container.decode(Dictionary<String,[TypeInfo.Registry.Entry.Identifier]>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard let identifierArray = dictionary[Definition.key] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid type definition dictionary.")
        }
        self = .init(typeIdentifiers: identifierArray)
    }
}
