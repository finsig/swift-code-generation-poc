//
//  Created by Steven Boynes on 3/6/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionSequenceTests: XCTestCase {
    func testDecode() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Definition.Sequence.self, from: .sequence) )
    }
}


fileprivate extension Data {
    static var sequence = """
        {
            "sequence": {
                "type": 2
            }
        }
    """.data(using: .utf8)!
}
