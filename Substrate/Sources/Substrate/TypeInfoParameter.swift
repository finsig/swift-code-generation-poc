//
//  Created by Steven Boynes on 5/12/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo {
    ///
    /// A generic type parameter.
    ///
    /// - SeeAlso:
    /// - [Substrate Documentation](https://docs.substrate.io/rustdocs/latest/scale_info/struct.TypeParameter.html)
    ///
    struct Parameter {
        let name: Text
        let type: Registry.Entry.Identifier?
    }
}

extension TypeInfo.Parameter: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(Text.self, forKey: .name)
        type = try container.decodeIfPresent(TypeInfo.Registry.Entry.Identifier.self, forKey: .type)
    }
}
