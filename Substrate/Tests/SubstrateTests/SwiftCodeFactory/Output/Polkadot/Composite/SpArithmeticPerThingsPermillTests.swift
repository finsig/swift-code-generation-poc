//
//  Created by Steven Boynes on 3/28/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class SpArithmeticPerThingsPermillTests: XCTestCase {
    
    private var typeInfo: TypeInfo!
    private var registry: TypeInfo.Registry!
    private var factory: SwiftCodeFactory!
    
    override func setUp() async throws {
        typeInfo = try JSONDecoder().decode(TypeInfo.self, from: .typeInfo)
        registry = TypeInfo.Registry(json: .registry)
        factory = SwiftCodeFactory(registry: registry)
    }
    
    func testMakeSwiftCode() async throws {
        let outputs = try await factory.makeComposite(typeInfo: typeInfo)
        let expected = try JSONDecoder().decode(SwiftCode.Lines.self, from: .expectedSwiftCode)
        
        XCTAssertEqual( outputs.count, 1 )
        XCTAssertEqual( outputs.last?.code.lines, expected )
    }
    
    func testMakeFullyQualifiedTypealiasCode() async throws {
        let outputs = try await factory.makeTypealiasDeclaration(typeInfo: typeInfo)
        let expected = try JSONDecoder().decode(SwiftCode.Lines.self, from: .expectedFullyQualifiedTypealias)
        
        XCTAssertEqual( outputs.count, 1 )
        XCTAssertEqual( outputs.last?.code.lines, expected )
    }
}


fileprivate extension Data {
    static var typeInfo = """
        {
            "path": [
                "sp_arithmetic",
                "per_things",
                "Permill"
            ],
            "params": [],
            "def": {
                "composite": {
                    "fields": [{
                        "name": null,
                        "type": 4,
                        "typeName": "u32",
                        "docs": []
                    }]
                }
            },
            "docs": []
        }
    """.data(using: .utf8)!
    
    static var registry = """
        [{
                "id": 4,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "primitive": "U32"
                    },
                    "docs": []
                }
            }
        ]
    """.data(using: .utf8)!
    
    static var expectedSwiftCode = #"""
        ["extension Arithmetic.PerThings {", "typealias Permill = U32", "}"]
    """#.data(using: .utf8)!
    
    static var expectedFullyQualifiedTypealias = #"""
        ["typealias Arithmetic.PerThings.Permill = U32"]
    """#.data(using: .utf8)!
}
