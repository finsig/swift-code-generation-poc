//
//  Created by Steven Boynes on 3/3/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class TypeInfoDefinitionArrayTests: XCTestCase {
    func testDecode() throws {
        XCTAssertNoThrow( try JSONDecoder().decode(TypeInfo.Definition.Array.self, from: .array) )
    }
    
    func testDecodeArray() throws {
        let array = try JSONDecoder().decode(TypeInfo.Definition.Array.self, from: .array)
        
        XCTAssertEqual( array.length, U32(32) )
        XCTAssertEqual( array.type, TypeInfo.Registry.Entry.Identifier( U32(2) ) )
    }
}


fileprivate extension Data {
    static var array = """
        {
            "array": {
                "len": 32,
                "type": 2
            }
        }
    """.data(using: .utf8)!
}
