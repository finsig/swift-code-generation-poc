//
//  Created by Steven Boynes on 2/25/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

/*
import XCTest

@testable import Substrate

final class U64Tests: XCTestCase {
    
    private var registry: TypeInfo.Registry!
    
    override func setUp() async throws {
        registry = TypeInfo.Registry(json: .registry)
    }
    
    func testDecodeMetadataConstantBabeEpochDuration() async throws {
        let metadata = try JSONDecoder().decode(Metadata.Pallet.Constant.self, from: .babeEpochDuration)
        let type = try await registry.type(for: metadata)
        let data = Data(hexadecimal: metadata.value)!
        
        XCTAssertTrue( type is U64.Type )
        let value = try SCALEDecoder().decode(U64.self, from: data)
        XCTAssertEqual( value, U64(2400) )
    }
}

fileprivate extension Data {
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
    
    static var babeEpochDuration = """
        {
            "name": "EpochDuration",
            "type": 8,
            "value": "0x6009000000000000",
            "docs": [
                " The amount of time, in slots, that each epoch should last.",
                " NOTE: Currently it is not possible to change the epoch duration after",
                " the chain has started. Attempting to do so will brick block production."
            ]
        }
    """.data(using: .utf8)!
}
*/
