//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionCompositeTests: XCTestCase {
    func testDecode() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Definition.Composite.self, from: .composite) )
    }
}


fileprivate extension Data {
    static var composite = """
        {
            "composite": {
                "fields": [{
                    "name": null,
                    "type": 1,
                    "typeName": "[u8; 32]",
                    "docs": []
                }]
            }
        }
    """.data(using: .utf8)!
}
