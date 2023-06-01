//
//  Created by Steven Boynes on 3/31/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCode {
    ///
    /// A struct that represents a block of Swift code.
    ///
    struct Block {
        var name: String
        var lines: Lines
        
        init(name: String = .empty, lines: Lines = Lines()) {
            self.name = name
            self.lines = lines
        }
    }
}


extension SwiftCode.Block: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case lines = "lines"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        lines = try container.decode(SwiftCode.Lines.self, forKey: .lines)
    }
}
