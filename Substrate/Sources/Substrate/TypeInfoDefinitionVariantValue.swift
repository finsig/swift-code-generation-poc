//
//  Created by Steven Boynes on 3/22/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition.Variant {
    ///
    /// Definition for Variant data.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.Variant.html)
    ///
    struct Value {
        let name: Text
        let fields: Vector<TypeInfo.Definition.Composite.Field>
        let index: U8?
        let discriminant: U64?
        let docs: Vector<Text>
    }
}


extension TypeInfo.Definition.Variant.Value: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fields = "fields"
        case index = "index"
        case discriminant = "discriminant"
        case docs = "docs"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(Text.self, forKey: .name)
        fields = try container.decode(Vector<TypeInfo.Definition.Composite.Field>.self, forKey: .fields)
        index = try container.decodeIfPresent(U8.self, forKey: .index)
        discriminant = try container.decodeIfPresent(U64.self, forKey: .discriminant)
        docs = try container.decode(Vector<Text>.self, forKey: .docs)
    }
}
