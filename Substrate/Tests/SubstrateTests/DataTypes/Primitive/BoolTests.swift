//
//  Created by Steven Boynes on 3/19/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

/*
import XCTest

@testable import Substrate

final class BoolTests: XCTestCase {
    
    private var registry: TypeInfo.Registry!
    
    override func setUp() async throws {
        registry = TypeInfo.Registry(json: .registry)
    }
    
    func testDecodeMetadataConstantDemocracyInstantAllowed() async throws {
        //let metadata = try JSONDecoder().decode(Metadata.Pallet.Constant.self, from: .democracyInstantAllowed)
        let type = try await registry.type(identifier: Compact(60))
        let data = Data(hexadecimal: metadata.value)!
        
        XCTAssertTrue( type is Bool.Type )
        let value = try SCALEDecoder().decode(Bool.self, from: data)
        XCTAssertEqual( value, true )
    }
}


fileprivate extension Data {
    static var registry = """
        [{
            "id": 60,
            "type": {
                "path": [],
                "params": [],
                "def": {
                    "primitive": "Bool"
                },
                "docs": []
            }
        }]
    """.data(using: .utf8)!
    
    /
    static var democracyInstantAllowed = """
        {
            "name": "InstantAllowed",
            "type": 60,
            "value": "0x01",
            "docs": [
                " Indicator for whether an emergency origin is even allowed to happen. Some chains may",
                " want to set this permanently to `false`, others may want to condition it on things such",
                " as an upgrade having happened recently."
            ]
        }
    """.data(using: .utf8)!
}
*/
