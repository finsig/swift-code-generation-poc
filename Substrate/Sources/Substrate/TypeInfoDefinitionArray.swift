//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for a Substrate Array type.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeDefArray.html)
    ///
    struct Array {
        static let key = "array"
        let length: U32
        let type: TypeInfo.Registry.Entry.Identifier
    }
}


extension TypeInfo.Definition.Array: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.Array
    fileprivate typealias ArrayDictionary = Dictionary<String,U32>
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        guard let dictionary = try? container.decode(Dictionary<String,ArrayDictionary>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard let arrayDictionary = dictionary[Definition.key] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid array definition dictionary.")
        }
        guard let length = arrayDictionary[.length], let type = arrayDictionary[.type] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid array definition values.")
        }
        self = .init(length: length, type: TypeInfo.Registry.Entry.Identifier(type))
    }
}

fileprivate extension String {
    static let length = "len"
    static let type = "type"
}

/*
 /** @name Si1TypeDefArray */
 export interface Si1TypeDefArray extends Struct {
   readonly len: u32;
   readonly type: Si1LookupTypeId;
 }
 */
