//
//  Created by Steven Boynes on 2/18/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension Metadata {
    /// A struct representing Pallet metadata.
    ///
    struct Pallet {
        let name: String
        let constants: [Constant]
    }
}


extension Metadata.Pallet: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case constants = "constants"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        constants = try container.decode([Metadata.Pallet.Constant].self, forKey: .constants)
    }
}

/*
pub struct PalletMetadata<T: Form = MetaForm> {
    pub name: T::String,
    pub storage: Option<PalletStorageMetadata<T>>,
    pub calls: Option<PalletCallMetadata<T>>,
    pub event: Option<PalletEventMetadata<T>>,
    pub constants: Vec<PalletConstantMetadata<T>>,
    pub error: Option<PalletErrorMetadata<T>>,
    pub index: u8,
}
*/
