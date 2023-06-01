//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionCompositeFieldTests: XCTestCase {
    func testDecode() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Definition.Composite.Field.self, from: .field) )
    }
}


fileprivate extension Data {
    static var field = """
        {
            "name": null,
            "type": 1,
            "typeName": "[u8; 32]",
            "docs": []
        }
    """.data(using: .utf8)!
}
