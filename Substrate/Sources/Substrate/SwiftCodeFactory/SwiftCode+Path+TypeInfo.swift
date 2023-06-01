//
//  Created by Steven Boynes on 1/23/23.
//  Copyright © 2023 Finsig LLC. All rights reserved.
//

import Foundation

extension SwiftCode.Path {
    
    init(_ typeInfo: TypeInfo) {
        
        var mutablePath = SwiftCode.Path(typeInfo.path)
        
        if typeInfo.parameters.compactMap({ $0.type }).isEmpty == false {
            mutablePath.removeLast()
            let itemName = typeInfo.path.last!.uppercasingFirstLetter() + "<" + typeInfo.parameters.map({ $0.name.uppercasingFirstLetter() }).joined(separator: ",") + ">"
            mutablePath.append(itemName)
        }
        
        self.init(array: mutablePath)
    }
}
