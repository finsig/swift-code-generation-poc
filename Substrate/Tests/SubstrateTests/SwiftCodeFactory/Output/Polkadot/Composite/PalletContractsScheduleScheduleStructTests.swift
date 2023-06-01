//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class PalletContractsScheduleScheduleStructTests: XCTestCase {
    
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
                "pallet_contracts",
                "schedule",
                "Schedule"
            ],
            "params": [{
                "name": "T",
                "type": null
            }],
            "def": {
                "composite": {
                    "fields": [{
                            "name": "limits",
                            "type": 434,
                            "typeName": "Limits",
                            "docs": []
                        },
                        {
                            "name": "instruction_weights",
                            "type": 435,
                            "typeName": "InstructionWeights<T>",
                            "docs": []
                        },
                        {
                            "name": "host_fn_weights",
                            "type": 436,
                            "typeName": "HostFnWeights<T>",
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
           },
           {
               "id": 434,
               "type": {
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
           },
           {
               "id": 435,
               "type": {
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
           },
           {
               "id": 436,
               "type": {
                   "path": [
                       "pallet_contracts",
                       "schedule",
                       "HostFnWeights"
                   ],
                   "params": [{
                       "name": "T",
                       "type": null
                   }],
                   "def": {
                       "composite": {
                           "fields": [{
                                   "name": "caller",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "is_contract",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "caller_is_origin",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "address",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "gas_left",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "balance",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "value_transferred",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "minimum_balance",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "block_number",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "now",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "weight_to_fee",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "gas",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "input",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "input_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "r#return",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "return_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "terminate",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "random",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "deposit_event",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "deposit_event_per_topic",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "deposit_event_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "debug_message",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "set_storage",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "set_storage_per_new_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "set_storage_per_old_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "set_code_hash",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "clear_storage",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "clear_storage_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "contains_storage",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "contains_storage_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "get_storage",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "get_storage_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "take_storage",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "take_storage_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "transfer",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "call",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "delegate_call",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "call_transfer_surcharge",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "call_per_cloned_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "instantiate",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "instantiate_transfer_surcharge",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "instantiate_per_salt_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_sha2_256",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_sha2_256_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_keccak_256",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_keccak_256_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_blake2_256",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_blake2_256_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_blake2_128",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "hash_blake2_128_per_byte",
                                   "type": 8,
                                   "typeName": "Weight",
                                   "docs": []
                               },
                               {
                                   "name": "ecdsa_recover",
                                   "type": 8,
                                   "typeName": "Weight",
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
        ["struct PalletContractsScheduleSchedule: CompositeType {", "let limits: Limits", "let instructionWeights: PalletContractsScheduleInstructionWeights", "let hostFnWeights: PalletContractsScheduleHostFnWeights", "}", "extension PalletContractsScheduleSchedule: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "limits = try decoder.decode(Limits.self)", "instructionWeights = try decoder.decode(PalletContractsScheduleInstructionWeights.self)", "hostFnWeights = try decoder.decode(PalletContractsScheduleHostFnWeights.self)", "}", "}", "extension TypeInfo.Path {", "static let palletContractsScheduleSchedule: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"Schedule\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct PalletContractsScheduleSchedule: CompositeType {", "let limits: Limits", "let instructionWeights: PalletContractsScheduleInstructionWeights", "let hostFnWeights: PalletContractsScheduleHostFnWeights", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension PalletContractsScheduleSchedule: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "limits = try decoder.decode(Limits.self)", "instructionWeights = try decoder.decode(PalletContractsScheduleInstructionWeights.self)", "hostFnWeights = try decoder.decode(PalletContractsScheduleHostFnWeights.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let palletContractsScheduleSchedule: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"Schedule\"]", "}"]
    """#.data(using: .utf8)!
}
