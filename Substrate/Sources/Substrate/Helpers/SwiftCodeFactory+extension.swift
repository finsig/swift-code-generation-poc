//
//  Created by Steven Boynes on 5/21/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCodeFactory {
    convenience init(runtime: Runtime) async throws {
        let registry = await TypeInfo.Registry(url: runtime.typeInfoURL)
        self.init(registry: registry)
    }
}
