//
//  Created by Steven Boynes on 4/22/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class EightElementArrayTests: XCTestCase {
    
    private var typeInfo: TypeInfo!
    private var registry: TypeInfo.Registry!
    private var factory: SwiftCodeFactory!
    
    override func setUp() async throws {
        typeInfo = try JSONDecoder().decode(TypeInfo.self, from: .eightElementArray)
        registry = TypeInfo.Registry(json: .registry)
        factory = SwiftCodeFactory(registry: registry)
    }
    
    func testMakeSwiftCode() async throws {
        let output = await factory.makeArray(typeInfo: typeInfo)
        let expected = try JSONDecoder().decode(SwiftCode.Lines.self, from: .expectedStructDefinition)
        
        XCTAssertEqual(output.code.lines, expected)
    }
}

fileprivate extension Data {
    static var eightElementArray = """
        {
            "path": [],
            "params": [],
            "def": {
                "array": {
                    "len": 8,
                    "type": 2
                }
            },
            "docs": []
        }
    """.data(using: .utf8)!
    
    static var registry = """
        [{
            "id": 2,
            "type": {
                "path": [],
                "params": [],
                "def": {
                    "primitive": "U8"
                },
                "docs": []
            }
        }]
    """.data(using: .utf8)!
    
    static var expectedStructDefinition = #"""
        ["struct EightElementArray<T: SCALEDecodable>: FixedCapacityArray {", "static var capacity: U32 { return .capacity }", "var value: [T] = [T]()", "}", "extension EightElementArray: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "let capacity = UInt(EightElementArray.capacity)", "value = try decoder.decode( .fixed(capacity) ) as [T]", "}", "}", "fileprivate extension U32 {", "static let capacity = U32(8)", "}"]
    """#.data(using: .utf8)!
}
