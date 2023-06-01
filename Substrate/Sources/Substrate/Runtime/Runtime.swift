//
//  Created by Steven Boynes on 5/20/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

class Runtime {
    internal var name: String { return "Substrate" }
    
    var versionKey: Metadata.Version.Key { return "v14" }
    var metadataURL: URL { return Bundle.module.url(forResource: "metadata-v14-substrate", withExtension: "json")! }
    var typeInfoURL: URL { return Bundle.module.url(forResource: "metadata-v14-substrate-type-info", withExtension: "json")! }
    var expectedSwiftCodeURL: URL { return Bundle.module.url(forResource: "metadata-v14-substrate-expected-swift-code", withExtension: "json")! }
}
