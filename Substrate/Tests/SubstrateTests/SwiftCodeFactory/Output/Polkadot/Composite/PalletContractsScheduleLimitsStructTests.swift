//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class PalletContractsScheduleLimitsStructTests: XCTestCase {
    
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
    
    func testMakeStructCode() async throws {
        let output = try await factory.makeCompositeStruct(typeInfo: typeInfo)
        let expected = try JSONDecoder().decode(SwiftCode.Lines.self, from: .expectedStructCode)

        XCTAssertEqual( output.code.lines, expected )
    }
    
    func testMakeSCALEDecodableExtensionCode() async throws {
        let output = try await factory.makeCompositeSCALEDecodable(typeInfo: typeInfo)
        let expected = try JSONDecoder().decode(SwiftCode.Lines.self, from: .expectedSCALEDecodableExtensionCode)

        XCTAssertEqual(output.code.lines, expected)
    }
    
    func testMakePathCode() async throws {
        let output = factory.makePathDeclaration(path: typeInfo.path)
        let expected = try JSONDecoder().decode(SwiftCode.Lines.self, from: .expectedPathExtensionCode)
        
        XCTAssertEqual(output.code.lines, expected)
    }
}


fileprivate extension Data {
    static var typeInfo = """
        {
            "path": [
                "pallet_contracts",
                "schedule",
                "Limits"
            ],
            "params": [],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "event_topics",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "stack_height",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "globals",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "parameters",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "memory_pages",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "table_size",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "br_table_size",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "subject_len",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "call_depth",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "payload_len",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "code_len",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        }
                    ]
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
        }]
    """.data(using: .utf8)!
    
    static var expectedSwiftCode = #"""
        ["struct PalletContractsScheduleLimits: CompositeType {", "let eventTopics: U32", "let stackHeight: U32", "let globals: U32", "let parameters: U32", "let memoryPages: U32", "let tableSize: U32", "let brTableSize: U32", "let subjectLen: U32", "let callDepth: U32", "let payloadLen: U32", "let codeLen: U32", "}", "extension PalletContractsScheduleLimits: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "eventTopics = try decoder.decode(U32.self)", "stackHeight = try decoder.decode(U32.self)", "globals = try decoder.decode(U32.self)", "parameters = try decoder.decode(U32.self)", "memoryPages = try decoder.decode(U32.self)", "tableSize = try decoder.decode(U32.self)", "brTableSize = try decoder.decode(U32.self)", "subjectLen = try decoder.decode(U32.self)", "callDepth = try decoder.decode(U32.self)", "payloadLen = try decoder.decode(U32.self)", "codeLen = try decoder.decode(U32.self)", "}", "}", "extension TypeInfo.Path {", "static let palletContractsScheduleLimits: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"Limits\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct PalletContractsScheduleLimits: CompositeType {", "let eventTopics: U32", "let stackHeight: U32", "let globals: U32", "let parameters: U32", "let memoryPages: U32", "let tableSize: U32", "let brTableSize: U32", "let subjectLen: U32", "let callDepth: U32", "let payloadLen: U32", "let codeLen: U32", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension PalletContractsScheduleLimits: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "eventTopics = try decoder.decode(U32.self)", "stackHeight = try decoder.decode(U32.self)", "globals = try decoder.decode(U32.self)", "parameters = try decoder.decode(U32.self)", "memoryPages = try decoder.decode(U32.self)", "tableSize = try decoder.decode(U32.self)", "brTableSize = try decoder.decode(U32.self)", "subjectLen = try decoder.decode(U32.self)", "callDepth = try decoder.decode(U32.self)", "payloadLen = try decoder.decode(U32.self)", "codeLen = try decoder.decode(U32.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let palletContractsScheduleLimits: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"Limits\"]", "}"]
    """#.data(using: .utf8)!
}
