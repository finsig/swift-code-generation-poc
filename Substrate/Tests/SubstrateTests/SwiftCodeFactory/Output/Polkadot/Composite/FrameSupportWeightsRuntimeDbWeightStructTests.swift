//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class FrameSupportWeightsRuntimeDbWeightStructTests: XCTestCase {
    
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
                "frame_support",
                "weights",
                "RuntimeDbWeight"
            ],
            "params": [],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "read",
                            "type": 8,
                            "typeName": "Weight",
                            "docs": []
                        },
                        {
                            "name": "write",
                            "type": 8,
                            "typeName": "Weight",
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
         }]
    """.data(using: .utf8)!
    
    static var expectedSwiftCode = #"""
        ["struct FrameSupportWeightsRuntimeDbWeight: CompositeType {", "let read: Weight", "let write: Weight", "}", "extension FrameSupportWeightsRuntimeDbWeight: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "read = try decoder.decode(Weight.self)", "write = try decoder.decode(Weight.self)", "}", "}", "extension TypeInfo.Path {", "static let frameSupportWeightsRuntimeDbWeight: TypeInfo.Path = [\"frame_support\", \"weights\", \"RuntimeDbWeight\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct FrameSupportWeightsRuntimeDbWeight: CompositeType {", "let read: Weight", "let write: Weight", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension FrameSupportWeightsRuntimeDbWeight: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "read = try decoder.decode(Weight.self)", "write = try decoder.decode(Weight.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let frameSupportWeightsRuntimeDbWeight: TypeInfo.Path = [\"frame_support\", \"weights\", \"RuntimeDbWeight\"]", "}"]
    """#.data(using: .utf8)!
}
