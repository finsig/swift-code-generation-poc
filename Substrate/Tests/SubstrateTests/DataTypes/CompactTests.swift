//
//  Created by Steven Boynes on 3/5/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import XCTest

@testable import Substrate

final class CompactTests: XCTestCase {
    func testNotEqualType() throws {
        let lhs = Compact( U32(1) )
        let rhs = Compact( U64(1) )
        
        XCTAssertTrue( type(of: lhs.value) != type(of: rhs.value) )
    }
}
