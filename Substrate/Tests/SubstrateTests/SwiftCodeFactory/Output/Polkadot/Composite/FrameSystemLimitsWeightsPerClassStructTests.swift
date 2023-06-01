//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class FrameSystemLimitsWeightsPerClassStructTests: XCTestCase {
    
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

        XCTAssertEqual( outputs.count, 2 )
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
                "frame_system",
                "limits",
                "WeightsPerClass"
            ],
            "params": [],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "base_extrinsic",
                            "type": 8,
                            "typeName": "Weight",
                            "docs": []
                        },
                        {
                            "name": "max_extrinsic",
                            "type": 115,
                            "typeName": "Option<Weight>",
                            "docs": []
                        },
                        {
                            "name": "max_total",
                            "type": 115,
                            "typeName": "Option<Weight>",
                            "docs": []
                        },
                        {
                            "name": "reserved",
                            "type": 115,
                            "typeName": "Option<Weight>",
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
                "id": 8,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "primitive": "U64"
                    },
                    "docs": []
                }
            },
            {
                "id": 115,
                "type": {
                    "path": [
                        "Option"
                    ],
                    "params": [{
                        "name": "T",
                        "type": 8
                    }],
                    "def": {
                        "variant": {
                            "variants": [{
                                    "name": "None",
                                    "fields": [],
                                    "index": 0,
                                    "docs": []
                                },
                                {
                                    "name": "Some",
                                    "fields": [{
                                        "name": null,
                                        "type": 8,
                                        "typeName": null,
                                        "docs": []
                                    }],
                                    "index": 1,
                                    "docs": []
                                }
                            ]
                        }
                    },
                    "docs": []
                }
            }
        ]
    """.data(using: .utf8)!
    
    static var expectedSwiftCode = #"""
        ["struct FrameSystemLimitsWeightsPerClass: CompositeType {", "let baseExtrinsic: Weight", "let maxExtrinsic: Option<Weight>", "let maxTotal: Option<Weight>", "let reserved: Option<Weight>", "}", "extension FrameSystemLimitsWeightsPerClass: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "baseExtrinsic = try decoder.decode(Weight.self)", "maxExtrinsic = try decoder.decode(Option<Weight>.self)", "maxTotal = try decoder.decode(Option<Weight>.self)", "reserved = try decoder.decode(Option<Weight>.self)", "}", "}", "extension TypeInfo.Path {", "static let frameSystemLimitsWeightsPerClass: TypeInfo.Path = [\"frame_system\", \"limits\", \"WeightsPerClass\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct FrameSystemLimitsWeightsPerClass: CompositeType {", "let baseExtrinsic: Weight", "let maxExtrinsic: Option<Weight>", "let maxTotal: Option<Weight>", "let reserved: Option<Weight>", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension FrameSystemLimitsWeightsPerClass: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "baseExtrinsic = try decoder.decode(Weight.self)", "maxExtrinsic = try decoder.decode(Option<Weight>.self)", "maxTotal = try decoder.decode(Option<Weight>.self)", "reserved = try decoder.decode(Option<Weight>.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let frameSystemLimitsWeightsPerClass: TypeInfo.Path = [\"frame_system\", \"limits\", \"WeightsPerClass\"]", "}"]
    """#.data(using: .utf8)!
}
