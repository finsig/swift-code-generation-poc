//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Definition.Composite {
    ///
    /// Definition for a Composite Field.
    ///
    struct Field {
        let name: Text?
        let type: TypeInfo.Registry.Entry.Identifier
        let typeName: Text?
        let docs: Vector<Text>
    }
}


extension TypeInfo.Definition.Composite.Field: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case typeName = "typeName"
        case docs = "docs"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(Text.self, forKey: .name)
        type = try container.decode(TypeInfo.Registry.Entry.Identifier.self, forKey: .type)
        typeName = try container.decodeIfPresent(Text.self, forKey: .typeName)?.uppercasingParameterTypeName()
        docs = try container.decode(Vector<Text>.self, forKey: .docs)
    }
}

fileprivate extension String {
    func uppercasingParameterTypeName() -> String {
        var components = components(separatedBy: "<")
        guard (components.indices.contains(1) == true) else {
            return self
        }
        components[1] = components[1].uppercasingFirstLetter()
        return components.joined(separator: "<")
    }
    
    mutating func uppercaseParameterTypeName() {
        self = self.uppercasingParameterTypeName()
    }
}
