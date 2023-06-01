//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class PalletContractsScheduleInstructionWeightsStructTests: XCTestCase {
    
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
                "InstructionWeights"
            ],
            "params": [{
                "name": "T",
                "type": null
            }],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "version",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64const",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64load",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64store",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "select",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "r#if",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "br",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "br_if",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "br_table",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "br_table_per_entry",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "call",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "call_indirect",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "call_indirect_per_param",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "local_get",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "local_set",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "local_tee",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "global_get",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "global_set",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "memory_current",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "memory_grow",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64clz",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64ctz",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64popcnt",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64eqz",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64extendsi32",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64extendui32",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i32wrapi64",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64eq",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64ne",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64lts",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64ltu",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64gts",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64gtu",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64les",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64leu",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64ges",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64geu",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64add",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64sub",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64mul",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64divs",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64divu",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64rems",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64remu",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64and",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64or",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64xor",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64shl",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64shrs",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64shru",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64rotl",
                            "type": 4,
                            "typeName": "u32",
                            "docs": []
                        },
                        {
                            "name": "i64rotr",
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
        ["struct PalletContractsScheduleInstructionWeights: CompositeType {", "let version: U32", "let i64const: U32", "let i64load: U32", "let i64store: U32", "let select: U32", "let r_hashtag_if: U32", "let br: U32", "let brIf: U32", "let brTable: U32", "let brTablePerEntry: U32", "let call: U32", "let callIndirect: U32", "let callIndirectPerParam: U32", "let localGet: U32", "let localSet: U32", "let localTee: U32", "let globalGet: U32", "let globalSet: U32", "let memoryCurrent: U32", "let memoryGrow: U32", "let i64clz: U32", "let i64ctz: U32", "let i64popcnt: U32", "let i64eqz: U32", "let i64extendsi32: U32", "let i64extendui32: U32", "let i32wrapi64: U32", "let i64eq: U32", "let i64ne: U32", "let i64lts: U32", "let i64ltu: U32", "let i64gts: U32", "let i64gtu: U32", "let i64les: U32", "let i64leu: U32", "let i64ges: U32", "let i64geu: U32", "let i64add: U32", "let i64sub: U32", "let i64mul: U32", "let i64divs: U32", "let i64divu: U32", "let i64rems: U32", "let i64remu: U32", "let i64and: U32", "let i64or: U32", "let i64xor: U32", "let i64shl: U32", "let i64shrs: U32", "let i64shru: U32", "let i64rotl: U32", "let i64rotr: U32", "}", "extension PalletContractsScheduleInstructionWeights: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "version = try decoder.decode(U32.self)", "i64const = try decoder.decode(U32.self)", "i64load = try decoder.decode(U32.self)", "i64store = try decoder.decode(U32.self)", "select = try decoder.decode(U32.self)", "r_hashtag_if = try decoder.decode(U32.self)", "br = try decoder.decode(U32.self)", "brIf = try decoder.decode(U32.self)", "brTable = try decoder.decode(U32.self)", "brTablePerEntry = try decoder.decode(U32.self)", "call = try decoder.decode(U32.self)", "callIndirect = try decoder.decode(U32.self)", "callIndirectPerParam = try decoder.decode(U32.self)", "localGet = try decoder.decode(U32.self)", "localSet = try decoder.decode(U32.self)", "localTee = try decoder.decode(U32.self)", "globalGet = try decoder.decode(U32.self)", "globalSet = try decoder.decode(U32.self)", "memoryCurrent = try decoder.decode(U32.self)", "memoryGrow = try decoder.decode(U32.self)", "i64clz = try decoder.decode(U32.self)", "i64ctz = try decoder.decode(U32.self)", "i64popcnt = try decoder.decode(U32.self)", "i64eqz = try decoder.decode(U32.self)", "i64extendsi32 = try decoder.decode(U32.self)", "i64extendui32 = try decoder.decode(U32.self)", "i32wrapi64 = try decoder.decode(U32.self)", "i64eq = try decoder.decode(U32.self)", "i64ne = try decoder.decode(U32.self)", "i64lts = try decoder.decode(U32.self)", "i64ltu = try decoder.decode(U32.self)", "i64gts = try decoder.decode(U32.self)", "i64gtu = try decoder.decode(U32.self)", "i64les = try decoder.decode(U32.self)", "i64leu = try decoder.decode(U32.self)", "i64ges = try decoder.decode(U32.self)", "i64geu = try decoder.decode(U32.self)", "i64add = try decoder.decode(U32.self)", "i64sub = try decoder.decode(U32.self)", "i64mul = try decoder.decode(U32.self)", "i64divs = try decoder.decode(U32.self)", "i64divu = try decoder.decode(U32.self)", "i64rems = try decoder.decode(U32.self)", "i64remu = try decoder.decode(U32.self)", "i64and = try decoder.decode(U32.self)", "i64or = try decoder.decode(U32.self)", "i64xor = try decoder.decode(U32.self)", "i64shl = try decoder.decode(U32.self)", "i64shrs = try decoder.decode(U32.self)", "i64shru = try decoder.decode(U32.self)", "i64rotl = try decoder.decode(U32.self)", "i64rotr = try decoder.decode(U32.self)", "}", "}", "extension TypeInfo.Path {", "static let palletContractsScheduleInstructionWeights: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"InstructionWeights\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct PalletContractsScheduleInstructionWeights: CompositeType {", "let version: U32", "let i64const: U32", "let i64load: U32", "let i64store: U32", "let select: U32", "let r_hashtag_if: U32", "let br: U32", "let brIf: U32", "let brTable: U32", "let brTablePerEntry: U32", "let call: U32", "let callIndirect: U32", "let callIndirectPerParam: U32", "let localGet: U32", "let localSet: U32", "let localTee: U32", "let globalGet: U32", "let globalSet: U32", "let memoryCurrent: U32", "let memoryGrow: U32", "let i64clz: U32", "let i64ctz: U32", "let i64popcnt: U32", "let i64eqz: U32", "let i64extendsi32: U32", "let i64extendui32: U32", "let i32wrapi64: U32", "let i64eq: U32", "let i64ne: U32", "let i64lts: U32", "let i64ltu: U32", "let i64gts: U32", "let i64gtu: U32", "let i64les: U32", "let i64leu: U32", "let i64ges: U32", "let i64geu: U32", "let i64add: U32", "let i64sub: U32", "let i64mul: U32", "let i64divs: U32", "let i64divu: U32", "let i64rems: U32", "let i64remu: U32", "let i64and: U32", "let i64or: U32", "let i64xor: U32", "let i64shl: U32", "let i64shrs: U32", "let i64shru: U32", "let i64rotl: U32", "let i64rotr: U32", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension PalletContractsScheduleInstructionWeights: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "version = try decoder.decode(U32.self)", "i64const = try decoder.decode(U32.self)", "i64load = try decoder.decode(U32.self)", "i64store = try decoder.decode(U32.self)", "select = try decoder.decode(U32.self)", "r_hashtag_if = try decoder.decode(U32.self)", "br = try decoder.decode(U32.self)", "brIf = try decoder.decode(U32.self)", "brTable = try decoder.decode(U32.self)", "brTablePerEntry = try decoder.decode(U32.self)", "call = try decoder.decode(U32.self)", "callIndirect = try decoder.decode(U32.self)", "callIndirectPerParam = try decoder.decode(U32.self)", "localGet = try decoder.decode(U32.self)", "localSet = try decoder.decode(U32.self)", "localTee = try decoder.decode(U32.self)", "globalGet = try decoder.decode(U32.self)", "globalSet = try decoder.decode(U32.self)", "memoryCurrent = try decoder.decode(U32.self)", "memoryGrow = try decoder.decode(U32.self)", "i64clz = try decoder.decode(U32.self)", "i64ctz = try decoder.decode(U32.self)", "i64popcnt = try decoder.decode(U32.self)", "i64eqz = try decoder.decode(U32.self)", "i64extendsi32 = try decoder.decode(U32.self)", "i64extendui32 = try decoder.decode(U32.self)", "i32wrapi64 = try decoder.decode(U32.self)", "i64eq = try decoder.decode(U32.self)", "i64ne = try decoder.decode(U32.self)", "i64lts = try decoder.decode(U32.self)", "i64ltu = try decoder.decode(U32.self)", "i64gts = try decoder.decode(U32.self)", "i64gtu = try decoder.decode(U32.self)", "i64les = try decoder.decode(U32.self)", "i64leu = try decoder.decode(U32.self)", "i64ges = try decoder.decode(U32.self)", "i64geu = try decoder.decode(U32.self)", "i64add = try decoder.decode(U32.self)", "i64sub = try decoder.decode(U32.self)", "i64mul = try decoder.decode(U32.self)", "i64divs = try decoder.decode(U32.self)", "i64divu = try decoder.decode(U32.self)", "i64rems = try decoder.decode(U32.self)", "i64remu = try decoder.decode(U32.self)", "i64and = try decoder.decode(U32.self)", "i64or = try decoder.decode(U32.self)", "i64xor = try decoder.decode(U32.self)", "i64shl = try decoder.decode(U32.self)", "i64shrs = try decoder.decode(U32.self)", "i64shru = try decoder.decode(U32.self)", "i64rotl = try decoder.decode(U32.self)", "i64rotr = try decoder.decode(U32.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let palletContractsScheduleInstructionWeights: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"InstructionWeights\"]", "}"]
    """#.data(using: .utf8)!
}
