//
//  Created by Steven Boynes on 6/2/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension TypeInfo {
    var isExtension: Bool {
       return isFinalityGRANDPAExtension || isFRAMEExtension || isPalletExtension || isPolkadotExtension || isSubstratePrimitiveExtension
    }
    
    var isPalletExtension: Bool {
        guard let segment = path.first else {
            return false
        }
        return segment.contains("pallet_")
    }
    
    var isPolkadotExtension: Bool {
        guard let segment = path.first else {
            return false
        }
        return segment.contains("polkadot_")
    }
    
    var isSubstratePrimitiveExtension: Bool {
        guard let segment = path.first else {
            return false
        }
        return segment.contains("sp_")
    }
    
    var isFRAMEExtension: Bool {
        guard let segment = path.first else {
            return false
        }
        return segment.contains("frame_")
    }
    
    var isFinalityGRANDPAExtension: Bool {
        guard let segment = path.first else {
            return false
        }
        return segment.contains("finality_grandpa")
    }
}
