//
//  Created by Steven Boynes on 2/18/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension Metadata.Pallet {
    /// A struct representing Pallet Constant metadata.
    ///
    /// - SeeAlso:
    /// [Substrate Documentation](https://docs.substrate.io/rustdocs//latest/frame_metadata/v14/struct.PalletConstantMetadata.html)
    ///
    struct Constant {
        let name: Text
        let type: TypeInfo.Registry.Entry.Identifier
        let value: Hexadecimal
        let docs: Vector<Text>
    }
}


extension Metadata.Pallet.Constant: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "type"
        case value = "value"
        case docs = "docs"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(Text.self, forKey: .name)
        type = try container.decode(TypeInfo.Registry.Entry.Identifier.self, forKey: .type)
        value = try container.decode(Hexadecimal.self, forKey: .value)
        docs = try container.decode(Vector<Text>.self, forKey: .docs)
    }
}
