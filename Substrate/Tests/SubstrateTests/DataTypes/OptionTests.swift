//
//  Created by Steven Boynes on 3/28/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

/*
import XCTest

@testable import Substrate
import ScaleCodec

final class OptionTests: XCTestCase {
    
    private var registry: TypeInfo.Registry!
    
    override func setUp() async throws {
        registry = TypeInfo.Registry(json: .registry)
    }
    
    func testDecodeMetadataConstantProposalBondMaximum() async throws {
        let metadata = try JSONDecoder().decode(Metadata.Pallet.Constant.self, from: .proposalBondMaximum)
        
        let data = Data(hexadecimal: metadata.value)!
        
        let type = try await registry.type(for: metadata)
        XCTAssertTrue( type is U128?.Type )
        let value = try SCALEDecoder().decode(Optional<U128>.self, from: data)
        XCTAssertNil( value )

        // let proposalBondMaximum: Optional<U128> = decoded-value
    }
}

fileprivate extension Data {
    static var registry = """
        [{
                "id": 6,
                "type": {
                    "path": [],
                    "params": [],
                    "def": {
                        "primitive": "U128"
                    },
                    "docs": []
                }
            },
            {
                "id": 425,
                "type": {
                    "path": [
                        "Option"
                    ],
                    "params": [{
                        "name": "T",
                        "type": 6
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
                                        "type": 6,
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
    
    static var proposalBondMaximum = """
        {
            "name": "ProposalBondMaximum",
            "type": 425,
            "value": "0x00",
            "docs": [
                " Maximum amount of funds that should be placed in a deposit for making a proposal."
            ]
        }
    """.data(using: .utf8)!
}
*/
