//
//  Created by Steven Boynes on 3/4/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// A struct representing Substrate metadata.
///
/// - SeeAlso:
/// [Framework for Runtime Aggregation of Modularized Entities (FRAME)] (https://docs.substrate.io/v3/runtime/frame/)
///
struct Metadata {
    let magicNumber: Int
    let version: Dictionary<Version.Key, Version>
}


extension Metadata: Decodable {
    enum CodingKeys: String, CodingKey {
        case magicNumber = "magicNumber"
        case version = "metadata"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        magicNumber = try container.decode(Int.self, forKey: .magicNumber)
        version = try container.decode(Dictionary<Metadata.Version.Key, Metadata.Version>.self, forKey: .version)
    }
}
