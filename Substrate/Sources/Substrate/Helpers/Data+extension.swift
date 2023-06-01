//
//  Created by Steven Boynes on 3/5/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension Data {
    init?(hexadecimal: Hexadecimal) {
        let string = hexadecimal.string
        let len = string.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = string.index(string.startIndex, offsetBy: i*2)
            let k = string.index(j, offsetBy: 2)
            let bytes = string[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            }
        }
        self = data
    }
    
    init(scale: SCALE) {
        self.init(hexadecimal: scale)!
    }
}
