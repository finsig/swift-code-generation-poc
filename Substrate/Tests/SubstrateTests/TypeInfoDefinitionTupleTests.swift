//
//  Created by Steven Boynes on 3/7/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionTupleTests: XCTestCase {
    func testDecode() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Definition.Tuple.self, from: .tuple) )
    }
}


fileprivate extension Data {
    static var tuple = """
        {
            "tuple": [
                6,
                541
            ]
        }
    """.data(using: .utf8)!
}
