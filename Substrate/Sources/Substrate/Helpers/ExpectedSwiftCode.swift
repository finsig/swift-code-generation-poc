//
//  Created by Steven Boynes on 5/22/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

/// A block of Swift code.
///
typealias ExpectedSwiftCode = SwiftCode.Block


extension ExpectedSwiftCode {
    init(palletName: String, runtime: Runtime) throws {
        let code = try JSONDecoder().decode([ExpectedSwiftCode].self, from: Data(contentsOf: runtime.expectedSwiftCodeURL) )
        guard let expected = code.filter({ $0.name.caseInsensitiveCompare(palletName) == .orderedSame }).last else {
            self.init(name: palletName, lines: SwiftCode.Lines())
            return
        }
        self.init(name: palletName, lines: expected.lines)
    }
}
