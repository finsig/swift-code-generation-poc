//
//  Created by Steven Boynes on 4/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class PalletContractsScheduleHostFnWeightsStructTests: XCTestCase {
    
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
            }
        ]
    """.data(using: .utf8)!
    
    static var expectedSwiftCode = #"""
        ["struct PalletContractsScheduleHostFnWeights: CompositeType {", "let caller: Weight", "let isContract: Weight", "let callerIsOrigin: Weight", "let address: Weight", "let gasLeft: Weight", "let balance: Weight", "let valueTransferred: Weight", "let minimumBalance: Weight", "let blockNumber: Weight", "let now: Weight", "let weightToFee: Weight", "let gas: Weight", "let input: Weight", "let inputPerByte: Weight", "let r_hashtag_return: Weight", "let returnPerByte: Weight", "let terminate: Weight", "let random: Weight", "let depositEvent: Weight", "let depositEventPerTopic: Weight", "let depositEventPerByte: Weight", "let debugMessage: Weight", "let setStorage: Weight", "let setStoragePerNewByte: Weight", "let setStoragePerOldByte: Weight", "let setCodeHash: Weight", "let clearStorage: Weight", "let clearStoragePerByte: Weight", "let containsStorage: Weight", "let containsStoragePerByte: Weight", "let getStorage: Weight", "let getStoragePerByte: Weight", "let takeStorage: Weight", "let takeStoragePerByte: Weight", "let transfer: Weight", "let call: Weight", "let delegateCall: Weight", "let callTransferSurcharge: Weight", "let callPerClonedByte: Weight", "let instantiate: Weight", "let instantiateTransferSurcharge: Weight", "let instantiatePerSaltByte: Weight", "let hashSha2256: Weight", "let hashSha2256PerByte: Weight", "let hashKeccak256: Weight", "let hashKeccak256PerByte: Weight", "let hashBlake2256: Weight", "let hashBlake2256PerByte: Weight", "let hashBlake2128: Weight", "let hashBlake2128PerByte: Weight", "let ecdsaRecover: Weight", "}", "extension PalletContractsScheduleHostFnWeights: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "caller = try decoder.decode(Weight.self)", "isContract = try decoder.decode(Weight.self)", "callerIsOrigin = try decoder.decode(Weight.self)", "address = try decoder.decode(Weight.self)", "gasLeft = try decoder.decode(Weight.self)", "balance = try decoder.decode(Weight.self)", "valueTransferred = try decoder.decode(Weight.self)", "minimumBalance = try decoder.decode(Weight.self)", "blockNumber = try decoder.decode(Weight.self)", "now = try decoder.decode(Weight.self)", "weightToFee = try decoder.decode(Weight.self)", "gas = try decoder.decode(Weight.self)", "input = try decoder.decode(Weight.self)", "inputPerByte = try decoder.decode(Weight.self)", "r_hashtag_return = try decoder.decode(Weight.self)", "returnPerByte = try decoder.decode(Weight.self)", "terminate = try decoder.decode(Weight.self)", "random = try decoder.decode(Weight.self)", "depositEvent = try decoder.decode(Weight.self)", "depositEventPerTopic = try decoder.decode(Weight.self)", "depositEventPerByte = try decoder.decode(Weight.self)", "debugMessage = try decoder.decode(Weight.self)", "setStorage = try decoder.decode(Weight.self)", "setStoragePerNewByte = try decoder.decode(Weight.self)", "setStoragePerOldByte = try decoder.decode(Weight.self)", "setCodeHash = try decoder.decode(Weight.self)", "clearStorage = try decoder.decode(Weight.self)", "clearStoragePerByte = try decoder.decode(Weight.self)", "containsStorage = try decoder.decode(Weight.self)", "containsStoragePerByte = try decoder.decode(Weight.self)", "getStorage = try decoder.decode(Weight.self)", "getStoragePerByte = try decoder.decode(Weight.self)", "takeStorage = try decoder.decode(Weight.self)", "takeStoragePerByte = try decoder.decode(Weight.self)", "transfer = try decoder.decode(Weight.self)", "call = try decoder.decode(Weight.self)", "delegateCall = try decoder.decode(Weight.self)", "callTransferSurcharge = try decoder.decode(Weight.self)", "callPerClonedByte = try decoder.decode(Weight.self)", "instantiate = try decoder.decode(Weight.self)", "instantiateTransferSurcharge = try decoder.decode(Weight.self)", "instantiatePerSaltByte = try decoder.decode(Weight.self)", "hashSha2256 = try decoder.decode(Weight.self)", "hashSha2256PerByte = try decoder.decode(Weight.self)", "hashKeccak256 = try decoder.decode(Weight.self)", "hashKeccak256PerByte = try decoder.decode(Weight.self)", "hashBlake2256 = try decoder.decode(Weight.self)", "hashBlake2256PerByte = try decoder.decode(Weight.self)", "hashBlake2128 = try decoder.decode(Weight.self)", "hashBlake2128PerByte = try decoder.decode(Weight.self)", "ecdsaRecover = try decoder.decode(Weight.self)", "}", "}", "extension TypeInfo.Path {", "static let palletContractsScheduleHostFnWeights: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"HostFnWeights\"]", "}"]
    """#.data(using: .utf8)!
    
    static var expectedStructCode = #"""
        ["struct PalletContractsScheduleHostFnWeights: CompositeType {", "let caller: Weight", "let isContract: Weight", "let callerIsOrigin: Weight", "let address: Weight", "let gasLeft: Weight", "let balance: Weight", "let valueTransferred: Weight", "let minimumBalance: Weight", "let blockNumber: Weight", "let now: Weight", "let weightToFee: Weight", "let gas: Weight", "let input: Weight", "let inputPerByte: Weight", "let r_hashtag_return: Weight", "let returnPerByte: Weight", "let terminate: Weight", "let random: Weight", "let depositEvent: Weight", "let depositEventPerTopic: Weight", "let depositEventPerByte: Weight", "let debugMessage: Weight", "let setStorage: Weight", "let setStoragePerNewByte: Weight", "let setStoragePerOldByte: Weight", "let setCodeHash: Weight", "let clearStorage: Weight", "let clearStoragePerByte: Weight", "let containsStorage: Weight", "let containsStoragePerByte: Weight", "let getStorage: Weight", "let getStoragePerByte: Weight", "let takeStorage: Weight", "let takeStoragePerByte: Weight", "let transfer: Weight", "let call: Weight", "let delegateCall: Weight", "let callTransferSurcharge: Weight", "let callPerClonedByte: Weight", "let instantiate: Weight", "let instantiateTransferSurcharge: Weight", "let instantiatePerSaltByte: Weight", "let hashSha2256: Weight", "let hashSha2256PerByte: Weight", "let hashKeccak256: Weight", "let hashKeccak256PerByte: Weight", "let hashBlake2256: Weight", "let hashBlake2256PerByte: Weight", "let hashBlake2128: Weight", "let hashBlake2128PerByte: Weight", "let ecdsaRecover: Weight", "}"]
    """#.data(using: .utf8)!
    
    static var expectedSCALEDecodableExtensionCode = #"""
        ["extension PalletContractsScheduleHostFnWeights: SCALEDecodable {", "init(from decoder: SCALE.Decoder) throws {", "caller = try decoder.decode(Weight.self)", "isContract = try decoder.decode(Weight.self)", "callerIsOrigin = try decoder.decode(Weight.self)", "address = try decoder.decode(Weight.self)", "gasLeft = try decoder.decode(Weight.self)", "balance = try decoder.decode(Weight.self)", "valueTransferred = try decoder.decode(Weight.self)", "minimumBalance = try decoder.decode(Weight.self)", "blockNumber = try decoder.decode(Weight.self)", "now = try decoder.decode(Weight.self)", "weightToFee = try decoder.decode(Weight.self)", "gas = try decoder.decode(Weight.self)", "input = try decoder.decode(Weight.self)", "inputPerByte = try decoder.decode(Weight.self)", "r_hashtag_return = try decoder.decode(Weight.self)", "returnPerByte = try decoder.decode(Weight.self)", "terminate = try decoder.decode(Weight.self)", "random = try decoder.decode(Weight.self)", "depositEvent = try decoder.decode(Weight.self)", "depositEventPerTopic = try decoder.decode(Weight.self)", "depositEventPerByte = try decoder.decode(Weight.self)", "debugMessage = try decoder.decode(Weight.self)", "setStorage = try decoder.decode(Weight.self)", "setStoragePerNewByte = try decoder.decode(Weight.self)", "setStoragePerOldByte = try decoder.decode(Weight.self)", "setCodeHash = try decoder.decode(Weight.self)", "clearStorage = try decoder.decode(Weight.self)", "clearStoragePerByte = try decoder.decode(Weight.self)", "containsStorage = try decoder.decode(Weight.self)", "containsStoragePerByte = try decoder.decode(Weight.self)", "getStorage = try decoder.decode(Weight.self)", "getStoragePerByte = try decoder.decode(Weight.self)", "takeStorage = try decoder.decode(Weight.self)", "takeStoragePerByte = try decoder.decode(Weight.self)", "transfer = try decoder.decode(Weight.self)", "call = try decoder.decode(Weight.self)", "delegateCall = try decoder.decode(Weight.self)", "callTransferSurcharge = try decoder.decode(Weight.self)", "callPerClonedByte = try decoder.decode(Weight.self)", "instantiate = try decoder.decode(Weight.self)", "instantiateTransferSurcharge = try decoder.decode(Weight.self)", "instantiatePerSaltByte = try decoder.decode(Weight.self)", "hashSha2256 = try decoder.decode(Weight.self)", "hashSha2256PerByte = try decoder.decode(Weight.self)", "hashKeccak256 = try decoder.decode(Weight.self)", "hashKeccak256PerByte = try decoder.decode(Weight.self)", "hashBlake2256 = try decoder.decode(Weight.self)", "hashBlake2256PerByte = try decoder.decode(Weight.self)", "hashBlake2128 = try decoder.decode(Weight.self)", "hashBlake2128PerByte = try decoder.decode(Weight.self)", "ecdsaRecover = try decoder.decode(Weight.self)", "}", "}"]
    """#.data(using: .utf8)!
    
    static var expectedPathExtensionCode = #"""
        ["extension TypeInfo.Path {", "static let palletContractsScheduleHostFnWeights: TypeInfo.Path = [\"pallet_contracts\", \"schedule\", \"HostFnWeights\"]", "}"]
    """#.data(using: .utf8)!
}
