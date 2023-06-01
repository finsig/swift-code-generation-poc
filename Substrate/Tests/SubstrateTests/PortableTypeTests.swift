//
//  Created by Steven Boynes on 3/1/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class PortableTypeTests: XCTestCase {
    func testDecodeU64PrimitiveDefinition() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.self, from: .u64) )
    }
}


fileprivate extension Data {
    static var u64 = """
        {
            "path": [],
            "params": [],
            "def": {
                "primitive": "U64"
            },
            "docs": []
        }
    """.data(using: .utf8)!
}
