//
//  Created by Steven Boynes on 5/7/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class FrameSupportWeightsWeightToFeeCoefficientTests: XCTestCase {
    
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
                "frame_support",
                "weights",
                "WeightToFeeCoefficient"
            ],
            "params": [{
                "name": "Balance",
                "type": 6
            }],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "coeff_integer",
                            "type": 6,
                            "typeName": "Balance",
                            "docs": []
                        },
                        {
                            "name": "coeff_frac",
                            "type": 147,
                            "typeName": "Perbill",
                            "docs": []
                        },
                        {
                            "name": "negative",
                            "type": 60,
                            "typeName": "bool",
                            "docs": []
                        },
                        {
                            "name": "degree",
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
         }, {
             "id": 4,
             "type": {
                 "path": [],
                 "params": [],
                 "def": {
                     "primitive": "U32"
                 },
                 "docs": []
             }
         }, {
             "id": 6,
             "type": {
                 "path": [],
                 "params": [],
                 "def": {
                     "primitive": "U128"
                 },
                 "docs": []
             }
         }, {
             "id": 8,
             "type": {
                 "path": [],
                 "params": [],
                 "def": {
                     "primitive": "U64"
                 },
                 "docs": []
             }
         }, {
             "id": 60,
             "type": {
                 "path": [],
                 "params": [],
                 "def": {
                     "primitive": "Bool"
                 },
                 "docs": []
             }
         }, {
             "id": 147,
             "type": {
                 "path": [
                     "sp_arithmetic",
                     "per_things",
                     "Perbill"
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
         }]
    """.data(using: .utf8)!
    
    static var expectedSwiftCode = #"""
        ["struct FrameSupportWeightsWeightToFeeCoefficient<Balance>: CompositeType {", "let coeffInteger: Balance", "let coeffFrac: Perbill", "let negative: Bool", "let degree: U8", "}", "extension FrameSupportWeightsWeightToFeeCoefficient: SCALEDecodable where Balance: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "coeffInteger = try decoder.decode(Balance.self)", "coeffFrac = try decoder.decode(Perbill.self)", "negative = try decoder.decode(Bool.self)", "degree = try decoder.decode(U8.self)", "}", "}", "extension TypeInfo.Path {", "static let frameSupportWeightsWeightToFeeCoefficient: TypeInfo.Path = [\"frame_support\", \"weights\", \"WeightToFeeCoefficient\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct FrameSupportWeightsWeightToFeeCoefficient<Balance>: CompositeType {", "let coeffInteger: Balance", "let coeffFrac: Perbill", "let negative: Bool", "let degree: U8", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension FrameSupportWeightsWeightToFeeCoefficient: SCALEDecodable where Balance: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "coeffInteger = try decoder.decode(Balance.self)", "coeffFrac = try decoder.decode(Perbill.self)", "negative = try decoder.decode(Bool.self)", "degree = try decoder.decode(U8.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let frameSupportWeightsWeightToFeeCoefficient: TypeInfo.Path = [\"frame_support\", \"weights\", \"WeightToFeeCoefficient\"]", "}"]
    """#.data(using: .utf8)!
}
