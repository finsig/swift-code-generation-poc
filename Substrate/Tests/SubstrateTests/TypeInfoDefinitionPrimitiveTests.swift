//
//  Created by Steven Boynes on 3/1/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionPrimitiveTests: XCTestCase {
    func testDecodeU64() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Definition.Primitive.self, from: .u64) )
    }
}


fileprivate extension Data {
    static var u64 = """
        {
            "primitive": "U64"
        }
    """.data(using: .utf8)!
}
