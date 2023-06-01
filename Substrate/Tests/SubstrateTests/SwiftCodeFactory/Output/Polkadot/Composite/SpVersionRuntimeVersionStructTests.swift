//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class SpVersionRuntimeVersionStructTests: XCTestCase {
    
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

        XCTAssertEqual( outputs.count, 3 )
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
                "sp_version",
                "RuntimeVersion"
            ],
            "params": [],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "spec_name",
                            "type": 106,
                            "typeName": "RuntimeString",
                            "docs": []
                        },
                        {
                            "name": "impl_name",
                            "type": 106,
                            "typeName": "RuntimeString",
                            "docs": []
                        },
                        {
                            "name": "authoring_version",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "spec_version",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "impl_version",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "apis",
                            "type": 120,
                            "typeName": "ApisVec",
                            "docs": []
                        },
                        {
                            "name": "transaction_version",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "state_version",
                            "type": 2,
                            "typeName": "u8",
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
                "id": 2,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "primitive": "U8"
                    },
                    "docs": []
                }
            },
            {
                "id": 4,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "primitive": "U32"
                    },
                    "docs": []
                }
            },
            {
                "id": 106,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "primitive": "Str"
                    },
                    "docs": []
                }
            },
            {
                "id": 120,
                "type": {
                    "path": [
                        "Cow"
                    ],
                    "params": [{
                        "name": "T",
                        "type": 121
                    }],
                    "def": {
                        "composite": {
                            "fields": [{
                                "name": null,
                                "type": 121,
                                "typeName": null,
                                "docs": []
                            }]
                        }
                    },
                    "docs": []
                }
            },
            {
                "id": 121,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "sequence": {
                            "type": 122
                        }
                    },
                    "docs": []
                }
            },
            {
                "id": 122,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "tuple": [
                            123,
                            4
                        ]
                    },
                    "docs": []
                }
            },
            {
                "id": 123,
                "type": {
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
            }
        ]
    """.data(using: .utf8)!
    
    static var expectedSwiftCode = #"""
        ["extension Version {", "struct RuntimeVersion: CompositeType {", "let specName: RuntimeString", "let implName: RuntimeString", "let authoringVersion: U32", "let specVersion: U32", "let implVersion: U32", "let apis: ApisVec", "let transactionVersion: U32", "let stateVersion: U8", "}", "}", "extension Version.RuntimeVersion: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "specName = try decoder.decode(RuntimeString.self)", "implName = try decoder.decode(RuntimeString.self)", "authoringVersion = try decoder.decode(U32.self)", "specVersion = try decoder.decode(U32.self)", "implVersion = try decoder.decode(U32.self)", "apis = try decoder.decode(ApisVec.self)", "transactionVersion = try decoder.decode(U32.self)", "stateVersion = try decoder.decode(U8.self)", "}", "}", "extension TypeInfo.Path {", "static let spVersionRuntimeVersion: TypeInfo.Path = [\"sp_version\", \"RuntimeVersion\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["extension Version {", "struct RuntimeVersion: CompositeType {", "let specName: RuntimeString", "let implName: RuntimeString", "let authoringVersion: U32", "let specVersion: U32", "let implVersion: U32", "let apis: ApisVec", "let transactionVersion: U32", "let stateVersion: U8", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension Version.RuntimeVersion: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "specName = try decoder.decode(RuntimeString.self)", "implName = try decoder.decode(RuntimeString.self)", "authoringVersion = try decoder.decode(U32.self)", "specVersion = try decoder.decode(U32.self)", "implVersion = try decoder.decode(U32.self)", "apis = try decoder.decode(ApisVec.self)", "transactionVersion = try decoder.decode(U32.self)", "stateVersion = try decoder.decode(U8.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let spVersionRuntimeVersion: TypeInfo.Path = [\"sp_version\", \"RuntimeVersion\"]", "}"]
    """#.data(using: .utf8)!
}
