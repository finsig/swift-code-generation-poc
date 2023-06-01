//
//  Created by Steven Boynes on 3/4/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class MetadataPalletConstantTests: XCTestCase {
    func testDecode() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(Metadata.Pallet.Constant.self, from: .babeEpochDuration) )
    }
}


fileprivate extension Data {
    static var babeEpochDuration = """
        {
            "name": "EpochDuration",
            "type": 8,
            "value": "0xc800000000000000",
            "docs": [
                " The amount of time, in slots, that each epoch should last.",
                " NOTE: Currently it is not possible to change the epoch duration after",
                " the chain has started. Attempting to do so will brick block production."
            ]
        }
    """.data(using: .utf8)!
}
