//
//  Created by Steven Boynes on 2/2/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

struct FRAME {}

extension FRAME {
    struct System {}
}


protocol FRAMESystemConfig {
    associatedtype AccountId
    associatedtype Hash
}

extension FRAME.System {
    typealias Config = FRAMESystemConfig
}
