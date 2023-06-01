//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo.Registry {
    ///
    ///  A  registry entry.
    ///
    struct Entry {
        let identifier: Identifier
        let typeInfo: TypeInfo
    }
}


extension TypeInfo.Registry.Entry: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case typeInfo = "type"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        identifier = try container.decode(Identifier.self, forKey: .identifier)
        typeInfo = try container.decode(TypeInfo.self, forKey: .typeInfo)
    }
}
