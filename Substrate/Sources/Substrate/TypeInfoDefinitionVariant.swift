//
//  Created by Steven Boynes on 3/22/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition {
    ///
    /// Definition for Variant.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeDefVariant.html)
    ///
    struct Variant {
        static let key = "variant"
        var variants: Vector<Variant.Value>
    }
}


extension TypeInfo.Definition.Variant: Decodable {
    fileprivate typealias Definition = TypeInfo.Definition.Variant
    fileprivate typealias VariantsDictionary = Dictionary<String,Vector<Definition.Value>>
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        guard let dictionary = try? container.decode(Dictionary<String,VariantsDictionary>.self) else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid definition dictionary.")
        }
        guard let variantsDictionary = dictionary[Definition.key] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid variants dictionary.")
        }
        guard let vector = variantsDictionary[.variants] else {
            throw DecodingError.typeMismatch(Definition.self, container: container, description: "Invalid variants dictionary value.")
        }
        self = .init(variants: vector)
    }
}

fileprivate extension String {
    static let variants = "variants"
}

/*
 Si0TypeDefVariant: {
     variants: 'Vec<Si0Variant>'
   }
 
 Si0Variant: {
     name: 'Text',
     fields: 'Vec<Si0Field>',
     index: 'Option<u8>',
     discriminant: 'Option<u64>',
     docs: 'Vec<Text>'
   }
 */
