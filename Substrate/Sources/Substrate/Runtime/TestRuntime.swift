//
//  Created by Steven Boynes on 5/20/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

class TestRuntime: Runtime {
    //override var name: String { return "Substrate" }
    override var name: String { return "Polkadot" }
    
    /*
    override var metadataURL: URL { return Bundle.module.url(forResource: "metadata-v14-substrate", withExtension: "json")! }
    override var typeInfoURL: URL { return Bundle.module.url(forResource: "metadata-v14-substrate-type-info", withExtension: "json")! }
    override var expectedSwiftCodeURL: URL { return Bundle.module.url(forResource: "metadata-v14-substrate-expected-swift-code", withExtension: "json")! }
    */
    
    override var metadataURL: URL { return Bundle.module.url(forResource: "metadata-v14-polkadot", withExtension: "json")! }
    override var typeInfoURL: URL { return Bundle.module.url(forResource: "metadata-v14-polkadot-type-info", withExtension: "json")! }
    override var expectedSwiftCodeURL: URL { return Bundle.module.url(forResource: "metadata-v14-polkadot-expected-swift-code", withExtension: "json")! }
     
}
