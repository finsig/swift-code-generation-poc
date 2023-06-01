//
//  Created by Steven Boynes on 3/19/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

/*
import XCTest

@testable import Substrate

final class ArrayTests: XCTestCase {
    
    private var registry: TypeInfo.Registry!
    
    override func setUp() async throws {
        registry = TypeInfo.Registry(json: .registry)
    }
    
    func testDecodeMetadataConstantElectionsPalletId() async throws {
        let metadata = try JSONDecoder().decode(Metadata.Pallet.Constant.self, from: .electionsPalletId)
        let type = try await registry.type(for: metadata)
        let data = Data(hexadecimal: metadata.value)!
        
        XCTAssertTrue( type is EightElementArray<U8>.Type )
        let value = try SCALEDecoder().decode(EightElementArray<U8>.self, from: data)
        print("value= \(value)")
    }
}

fileprivate extension Data {
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
        }]
    """.data(using: .utf8)!
    
    static var electionsPalletId = """
        {
            "name": "PalletId",
            "type": 123,
            "value": "0x706872656c656374",
            "docs": [
                " Identifier for the elections-phragmen pallet's lock"
            ]
        }
    """.data(using: .utf8)!
}
*/
