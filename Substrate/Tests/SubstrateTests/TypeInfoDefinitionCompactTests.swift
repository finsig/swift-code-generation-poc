//
//  Created by Steven Boynes on 3/1/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionCompactTests: XCTestCase {
    func testDecode() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Definition.Compact.self, from: .compact) )
    }
    
    func testDecodeCompactValue8() throws {
        let definition = try JSONDecoder().decode(TypeInfo.Definition.Compact.self, from: .compact)
        
        XCTAssertEqual( definition, TypeInfo.Definition.Compact(value: 8) )
    }
}


fileprivate extension Data {
    static var compact = """
        {
            "compact": {
                "type": 8
            }
        }
    """.data(using: .utf8)!
}
