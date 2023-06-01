//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class FrameSupportWeightsPerDispatchClassStructTests: XCTestCase {
    
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
                "frame_support",
                "weights",
                "PerDispatchClass"
            ],
            "params": [{
                "name": "T",
                "type": 4
            }],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "normal",
                            "type": 4,
                            "typeName": "T",
                            "docs": []
                        },
                        {
                            "name": "operational",
                            "type": 4,
                            "typeName": "T",
                            "docs": []
                        },
                        {
                            "name": "mandatory",
                            "type": 4,
                            "typeName": "T",
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
        ["struct FrameSupportWeightsPerDispatchClass<T>: CompositeType {", "let normal: T", "let operational: T", "let mandatory: T", "}", "extension FrameSupportWeightsPerDispatchClass: SCALEDecodable where T: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "normal = try decoder.decode(T.self)", "operational = try decoder.decode(T.self)", "mandatory = try decoder.decode(T.self)", "}", "}", "extension TypeInfo.Path {", "static let frameSupportWeightsPerDispatchClass: TypeInfo.Path = [\"frame_support\", \"weights\", \"PerDispatchClass\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct FrameSupportWeightsPerDispatchClass<T>: CompositeType {", "let normal: T", "let operational: T", "let mandatory: T", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension FrameSupportWeightsPerDispatchClass: SCALEDecodable where T: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "normal = try decoder.decode(T.self)", "operational = try decoder.decode(T.self)", "mandatory = try decoder.decode(T.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let frameSupportWeightsPerDispatchClass: TypeInfo.Path = [\"frame_support\", \"weights\", \"PerDispatchClass\"]", "}"]
    """#.data(using: .utf8)!
}
