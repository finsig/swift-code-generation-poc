//
//  Created by Steven Boynes on 3/1/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionTests: XCTestCase {
    func testDecodePrimitive() throws {
    }
    
    func testDecodeCompact() throws {
    }
}


fileprivate extension Data {
    static var primitiveU64 = """
        {
            "primitive": "U64"
        }
    """.data(using: .utf8)!
}
