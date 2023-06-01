//
//  Created by Steven Boynes on 5/7/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class GiltTests: XCTestCase {
    
    private var runtime: Runtime!
    private var palletName: String!
    private var factory: SwiftCodeFactory!
    
    override func setUp() async throws {
        runtime = TestRuntime()
        palletName = String(describing: type(of: self)).replacingOccurrences(of: "Tests", with: String.empty)
        factory = try await SwiftCodeFactory(runtime: runtime)
    }

     func testMakeConstantsSwiftCode() async throws {
        guard let metadata = try Metadata.pallet(name: palletName, runtime: runtime, version: .versionKey) else {
            throw XCTSkip("Pallet metadata not found.")
        }
        let output = try await factory.makePalletConstants(metadata: metadata)
        let expected = try ExpectedSwiftCode(palletName: palletName, runtime: runtime)
        XCTAssertEqual(output.code.lines, expected.lines)
    }
}
