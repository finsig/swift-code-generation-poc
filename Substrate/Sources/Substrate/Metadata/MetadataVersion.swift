//
//  Created by Steven Boynes on 5/9/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension Metadata {
    struct Version {
        let pallets: [Metadata.Pallet]
        //let extrinsics: []
        //let TypeInfo.Registry.Identifier:
    }
}

extension Metadata.Version {
    typealias Key = String
}

extension Metadata.Version: Decodable {
    enum CodingKeys: String, CodingKey {
        case pallets = "pallets"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pallets = try container.decode([Metadata.Pallet].self, forKey: .pallets)
    }
}

extension Metadata.Version.Key {
    static let v14 = "v14"
}

