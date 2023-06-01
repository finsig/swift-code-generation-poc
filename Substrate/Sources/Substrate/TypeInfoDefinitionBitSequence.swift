//
//  Created by Steven Boynes on 5/20/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for a sequence of bits.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeDefBitSequence.html)
    ///
    struct BitSequence {
        static let key = "bitSequence"
        let bitStoreType: TypeInfo.Registry.Entry.Identifier
        let bitOrderType: TypeInfo.Registry.Entry.Identifier
    }
}


extension TypeInfo.Definition.BitSequence: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.BitSequence
    fileprivate typealias BitSequenceDictionary = Dictionary<String,U32>
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let dictionary = try? container.decode(Dictionary<String,BitSequenceDictionary>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard let bitSequenceDictionary = dictionary[Definition.key] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid bit sequence definition dictionary.")
        }
        guard let bitStoreType = bitSequenceDictionary[.bitStoreType], let bitOrderType = bitSequenceDictionary[.bitOrderType] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid bit sequence definition values.")
        }
        self = .init(bitStoreType: TypeInfo.Registry.Entry.Identifier(bitStoreType), bitOrderType: TypeInfo.Registry.Entry.Identifier(bitOrderType))
    }
}

fileprivate extension String {
    static let bitStoreType = "bitStoreType"
    static let bitOrderType = "bitOrderType"
}
