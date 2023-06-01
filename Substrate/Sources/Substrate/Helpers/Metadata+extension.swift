//
//  Created by Steven Boynes on 5/21/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension Metadata {
    static func pallet(name: String, runtime: Runtime, version key: Metadata.Version.Key) throws -> Metadata.Pallet? {
        let metadata = try JSONDecoder().decode(Metadata.self, from: Data(contentsOf: runtime.metadataURL))
        let palletMetadata = metadata.version[key]?.pallets.filter({
            $0.name.caseInsensitiveCompare(name) == .orderedSame
        }).last
        if palletMetadata == nil {
            return try pallet(name: name, runtime: Runtime(), version: key)
        }
        return palletMetadata
    }
}
