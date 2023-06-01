//
//  Created by Steven Boynes on 5/11/22.
//  Copyright © 2022 Finsig LLC. All rights reserved.
//

import Foundation

extension Array where Element == String {
    var camelCased: String {
        return self.reduce(String(""), {
            $0 + $1.components(separatedBy: "_").map({ $0.uppercasingFirstLetter() }).joined()
        })
    }
}
