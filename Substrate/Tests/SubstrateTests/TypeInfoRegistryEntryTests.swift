//
//  Created by Steven Boynes on 3/1/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoRegistryEntryTests: XCTestCase {
    func testDecodeRegistryLookupIdentifier8() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Registry.Entry.self, from: .lookupIdentifier8) )
    }
}


fileprivate extension Data {
    static var lookupIdentifier8 = """
        {
            "id": 8,
            "type": {
                "path": [],
                "params": [],
                "def": {
                    "primitive": "U64"
                },
                "docs": []
            }
        }
    """.data(using: .utf8)!
}
